//
//  SelfDescriptionQuestionnaireView.swift
//  DateDay
//
//  Created by Quentin Derouard on 21/05/2024.
//

import SwiftUI
import Firebase

struct SelfDescriptionQuestionnaireView: View {
    @State private var currentPage = 0
    @State private var answers: [String: String] = [:]
    @State private var showThankYouPopup = false
    @Environment(\.presentationMode) var presentationMode
    @Binding var user: User?

    var body: some View {
        VStack {
            HStack {
                if currentPage > 0 {
                    Button(action: {
                        currentPage -= 1
                    }) {
                        Text("Retour")
                            .foregroundColor(.white)
                            .padding()
                    }
                } else {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
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
                        saveAnswers()
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

    private func saveAnswers() {
        guard let user = user else { return }
        let db = Firestore.firestore()
        db.collection("users").document(user.id).setData([
            "selfDescriptionQuestionnaireAnswers": answers
        ], merge: true) { error in
            if let error = error {
                print("Erreur lors de la sauvegarde des réponses du questionnaire: \(error.localizedDescription)")
            }
        }
    }
}
