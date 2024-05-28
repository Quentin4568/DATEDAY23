//
//  MainTabView.swift
//  DateDay
//
//  Created by Quentin Derouard on 14/05/2024.
//

import SwiftUI

struct MainTabView: View {
    @State var user: User
    @State private var users: [User] = [] // Liste de tous les utilisateurs
    @State private var matches: [User] = [] // Matches du jour
    @State private var conversations: [User] = [] // Conversations en cours

    var body: some View {
        TabView {
            ProfilesView(users: $users, currentUser: $user)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("A toi de jouer !")
                }

            MatchView(user: $user, users: $users, matches: $matches, conversations: $conversations)
                .tabItem {
                    Image(systemName: "hourglass")
                    Text("Match 24H")
                }

            ConversationsView(conversations: $conversations)
                .tabItem {
                    Image(systemName: "bubble.left.and.bubble.right")
                    Text("Conversations")
                }

            ProfileView(user: $user)
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Profil")
                }
        }
    }
}

struct ProfilesView: View {
    @Binding var users: [User]
    @Binding var currentUser: User
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            HStack {
                Text("A toi de jouer !")
                    .font(.custom("Freeman-Regular", size: 24))
                    .foregroundColor(.white)
                Spacer()
            }
            .padding()

            List(users) { user in
                VStack(alignment: .leading) {
                    Text(user.name)
                        .font(.headline)
                    Text("Compatibilité : \(calculateMatchScore(user1: currentUser, user2: user) * 100, specifier: "%.0f")%")
                        .font(.subheadline)
                }
            }
        }
        .background(
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                HeartAnimationView()
            }
        )
    }
}

