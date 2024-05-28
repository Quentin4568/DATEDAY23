//
//  ContentView.swift
//  DateDay
//
//  Created by Quentin Derouard on 14/05/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var isSignedIn = false
    @State private var user: User? = nil

    var body: some View {
        NavigationStack {
            VStack {
                if isSignedIn, let user = user {
                    MainTabView(user: user)
                } else {
                    VStack {
                        Spacer()

                        VStack(spacing: 5) {
                            Text("DateDay")
                                .font(.custom("Lobster-Regular", size: 60))
                                .foregroundColor(.white)

                            Text("prêt à matcher !")
                                .font(.custom("Lobster-Regular", size: 30))
                                .foregroundColor(.white)
                        }

                        Spacer()

                        Image("logo2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .padding()
                            .mask(
                                LinearGradient(gradient: Gradient(stops: [
                                    .init(color: .clear, location: 0.0),
                                    .init(color: .black, location: 0.2),
                                    .init(color: .black, location: 0.8),
                                    .init(color: .clear, location: 1.0)
                                ]), startPoint: .top, endPoint: .bottom)
                                .mask(
                                    LinearGradient(gradient: Gradient(stops: [
                                        .init(color: .clear, location: 0.0),
                                        .init(color: .black, location: 0.2),
                                        .init(color: .black, location: 0.8),
                                        .init(color: .clear, location: 1.0)
                                    ]), startPoint: .leading, endPoint: .trailing)
                                )
                            )

                        Spacer()

                        NavigationLink(destination: EmailPasswordView(isSignedIn: $isSignedIn, user: $user)) {
                            Text("S'inscrire")
                                .font(.custom("Lobster-Regular", size: 24))
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.red)
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }

                        NavigationLink(destination: LoginView(isSignedIn: $isSignedIn, user: $user)) {
                            Text("Se connecter")
                                .font(.custom("Lobster-Regular", size: 24))
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.purple)
                                .cornerRadius(10)
                                .padding(.horizontal)
                                .padding(.top, 10)
                        }

                        Spacer()
                            .frame(height: 50)
                    }
                }
            }
            .background(
                ZStack {
                    Color.black.edgesIgnoringSafeArea(.all)
                    HeartAnimationView()
                }
            )
            .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

