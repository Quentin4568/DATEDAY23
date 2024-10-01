//  GeneralQuestionnaireView.swift
//  DateDay
//
//  Created by Quentin Derouard on 23/05/2024.

import SwiftUI
import Firebase

struct GeneralQuestionnaireView: View {
    @State private var currentPage = 0
    @State private var answers: [String: String] = [:]
    @State private var showSelfDescriptionPopup = false  // Mise à jour pour passer à la vue suivante

    @Environment(\.presentationMode) var presentationMode
    @Binding var user: User?
    @Binding var isSignedIn: Bool

    var body: some View {
        VStack {
            HStack {
                if currentPage > 0 {
                    Button(action: {
                        currentPage -= 1
                    }) {
                        Text("Retour")
                            .foregroundColor(.white)
                    }
                } else {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Retour")
                            .foregroundColor(.white)
                    }
                }
                Spacer()
                Text("Questionnaire Général")
                    .font(.custom("Freeman-Regular", size: 24))
                    .foregroundColor(.white)
                Spacer()
            }
            .padding()

            QuestionPageView(questions: Array(sampleQuestions[currentPage..<min(currentPage + 2, sampleQuestions.count)]), answers: $answers)

            Button(action: {
                if currentPage + 2 < sampleQuestions.count {
                    currentPage += 1
                } else {
                    saveAnswers()
                    showSelfDescriptionPopup = true  // Passer à la vue suivante après le dernier questionnaire
                }
            }) {
                Text(currentPage + 2 < sampleQuestions.count ? "Suivant" : "Terminer")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.top)
            }
        }
        .background(
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                HeartAnimationView()  // Fond animé avec les cœurs
            }
        )
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $showSelfDescriptionPopup) {  // Affichage de la vue après le dernier questionnaire
            SelfDescriptionPopupView(user: $user)
        }
        .onAppear {
            print("Page de questionnaire affichée")
        }
    }

    private func saveAnswers() {
        guard let user = user else { return }
        let db = Firestore.firestore()
        db.collection("users").document(user.id).setData([
            "generalQuestionnaireAnswers": answers
        ], merge: true) { error in
            if let error = error {
                print("Erreur lors de la sauvegarde des réponses du questionnaire: \(error.localizedDescription)")
            }
        }
    }
}
