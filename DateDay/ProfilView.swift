//
//  ProfilView.swift
//  DateDay
//
//  Created by Quentin Derouard on 14/05/2024.
//

import SwiftUI

struct ProfileView: View {
    @Binding var user: User
    
    var body: some View {
        VStack {
            Text("Mon Profil")
                .font(.largeTitle)
                .padding()

            // Afficher les informations de profil de l'utilisateur
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Nom:")
                        .font(.headline)
                    Spacer()
                    Text(user.name)
                        .font(.subheadline)
                }
                
                HStack {
                    Text("Genre:")
                        .font(.headline)
                    Spacer()
                    Text(user.gender.rawValue)
                        .font(.subheadline)
                }
                
                HStack {
                    Text("Orientation:")
                        .font(.headline)
                    Spacer()
                    Text(user.sexualOrientation.rawValue)
                        .font(.subheadline)
                }
                
                // Ajouter des champs pour les photos et la description
                // Exemple:
                // Image(systemName: "person.crop.circle")
                //     .resizable()
                //     .frame(width: 100, height: 100)
                //     .padding()

                // Text("Description: \(user.description)")
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding()

            Spacer()
        }
        .navigationTitle("Mon Profil")
    }
}
