//
//  IdealPartnerQuestionnaireView.swift
//  DateDay
//
//  Created by Quentin Derouard on 21/05/2024.
//

import SwiftUI
import Firebase

struct IdealPartnerQuestionnaireView: View {
    @Binding var user: User?

    @State private var currentPage = 0
    @State private var questions: [Question] = []
    @State private var answers: [String: String] = [:]

    var body: some View {
        VStack {
            Text("Questionnaire Partenaire Idéal")
                .font(.custom("Freeman-Regular", size: 24))
                .foregroundColor(.white)
                .padding()

            if questions.isEmpty {
                Text("Chargement des questions...")
                    .foregroundColor(.white)
            } else {
                QuestionPageView(questions: Array(questions[currentPage..<min(currentPage + 2, questions.count)]), answers: $answers)
                
                Button(action: {
                    if currentPage + 2 < questions.count {
                        currentPage += 1
                    } else {
                        saveAnswers()
                    }
                }) {
                    Text(currentPage + 2 < questions.count ? "Suivant" : "Terminer")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
            }
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .navigationBarBackButtonHidden(true)
        .onAppear(perform: loadQuestions)
    }

    private func loadQuestions() {
        questions = idealPartnerQuestions
    }

    private func saveAnswers() {
        guard let user = user else { return }
        let db = Firestore.firestore()
        db.collection("users").document(user.id).setData([
            "idealPartnerQuestionnaireAnswers": answers
        ], merge: true) { error in
            if let error = error {
                print("Erreur lors de la sauvegarde des réponses du questionnaire: \(error.localizedDescription)")
            }
        }
    }
}
