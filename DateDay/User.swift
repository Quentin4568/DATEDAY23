//
//  User.swift
//  DateDay
//
//  Created by Quentin Derouard on 14/05/2024.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String // Changed to String for Firestore compatibility
    var name: String
    var gender: Gender
    var sexualOrientation: SexualOrientation
    var answers: [String: String] // Ensure answers use String keys
}

enum Gender: String, CaseIterable, Identifiable, Codable {
    case male = "Homme"
    case female = "Femme"
    
    var id: String { self.rawValue }
}

enum SexualOrientation: String, CaseIterable, Identifiable, Codable {
    case heterosexual = "Hétérosexuel"
    case gay = "Gay"
    case lesbian = "Lesbienne"
    
    var id: String { self.rawValue }
}
