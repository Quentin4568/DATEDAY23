//
//  SelfDescriptionPopupView.swift
//  DateDay
//
//  Created by Quentin Derouard on 21/05/2024.
//

import SwiftUI

struct SelfDescriptionPopupView: View {
    @State private var navigateToSelfDescriptionQuestionnaire = false
    @Binding var user: User?

    var body: some View {
        VStack {
            Spacer()

            Text("Comment te décrirais-tu ? 😎")
                .font(.custom("Freeman-Regular", size: 24))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()

            Spacer()

            NavigationLink(destination: SelfDescriptionQuestionnaireView(user: $user), isActive: $navigateToSelfDescriptionQuestionnaire) {
                Text("Suivant")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.top)
                    .onTapGesture {
                        navigateToSelfDescriptionQuestionnaire = true
                    }
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

struct SelfDescriptionPopupView_Previews: PreviewProvider {
    static var previews: some View {
        SelfDescriptionPopupView(user: .constant(nil))
    }
}
