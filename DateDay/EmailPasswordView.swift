//
//  EmailPasswordView.swift
//  DateDay
//
//  Created by Quentin Derouard on 14/05/2024.
//

import SwiftUI
import FirebaseAuth
import Firebase
import GoogleSignIn
import AuthenticationServices

struct EmailPasswordView: View {
    @Binding var isSignedIn: Bool
    @Binding var user: User?

    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var emailVerificationSent = false
    @State private var isEmailVerified = false
    @State private var navigateToBirthDateView = false

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Retour")
                        .foregroundColor(.white)
                }
                Spacer()
                Text("Inscription")
                    .font(.custom("Lobster-Regular", size: 24))
                    .foregroundColor(.white)
                Spacer()
                Spacer().frame(width: 60)
            }
            .padding()

            Spacer()

            Text("Nous avons besoin de ton adresse mail et que tu définisses un mot de passe")
                .font(.custom("Lobster-Regular", size: 24))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()

            Spacer().frame(height: 20)

            TextField("Adresse mail", text: $email)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
                .autocapitalization(.none)
                .disableAutocorrection(true)

            SecureField("Mot de passe", text: $password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)

            NavigationLink(destination: BirthDateView(isSignedIn: $isSignedIn, user: $user), isActive: $navigateToBirthDateView) {
                EmptyView()
            }

            Button(action: {
                createUser()
            }) {
                Text("S'inscrire")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.purple)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.top)
            }

            HStack {
                Button(action: {
                    signInWithGoogle()
                }) {
                    HStack {
                        Image(systemName: "globe")
                        Text("Continuer avec Google")
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.top)
                }
                .frame(height: 44)
                .cornerRadius(22)
                .padding()

                SignInWithAppleButton(
                    onRequest: { request in
                        request.requestedScopes = [.fullName, .email]
                    },
                    onCompletion: { result in
                        switch result {
                        case .success(let authResults):
                            handleAppleAuth(authResults)
                        case .failure(let error):
                            self.errorMessage = error.localizedDescription
                            self.showError = true
                        }
                    }
                )
                .signInWithAppleButtonStyle(.black)
                .frame(height: 44)
                .cornerRadius(22)
                .padding()
            }

            Spacer()

            if showError {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .background(
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                HeartAnimationView()
            }
        )
        .navigationBarBackButtonHidden(true)
        .alert(isPresented: $emailVerificationSent) {
            Alert(
                title: Text("E-mail de vérification envoyé"),
                message: Text("Un e-mail de vérification a été envoyé à \(email). Veuillez vérifier votre boîte mail."),
                dismissButton: .default(Text("OK"))
            )
        }
    }

    private func createUser() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                self.showError = true
                return
            }
            guard let authResult = authResult else {
                self.errorMessage = "Erreur inconnue"
                self.showError = true
                return
            }

            authResult.user.sendEmailVerification { error in
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    self.showError = true
                    return
                }

                self.emailVerificationSent = true
                self.errorMessage = ""
                self.showError = false

                // Commence à vérifier périodiquement si l'e-mail a été vérifié
                startEmailVerificationCheck()
            }
        }
    }

    private func startEmailVerificationCheck() {
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { timer in
            Auth.auth().currentUser?.reload { error in
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    self.showError = true
                    return
                }

                if Auth.auth().currentUser?.isEmailVerified == true {
                    timer.invalidate()
                    // Naviguer vers la vue BirthDateView
                    self.user = User(id: UUID().uuidString, name: email, gender: .male, sexualOrientation: .heterosexual, answers: [:])
                    self.navigateToBirthDateView = true
                }
            }
        }
    }

    private func signInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)

        GIDSignIn.sharedInstance.signIn(withPresenting: getRootViewController()) { result, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                self.showError = true
                return
            }

            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                self.errorMessage = "Erreur inconnue"
                self.showError = true
                return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)

            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    self.showError = true
                    return
                }

                guard let authResult = authResult else {
                    self.errorMessage = "Erreur inconnue"
                    self.showError = true
                    return
                }

                self.user = User(id: authResult.user.uid, name: user.profile?.name ?? "", gender: .male, sexualOrientation: .heterosexual, answers: [:])
                self.navigateToBirthDateView = true
            }
        }
    }

    private func handleAppleAuth(_ authResults: ASAuthorization) {
        switch authResults.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            guard let idToken = appleIDCredential.identityToken else {
                self.errorMessage = "Erreur lors de la récupération du token"
                self.showError = true
                return
            }

            guard let idTokenString = String(data: idToken, encoding: .utf8) else {
                self.errorMessage = "Erreur lors de la conversion du token"
                self.showError = true
                return
            }

            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: "")

            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    self.showError = true
                    return
                }

                guard let authResult = authResult else {
                    self.errorMessage = "Erreur inconnue"
                    self.showError = true
                    return
                }

                self.user = User(id: authResult.user.uid, name: appleIDCredential.fullName?.givenName ?? "Utilisateur Apple", gender: .male, sexualOrientation: .heterosexual, answers: [:])
                self.navigateToBirthDateView = true
            }
        default:
            break
        }
    }

    private func getRootViewController() -> UIViewController {
        return UIApplication.shared.windows.first?.rootViewController ?? UIViewController()
    }
}
