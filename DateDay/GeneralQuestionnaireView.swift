//
//  GeneralQuestionnaireView.swift
//  DateDay
//
//  Created by Quentin Derouard on 23/05/2024.
//

import SwiftUI

struct GeneralQuestionnaireView: View {
    @State private var currentPage = 0
    @State private var answers: [UUID: String] = [:]
    @State private var showIdealPartnerPopup = false

    var body: some View {
        VStack {
            Text("Questionnaire Général")
                .font(.custom("Freeman-Regular", size: 24))
                .foregroundColor(.white)
                .padding()

            QuestionPageView(questions: Array(sampleQuestions[currentPage..<min(currentPage + 2, sampleQuestions.count)]), answers: $answers)

            Button(action: {
                if currentPage + 2 < sampleQuestions.count {
                    currentPage += 2
                } else {
                    showIdealPartnerPopup = true
                }
            }) {
                Text(currentPage + 2 < sampleQuestions.count ? "Suivant" : "Terminer")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }

            NavigationLink(destination: IdealPartnerPopupView(), isActive: $showIdealPartnerPopup) {
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

struct GeneralQuestionnaireView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralQuestionnaireView()
    }
}
