//
//  User.swift
//  DateDay
//
//  Created by Quentin Derouard on 14/05/2024.
//

import Foundation

struct User: Identifiable {
    let id: UUID
    var name: String
    var gender: Gender
    var sexualOrientation: SexualOrientation
    var answers: [UUID: String]
}

enum Gender: String, CaseIterable, Identifiable {
    case male = "Homme"
    case female = "Femme"
    
    var id: String { self.rawValue }
}

enum SexualOrientation: String, CaseIterable, Identifiable {
    case heterosexual = "Hétérosexuel"
    case gay = "Gay"
    case lesbian = "Lesbienne"
    
    var id: String { self.rawValue }
}
