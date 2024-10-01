//
//  IdealPartnerPopupView.swift
//  DateDay
//
//  Created by Quentin Derouard on 21/05/2024.
//

import SwiftUI

struct IdealPartnerPopupView: View {
    @Binding var showPopup: Bool
    @Binding var user: User?

    var body: some View {
        VStack {
            Text("Décris-nous ton partenaire idéal 😍")
                .font(.custom("Freeman-Regular", size: 24))
                .foregroundColor(.white)
                .padding()

            Button(action: {
                showPopup = false
            }) {
                Text("Commencer")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
        }
        .background(Color.black.edgesIgnoringSafeArea(.all).opacity(0.8))
        .cornerRadius(10)
        .shadow(radius: 10)
        .padding()
        .onDisappear {
            if !showPopup {
                if let rootView = UIApplication.shared.windows.first?.rootViewController {
                    rootView.present(UIHostingController(rootView: IdealPartnerQuestionnaireView(user: $user)), animated: true, completion: nil)
                }
            }
        }
    }
}

struct IdealPartnerPopupView_Previews: PreviewProvider {
    static var previews: some View {
        IdealPartnerPopupView(showPopup: .constant(true), user: .constant(nil))
    }
}
