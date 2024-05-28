//
//  FirstNameView.swift
//  DateDay
//
//  Created by Quentin Derouard on 14/05/2024.
//

import SwiftUI

struct FirstNameView: View {
    @Binding var isSignedIn: Bool
    @Binding var user: User?
    @Binding var birthDate: Date
    @State private var firstName: String = ""

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
                Text("Inscription")
                    .font(.custom("Lobster-Regular", size: 24))
                    .foregroundColor(.white)
                Spacer()
                Spacer().frame(width: 60)
            }
            .padding()

            Spacer()

            Text("Veuillez entrer votre prénom réel, pas un pseudonyme.")
                .font(.custom("Lobster-Regular", size: 24))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()

            TextField("Prénom", text: $firstName)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)

            NavigationLink(destination: GenderView(isSignedIn: $isSignedIn, user: $user, firstName: $firstName, birthDate: $birthDate)) {
                Text("Suivant")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.top)
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
}

struct FirstNameView_Previews: PreviewProvider {
    static var previews: some View {
        FirstNameView(isSignedIn: .constant(false), user: .constant(nil), birthDate: .constant(Date()))
    }
}
