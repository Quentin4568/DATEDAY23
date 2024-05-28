//
//  MatchAlgorithm.swift
//  DateDay
//
//  Created by Quentin Derouard on 14/05/2024.
//

import Foundation

func calculateMatchScore(user1: User, user2: User) -> Double {
    let totalQuestions = user1.answers.count
    let matchingAnswers = user1.answers.filter { user2.answers[$0.key] == $0.value }.count
    return Double(matchingAnswers) / Double(totalQuestions)
}

func isMatchCompatible(user1: User, user2: User) -> Bool {
    switch user1.sexualOrientation {
    case .heterosexual:
        return (user1.gender == .male && user2.gender == .female && user2.sexualOrientation == .heterosexual) ||
               (user1.gender == .female && user2.gender == .male && user2.sexualOrientation == .heterosexual)
    case .gay:
        return user1.gender == .male && user2.gender == .male && user2.sexualOrientation == .gay
    case .lesbian:
        return user1.gender == .female && user2.gender == .female && user2.sexualOrientation == .lesbian
    }
}

func findMatches(for user: User, in users: [User]) -> [User] {
    let threshold = 0.5 // 50% de correspondance minimum
    var matches: [(User, Double)] = []
    
    for potentialMatch in users {
        if user.id != potentialMatch.id && isMatchCompatible(user1: user, user2: potentialMatch) {
            let matchScore = calculateMatchScore(user1: user, user2: potentialMatch)
            if matchScore >= threshold {
                matches.append((potentialMatch, matchScore))
            }
        }
    }
    
    // Trier les correspondances par score décroissant
    matches.sort { $0.1 > $1.1 }
    
    // Retourner les utilisateurs correspondant
    return matches.map { $0.0 }
}
