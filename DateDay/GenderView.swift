//
//  GenderView.swift
//  DateDay
//
//  Created by Quentin Derouard on 14/05/2024.
//

import SwiftUI

struct GenderView: View {
    @Binding var isSignedIn: Bool
    @Binding var user: User?
    @Binding var firstName: String
    @Binding var birthDate: Date
    @State private var selectedGender: Gender = .male

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

            Text("Genre")
                .font(.custom("Lobster-Regular", size: 24))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()

            Picker("Genre", selection: $selectedGender) {
                Text("Homme").tag(Gender.male)
                Text("Femme").tag(Gender.female)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .background(Color.white.opacity(0.2))
            .cornerRadius(10)
            .padding(.horizontal)

            NavigationLink(destination: SexualOrientationView(isSignedIn: $isSignedIn, user: $user, firstName: $firstName, birthDate: $birthDate, selectedGender: $selectedGender)) {
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

struct GenderView_Previews: PreviewProvider {
    static var previews: some View {
        GenderView(isSignedIn: .constant(false), user: .constant(nil), firstName: .constant("John"), birthDate: .constant(Date()))
    }
}
