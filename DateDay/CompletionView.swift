//
//  CompletionView.swift
//  DateDay
//
//  Created by Quentin Derouard on 14/05/2024.
//

import SwiftUI

struct CompletionView: View {
    @Binding var isSignedIn: Bool
    @Binding var user: User?

    var body: some View {
        VStack {
            Spacer()

            Text("Bienvenue sur DateDay")
                .font(.custom("Freeman-Regular", size: 30))
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding()

            Text("Vous avez terminé la première étape de votre inscription ! Désormais, tu vas devoir répondre à une série de questions nous permettant de te mettre en relation avec les personnes les plus compatibles avec toi ! Ne t'en fais pas, ce n'est pas très long et ce sont tes réponses qui vont nous permettre de vraiment cibler ton prochain Date ! 😍")
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding()

            Spacer()

            NavigationLink(destination: GeneralQuestionnaireView(user: $user, isSignedIn: $isSignedIn)) {
                Text("Commencer")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
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
        .navigationBarBackButtonHidden(true)
    }
}

struct CompletionView_Previews: PreviewProvider {
    static var previews: some View {
        CompletionView(isSignedIn: .constant(false), user: .constant(nil))
    }
}

