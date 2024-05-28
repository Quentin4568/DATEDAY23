//
//  BirthDateView.swift
//  DateDay
//
//  Created by Quentin Derouard on 14/05/2024.
//

import SwiftUI

struct BirthDateView: View {
    @Binding var isSignedIn: Bool
    @Binding var user: User?
    @State private var birthDate = Date()

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

            Text("Date de naissance")
                .font(.custom("Lobster-Regular", size: 24))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()

            DatePicker("Date de naissance", selection: $birthDate, displayedComponents: [.date])
                .datePickerStyle(WheelDatePickerStyle())
                .padding()
                .background(Color.white.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)

            NavigationLink(destination: FirstNameView(isSignedIn: $isSignedIn, user: $user, birthDate: $birthDate)) {
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

struct BirthDateView_Previews: PreviewProvider {
    static var previews: some View {
        BirthDateView(isSignedIn: .constant(false), user: .constant(nil))
    }
}

