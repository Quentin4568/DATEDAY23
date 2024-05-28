//
//  IdealPartnerQuestionnaireView.swift
//  DateDay
//
//  Created by Quentin Derouard on 21/05/2024.
//

import SwiftUI

struct IdealPartnerQuestionnaireView: View {
    @State private var currentPage = 0
    @State private var answers: [UUID: String] = [:]
    @State private var showSelfDescriptionPopup = false

    var body: some View {
        VStack {
            Text("Partenaire Idéal")
                .font(.custom("Freeman-Regular", size: 24))
                .foregroundColor(.white)
                .padding()

            QuestionPageView(questions: Array(idealPartnerQuestions[currentPage..<min(currentPage + 2, idealPartnerQuestions.count)]), answers: $answers)

            Button(action: {
                if currentPage + 2 < idealPartnerQuestions.count {
                    currentPage += 2
                } else {
                    showSelfDescriptionPopup = true
                }
            }) {
                Text(currentPage + 2 < idealPartnerQuestions.count ? "Suivant" : "Terminer")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }

            NavigationLink(destination: SelfDescriptionPopupView(), isActive: $showSelfDescriptionPopup) {
                EmptyView()
            }
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

struct IdealPartnerQuestionnaireView_Previews: PreviewProvider {
    static var previews: some View {
        IdealPartnerQuestionnaireView()
    }
}
