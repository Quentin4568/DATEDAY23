//
//  QuestionPageView.swift
//  DateDay
//
//  Created by Quentin Derouard on 14/05/2024.
//

import SwiftUI

struct QuestionPageView: View {
    let questions: [Question]
    @Binding var answers: [UUID: String]

    var body: some View {
        VStack(spacing: 20) { // Espacement entre les questions
            ForEach(questions.prefix(2)) { question in // Limiter à 2 questions par page
                VStack(alignment: .leading, spacing: 10) { // Espacement entre la question et les réponses
                    Text(question.text)
                        .font(.custom("Freeman-Regular", size: 16)) // Taille ajustée pour les questions
                        .foregroundColor(.white)
                        .padding(.bottom, 10)
                    
                    VStack(alignment: .leading, spacing: 5) { // Alignement et espacement des options
                        ForEach(question.options, id: \.self) { option in
                            Button(action: {
                                answers[question.id] = option
                            }) {
                                HStack {
                                    Text(option)
                                        .font(.custom("Freeman-Regular", size: 14)) // Taille ajustée pour les réponses
                                        .foregroundColor(answers[question.id] == option ? .white : .black)
                                    Spacer()
                                    if answers[question.id] == option {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.white)
                                    }
                                }
                                .padding(8)
                                .background(answers[question.id] == option ? Color.blue : Color.white)
                                .cornerRadius(8)
                            }
                        }
                    }
                }
                .padding()
                .background(Color.white.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)
            }
        }
        .padding(.top, 20) // Ajouter un espacement en haut
        .background(
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                HeartAnimationView()
            }
        )
    }
}

struct QuestionPageView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionPageView(questions: sampleQuestions, answers: .constant([:]))
    }
}
