//
//  SexualOrientationView.swift
//  DateDay
//
//  Created by Quentin Derouard on 14/05/2024.
//

import SwiftUI

struct SexualOrientationView: View {
    @Binding var isSignedIn: Bool
    @Binding var user: User?
    @Binding var firstName: String
    @Binding var birthDate: Date
    @Binding var selectedGender: Gender
    @State private var selectedOrientation: SexualOrientation = .heterosexual

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

            Text("Orientation sexuelle")
                .font(.custom("Lobster-Regular", size: 24))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()

            Picker("Orientation sexuelle", selection: $selectedOrientation) {
                Text("Hétérosexuel").tag(SexualOrientation.heterosexual)
                Text("Gay").tag(SexualOrientation.gay)
                Text("Lesbienne").tag(SexualOrientation.lesbian)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .background(Color.white.opacity(0.2))
            .cornerRadius(10)
            .padding(.horizontal)

            NavigationLink(destination: LocationView(isSignedIn: $isSignedIn, user: $user, firstName: $firstName, birthDate: $birthDate, selectedGender: $selectedGender, selectedOrientation: $selectedOrientation)) {
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

struct SexualOrientationView_Previews: PreviewProvider {
    static var previews: some View {
        SexualOrientationView(isSignedIn: .constant(false), user: .constant(nil), firstName: .constant("John"), birthDate: .constant(Date()), selectedGender: .constant(.male))
    }
}
