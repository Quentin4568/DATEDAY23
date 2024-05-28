//
//  ThankYouPopupView.swift
//  DateDay
//
//  Created by Quentin Derouard on 23/05/2024.
//

import SwiftUI

struct ThankYouPopupView: View {
    @Binding var showThankYouPopup: Bool

    var body: some View {
        VStack {
            Spacer()

            Text("Merci d’avoir répondu, nous allons maintenant trouver ton date idéal")
                .font(.custom("Freeman-Regular", size: 24))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()

            Spacer()

            Button(action: {
                // Action pour fermer le pop-up et aller à l'interface principale
                showThankYouPopup = false
            }) {
                Text("Terminer")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }

            Spacer()
        }
        .background(
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                HeartAnimationView()
            }
        )
    }
}

struct ThankYouPopupView_Previews: PreviewProvider {
    static var previews: some View {
        ThankYouPopupView(showThankYouPopup: .constant(true))
    }
}
