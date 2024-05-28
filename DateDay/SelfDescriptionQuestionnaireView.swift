//
//  SelfDescriptionQuestionnaireView.swift
//  DateDay
//
//  Created by Quentin Derouard on 21/05/2024.
//

import SwiftUI

struct SelfDescriptionQuestionnaireView: View {
    @State private var currentPage = 0
    @State private var answers: [UUID: String] = [:]
    @State private var showThankYouPopup = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            HStack {
                if currentPage > 0 {
                    Button(action: {
                        currentPage -= 2
                    }) {
                        Text("Retour")
                            .foregroundColor(.white)
                            .padding()
                    }
                }
                Spacer()
            }
            .padding()

            Spacer()

            if currentPage < pages.count {
                QuestionPageView(questions: pages[currentPage], answers: $answers)
                Button(action: {
                    if currentPage < pages.count - 1 {
                        currentPage += 1
                    } else {
                        showThankYouPopup = true
                    }
                }) {
                    Text(currentPage < pages.count - 1 ? "Suivant" : "Terminer")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.top)
                }
                .sheet(isPresented: $showThankYouPopup) {
                    ThankYouPopupView(showThankYouPopup: $showThankYouPopup)
                }
            } else {
                Text("Questionnaire terminé. Merci pour vos réponses!")
                    .foregroundColor(.white)
                    .padding()
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

    private var pages: [[Question]] {
        stride(from: 0, to: selfDescriptionQuestions.count, by: 2).map {
            Array(selfDescriptionQuestions[$0..<min($0 + 2, selfDescriptionQuestions.count)])
        }
    }
}

struct SelfDescriptionQuestionnaireView_Previews: PreviewProvider {
    static var previews: some View {
        SelfDescriptionQuestionnaireView()
    }
}
