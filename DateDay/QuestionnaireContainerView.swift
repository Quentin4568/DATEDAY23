//
//  QuestionnaireContainerView.swift
//  DateDay
//
//  Created by Quentin Derouard on 14/05/2024.
//

import SwiftUI

struct QuestionnaireContainerView: View {
    @State private var currentQuestionnaire = 1
    @State private var answers: [UUID: String] = [:]
    @State private var currentPage = 0
    @State private var showThankYouPopup = false

    var body: some View {
        VStack {
            HStack {
                if currentPage > 0 || (currentPage == 0 && currentQuestionnaire > 1) {
                    Button(action: {
                        if currentPage > 0 {
                            currentPage -= 1
                        } else if currentQuestionnaire > 1 {
                            currentQuestionnaire -= 1
                            currentPage = 0
                        }
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

            if currentQuestionnaire == 1 {
                Text("Questionnaire Général")
                    .font(.custom("Freeman-Regular", size: 24))
                    .foregroundColor(.white)
                    .padding()

                QuestionPageView(questions: Array(sampleQuestions[currentPage..<min(currentPage + 2, sampleQuestions.count)]), answers: $answers)

                HStack {
                    if currentPage > 0 {
                        Button(action: {
                            currentPage -= 2
                        }) {
                            Text("Retour")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.gray)
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                    }

                    Button(action: {
                        if currentPage + 2 < sampleQuestions.count {
                            currentPage += 2
                        } else {
                            currentQuestionnaire = 2
                            currentPage = 0
                        }
                    }) {
                        Text(currentPage + 2 < sampleQuestions.count ? "Suivant" : "Suivant")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                }
            } else if currentQuestionnaire == 2 {
                Text("Partenaire Idéal")
                    .font(.custom("Freeman-Regular", size: 24))
                    .foregroundColor(.white)
                    .padding()

                QuestionPageView(questions: Array(idealPartnerQuestions[currentPage..<min(currentPage + 2, idealPartnerQuestions.count)]), answers: $answers)

                HStack {
                    if currentPage > 0 {
                        Button(action: {
                            currentPage -= 2
                        }) {
                            Text("Retour")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.gray)
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                    }

                    Button(action: {
                        if currentPage + 2 < idealPartnerQuestions.count {
                            currentPage += 2
                        } else {
                            currentQuestionnaire = 3
                            currentPage = 0
                        }
                    }) {
                        Text(currentPage + 2 < idealPartnerQuestions.count ? "Suivant" : "Suivant")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                }
            } else if currentQuestionnaire == 3 {
                Text("Auto-Description")
                    .font(.custom("Freeman-Regular", size: 24))
                    .foregroundColor(.white)
                    .padding()

                QuestionPageView(questions: Array(selfDescriptionQuestions[currentPage..<min(currentPage + 2, selfDescriptionQuestions.count)]), answers: $answers)

                HStack {
                    if currentPage > 0 {
                        Button(action: {
                            currentPage -= 2
                        }) {
                            Text("Retour")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.gray)
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                    }

                    Button(action: {
                        if currentPage + 2 < selfDescriptionQuestions.count {
                            currentPage += 2
                        } else {
                            showThankYouPopup = true
                        }
                    }) {
                        Text(currentPage + 2 < selfDescriptionQuestions.count ? "Suivant" : "Terminer")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                }
                .sheet(isPresented: $showThankYouPopup) {
                    ThankYouPopupView(showThankYouPopup: $showThankYouPopup)
                }
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

struct QuestionnaireContainerView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionnaireContainerView()
    }
}
