//
//  QuestionPageView.swift
//  DateDay
//
//  Created by Quentin Derouard on 14/05/2024.
//

import SwiftUI

struct QuestionPageView: View {
    var questions: [Question]
    @Binding var answers: [String: String]

    var body: some View {
        VStack(spacing: 20) {
            ForEach(questions, id: \.id) { question in
                VStack(alignment: .leading, spacing: 10) {
                    Text(question.text)
                        .font(.title3)
                        .foregroundColor(.white)

                    ForEach(question.options, id: \.self) { option in
                        Button(action: {
                            // Mise à jour de la réponse sélectionnée pour la question
                            if let questionId = question.id {
                                answers[questionId] = option
                            }
                        }) {
                            HStack {
                                Text(option)
                                    .font(.headline)
                                    .foregroundColor(answers[question.id ?? ""] == option ? .white : .black)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(answers[question.id ?? ""] == option ? Color.blue : Color.gray.opacity(0.3))
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding()
        .background(Color.black.opacity(0.7))
        .cornerRadius(10)
    }
}
