//
//  LoginView.swift
//  DateDay
//
//  Created by Quentin Derouard on 14/05/2024.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @Binding var isSignedIn: Bool
    @Binding var user: User?

    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack {
            Text("Connectes-toi")
                .font(.custom("Freeman-Regular", size: 24))
                .foregroundColor(.white)
                .padding()

            TextField("Adresse mail", text: $email)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)

            SecureField("Mot de passe", text: $password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)

            Button(action: {
                login()
            }) {
                Text("Se connecter")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.top)
            }

            Spacer()
        }
        .background(
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                HeartAnimationView()
            }
        )
        .navigationTitle("Connexion")
    }

    private func login() {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Erreur lors de la connexion: \(error.localizedDescription)")
                return
            }
            guard let authResult = authResult else {
                print("Erreur inconnue")
                return
            }
            self.user = User(id: UUID(), name: authResult.user.displayName ?? "", gender: .male, sexualOrientation: .heterosexual, answers: [:])
            self.isSignedIn = true
        }
    }
}
