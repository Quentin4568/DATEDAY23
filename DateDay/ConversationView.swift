//
//  ConversationView.swift
//  DateDay
//
//  Created by Quentin Derouard on 14/05/2024.
//

import SwiftUI

struct ConversationsView: View {
    @Binding var conversations: [User]
    
    var body: some View {
        VStack {
            Text("Conversations")
                .font(.largeTitle)
                .padding()
            
            List {
                ForEach(conversations) { conversation in
                    VStack(alignment: .leading) {
                        Text(conversation.name)
                            .font(.headline)
                        Text("Cliquez pour converser avec cette personne")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .onDelete(perform: deleteConversation)
            }
            .listStyle(InsetGroupedListStyle())
            
            Text("Vous pouvez conserver jusqu'à 3 conversations pendant 24 heures")
                .font(.footnote)
                .padding()
        }
        .navigationTitle("Conversations")
    }
    
    func deleteConversation(at offsets: IndexSet) {
        conversations.remove(atOffsets: offsets)
    }
}
