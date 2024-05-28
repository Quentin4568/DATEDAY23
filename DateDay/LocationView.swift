//
//  LocationView.swift
//  DateDay
//
//  Created by Quentin Derouard on 14/05/2024.
//

import SwiftUI
import CoreLocation

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

                NavigationLink(destination: AgeRangeView(isSignedIn: $isSignedIn, user: $user)) {
                    Text("Suivant")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.top)
                }
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

    private func finishSignup() {
        print("Inscription terminée avec succès !")
        // Logique pour terminer l'inscription et naviguer vers la vue principale
    }
}

