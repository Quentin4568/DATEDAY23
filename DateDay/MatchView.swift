//
//  MatchView.swift
//  DateDay
//
//  Created by Quentin Derouard on 14/05/2024.
//

import SwiftUI

struct MatchView: View {
    @Binding var user: User
    @Binding var users: [User]
    @Binding var matches: [User]
    @Binding var conversations: [User]
    
    @State private var currentMatch: User?
    @StateObject private var backgroundTask = BackgroundTask()
    
    var body: some View {
        VStack {
            if let match = currentMatch {
                VStack {
                    Text("Match du jour")
                        .font(.largeTitle)
                        .padding()

                    Text(match.name)
                        .font(.title)
                        .padding()
                    
                    Button(action: {
                        // Ajouter le match aux conversations si coup de cœur
                        if conversations.count < 3 {
                            conversations.append(match)
                        }
                    }) {
                        Image(systemName: "heart.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.red)
                    }
                }
            } else {
                Text("Aucun match pour aujourd'hui")
                    .font(.title)
                    .padding()
            }
        }
        .onAppear {
            updateMatch()
            backgroundTask.startDailyUpdate(task: updateMatch)
        }
    }
    
    func updateMatch() {
        // Logique pour mettre à jour le match du jour à 8h00 tous les jours
        let newMatches = findMatches(for: user, in: users)
        if let firstMatch = newMatches.first {
            currentMatch = firstMatch
            matches = [firstMatch]
        } else {
            currentMatch = nil
        }
    }
}
