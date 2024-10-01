//
//  LocationView.swift
//  DateDay
//
//  Created by Quentin Derouard on 14/05/2024.
//

import SwiftUI
import CoreLocation
import Firebase
import FirebaseFirestore

struct LocationView: View {
    @Binding var isSignedIn: Bool
    @Binding var user: User?
    @Binding var firstName: String
    @Binding var birthDate: Date
    @Binding var selectedGender: Gender
    @Binding var selectedOrientation: SexualOrientation
    @State private var showingLocationRequest = false
    @State private var locationStatus = CLAuthorizationStatus.notDetermined
    @State private var maxDistance: Double = 50.0
    @State private var navigateToPhotoUpload = false

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
                Text("Localisation")
                    .font(.custom("Freeman-Regular", size: 24))
                    .foregroundColor(.white)
                Spacer()
                Spacer().frame(width: 60)
            }
            .padding()

            Spacer()

            Text("Veuillez autoriser l'accès à votre localisation pour déterminer où vous habitez et choisir la distance maximale avec la personne que vous souhaitez rencontrer.")
                .padding()
                .foregroundColor(.white)
                .multilineTextAlignment(.center)

            if locationStatus == .notDetermined {
                Button(action: {
                    requestLocationPermission()
                }) {
                    Text("Autoriser la localisation")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.top)
                }
            } else {
                VStack {
                    Text("Distance maximale : \(Int(maxDistance)) km")
                        .foregroundColor(.white)
                    Slider(value: $maxDistance, in: 1...200, step: 1)
                        .padding()
                }
                .padding()

                NavigationLink(destination: PhotoUploadView(isSignedIn: $isSignedIn, user: $user), isActive: $navigateToPhotoUpload) {
                    Text("Suivant")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.top)
                }
                .simultaneousGesture(TapGesture().onEnded {
                    saveLocationData()
                })
            }
        }
        .background(
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                HeartAnimationView()
            }
        )
        .navigationBarBackButtonHidden(true)
        .onAppear {
            checkLocationStatus()
        }
    }

    private func requestLocationPermission() {
        let manager = CLLocationManager()
        manager.requestWhenInUseAuthorization()
        showingLocationRequest = true
    }

    private func checkLocationStatus() {
        let manager = CLLocationManager()
        locationStatus = manager.authorizationStatus

        withAnimation(.easeInOut) {
            if locationStatus != .notDetermined {
                showingLocationRequest = false
            }
        }
    }

    private func saveLocationData() {
        guard let user = user else { return }
        let db = Firestore.firestore()
        db.collection("users").document(user.id).setData([
            "maxDistance": maxDistance
        ], merge: true) { error in
            if let error = error {
                print("Erreur lors de la sauvegarde des données de localisation : \(error.localizedDescription)")
            } else {
                navigateToPhotoUpload = true
            }
        }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView(isSignedIn: .constant(false), user: .constant(nil), firstName: .constant("John"), birthDate: .constant(Date()), selectedGender: .constant(.male), selectedOrientation: .constant(.heterosexual))
    }
}
