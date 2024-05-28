//
//  IdealPartnerPopupView.swift
//  DateDay
//
//  Created by Quentin Derouard on 21/05/2024.
//

import SwiftUI

struct IdealPartnerPopupView: View {
    @State private var navigateToIdealPartnerQuestionnaire = false

    var body: some View {
        VStack {
            Spacer()

            Text("Maintenant, dis-nous comment serait ton partenaire idéal ?😏")
                .font(.custom("Freeman-Regular", size: 24))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()

            Spacer()

            NavigationLink(destination: IdealPartnerQuestionnaireView(), isActive: $navigateToIdealPartnerQuestionnaire) {
                Text("Suivant")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.top)
                    .onTapGesture {
                        navigateToIdealPartnerQuestionnaire = true
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

struct IdealPartnerPopupView_Previews: PreviewProvider {
    static var previews: some View {
        IdealPartnerPopupView()
    }
}

