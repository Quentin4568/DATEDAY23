//
//  AgeRangeView.swift
//  DateDay
//
//  Created by Quentin Derouard on 26/05/2024.
//

import SwiftUI
import Firebase

struct AgeRangeView: View {
    @Binding var isSignedIn: Bool
    @Binding var user: User?
    @State private var minAge: Double = 18
    @State private var maxAge: Double = 65

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Retour")
                        .foregroundColor(.white)
                }
                Spacer()
                Text("Tranche d'âge")
                    .font(.custom("Lobster-Regular", size: 24))
                    .foregroundColor(.white)
                Spacer()
                Spacer().frame(width: 60)
            }
            .padding()

            Spacer()

            Text("Sélectionne la tranche d'âge des personnes que tu veux rencontrer")
                .font(.custom("Lobster-Regular", size: 24))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()

            Spacer().frame(height: 20)

            VStack {
                Text("Âge minimum: \(Int(minAge))")
                    .foregroundColor(.white)
                Slider(value: $minAge, in: 17...65, step: 1)
                    .padding()
                Text("Âge maximum: \(Int(maxAge))")
                    .foregroundColor(.white)
                Slider(value: $maxAge, in: 17...65, step: 1)
                    .padding()
            }
            .padding()
            .background(Color.white.opacity(0.2))
            .cornerRadius(10)
            .padding(.horizontal)

            NavigationLink(destination: CompletionView(isSignedIn: $isSignedIn, user: $user)) {
                Text("Suivant")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.top)
            }
            .simultaneousGesture(TapGesture().onEnded {
                saveAgeRange()
            })

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

    private func saveAgeRange() {
        guard let user = user else { return }
        let db = Firestore.firestore()
        db.collection("users").document(user.id).setData([
            "ageRange": [
                "minAge": minAge,
                "maxAge": maxAge
            ]
        ], merge: true) { error in
            if let error = error {
                print("Erreur lors de la sauvegarde de la tranche d'âge: \(error.localizedDescription)")
            }
        }
    }
}

struct AgeRangeView_Previews: PreviewProvider {
    static var previews: some View {
        AgeRangeView(isSignedIn: .constant(false), user: .constant(nil))
    }
}
