//
//  signInWithGoogle.swift
//  DateDay
//
//  Created by Quentin Derouard on 19/05/2024.
//

import Foundation
import Firebase
import GoogleSignIn

class SignInWithGoogle {
    static let shared = SignInWithGoogle()
    
    private init() {}
    
    func signIn(completion: @escaping (Result<User, Error>) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)

        GIDSignIn.sharedInstance.signIn(withPresenting: getRootViewController()) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Missing auth object off of google user"])))
                return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)

            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let authResult = authResult else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Missing authResult"])))
                    return
                }

                let user = User(id: authResult.user.uid, name: user.profile?.name ?? "", gender: .male, sexualOrientation: .heterosexual, answers: [:])
                completion(.success(user))
            }
        }
    }

    private func getRootViewController() -> UIViewController {
        return UIApplication.shared.windows.first!.rootViewController!
    }
}
