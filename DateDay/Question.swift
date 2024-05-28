//
//  Question.swift
//  DateDay
//
//  Created by Quentin Derouard on 14/05/2024.
//

import Foundation

struct Question: Identifiable {
    let id = UUID()
    let text: String
    let options: [String]
}

let sampleQuestions: [Question] = [
    Question(text: "Quel serait ton activité favorite si tu avais le choix ?", options: ["Voyager autour du monde", "Lire un bon livre", "Pratiquer un sport", "Sortir avec des amis", "Cuisiner ou essayer de nouvelles recettes"]),
    Question(text: "Quel type de film préfères-tu regarder ?", options: ["Comédie", "Drame", "Science-fiction", "Documentaire", "Horreur"]),
    Question(text: "Comment aimes-tu passer ton week-end ?", options: ["Sortir en nature", "Regarder des séries ou des films", "Participer à des événements sociaux", "Faire du sport", "Lire ou écrire"]),
    Question(text: "Quelle est ta vision de la soirée idéale ?", options: ["Un dîner romantique", "Une soirée tranquille à la maison", "Une fête entre amis", "Un concert ou un spectacle", "Une activité en plein air"]),
    Question(text: "Quel genre de musique écoutes-tu le plus souvent ?", options: ["Pop", "Rock", "Classique", "Hip-hop", "Jazz"]),
    Question(text: "Quelle est ta destination de vacances préférée ?", options: ["Plage exotique", "Montagne", "Ville historique", "Parc national", "Croisière"]),
    Question(text: "Quel est ton plat préféré ?", options: ["Pizza", "Sushi", "Pâtes", "Steak", "Salade"]),
    Question(text: "Quel est ton animal préféré ?", options: ["Chien", "Chat", "Oiseau", "Poisson", "Aucun"]),
    Question(text: "Comment décrirais-tu ton style de vie ?", options: ["Actif et sportif", "Calme et relaxé", "Aventurier et explorateur", "Social et festif", "Intellectuel et curieux"]),
    Question(text: "Quelle est ta saison préférée ?", options: ["Printemps", "Été", "Automne", "Hiver"]),
    Question(text: "Quel livre as-tu lu récemment et que tu as adoré ?", options: ["Un roman populaire", "Une biographie", "Un livre de développement personnel", "Un classique littéraire", "Un livre de science-fiction ou fantastique"]),
    Question(text: "Quelle est ta boisson préférée ?", options: ["Café", "Thé", "Vin", "Bière", "Jus de fruits"]),
    Question(text: "Quel est ton rêve de carrière ou de vie ?", options: ["Réussir dans mon domaine professionnel", "Voyager et découvrir le monde", "Fonder une famille", "Devenir un artiste reconnu", "Avoir une vie paisible et stable"]),
    Question(text: "Comment gères-tu le stress ?", options: ["Faire du sport", "Méditer ou pratiquer le yoga", "Parler à des amis ou à la famille", "Écouter de la musique ou lire", "Prendre du temps seul pour réfléchir"]),
    Question(text: "Quelle est ta valeur la plus importante dans une relation ?", options: ["La confiance", "La communication", "Le respect", "La loyauté", "L’humour"]),
    Question(text: "Quel est ton passe-temps préféré ?", options: ["Jouer d’un instrument de musique", "Pratiquer un sport", "Faire du bricolage ou de l’artisanat", "Jardiner", "Jouer à des jeux vidéo"]),
    Question(text: "Quelle est ta vision d’un jour parfait ?", options: ["Passer la journée avec des amis et de la famille", "Explorer un nouvel endroit", "Se détendre à la maison avec un bon livre ou un film", "Pratiquer une activité physique", "Participer à un événement culturel"]),
    Question(text: "Si tu pouvais apprendre instantanément une nouvelle compétence, laquelle serait-elle ?", options: ["Parler une nouvelle langue", "Jouer d’un instrument de musique", "Cuisiner comme un chef", "Programmer ou coder", "Maîtriser une activité artistique (peinture, sculpture, etc.)"])
]

let idealPartnerQuestions: [Question] = [
    Question(text: "Quelle couleur de cheveux préfères-tu chez un partenaire ?", options: ["Blond", "Brun", "Roux", "Ça n’a pas d’importance"]),
    Question(text: "Quel style vestimentaire trouves-tu le plus attrayant chez un partenaire ?", options: ["Élégant et chic", "Décontracté et sportif", "Bohème et artistique", "Ça n’a pas d’importance"]),
    Question(text: "Quelle couleur des yeux trouves-tu la plus séduisante chez un partenaire ?", options: ["Bleu", "Vert", "Marron", "Ça n’a pas d’importance"]),
    Question(text: "Quelle silhouette préfères-tu chez un partenaire ?", options: ["Mince et athlétique", "Musclé et costaud", "Rond et doux", "Ça n’a pas d’importance"]),
    Question(text: "Quelle longueur de cheveux préfères-tu chez un partenaire ?", options: ["Courts", "Mi-longs", "Longs", "Ça n’a pas d’importance"]),
    Question(text: "Quel type de tenue préfères-tu pour une soirée ?", options: ["Tenue de soirée élégante", "Tenue décontractée", "Tenue originale et unique", "Ça n’a pas d’importance"]),
    Question(text: "Quel attribut physique est le plus important pour toi chez un partenaire ?", options: ["Sourire", "Taille", "Regard", "Ça n’a pas d’importance"]),
    Question(text: "Quelle préférence as-tu pour les tatouages chez un partenaire ?", options: ["Pas de tatouages", "Quelques tatouages discrets", "Beaucoup de tatouages", "Ça n’a pas d’importance"]),
    Question(text: "Quel type de corps préfères-tu chez un partenaire ?", options: ["Fin et élancé", "Athlétique et tonique", "Formes généreuses", "Ça n’a pas d’importance"]),
    Question(text: "Quel style de coiffure préfères-tu chez un partenaire ?", options: ["Cheveux lisses", "Cheveux bouclés", "Cheveux ondulés", "Ça n’a pas d’importance"]),
    Question(text: "Est-ce important pour toi que ton partenaire fume ou non ?", options: ["Non fumeur", "Fumeur occasionnel", "Fumeur régulier", "Ça n’a pas d’importance"]),
    Question(text: "Est-ce important pour toi que ton partenaire ait une religion spécifique ?", options: ["Oui, même religion que moi", "Oui, mais une autre religion me convient", "Non, pas de religion", "Ça n’a pas d’importance"]),
    Question(text: "Es-tu ouvert(e) à ce que ton partenaire ait déjà des enfants ?", options: ["Oui, absolument", "Oui, mais cela dépend du nombre", "Non, je préfère quelqu’un sans enfants", "Ça n’a pas d’importance"]),
    Question(text: "Si ton partenaire devait ressembler à un personnage de film ou de dessin animé, lequel préfèrerais-tu ?", options: ["Super-héros musclé (comme Superman ou Wonder Woman)", "Aventurier charismatique (comme Indiana Jones ou Lara Croft)", "Personnage de conte de fées (comme Cendrillon ou le Prince Charmant)", "Ça n’a pas d’importance"])
]

let selfDescriptionQuestions: [Question] = [
    Question(text: "Quelle est la couleur de tes cheveux ?", options: ["Blond", "Brun", "Roux"]),
    Question(text: "Quel style vestimentaire adoptes-tu le plus souvent ?", options: ["Élégant et chic", "Décontracté et sportif", "Bohème et artistique"]),
    Question(text: "Quelle est la couleur de tes yeux ?", options: ["Bleu", "Vert", "Marron"]),
    Question(text: "Comment décrirais-tu ta silhouette ?", options: ["Mince et athlétique", "Musclé et costaud", "Rond et doux"]),
    Question(text: "Quelle est la longueur de tes cheveux ?", options: ["Courts", "Mi-longs", "Longs"]),
    Question(text: "Quel type de tenue portes-tu pour une soirée ?", options: ["Tenue de soirée élégante", "Tenue décontractée", "Tenue originale et unique"]),
    Question(text: "Quel attribut physique chez toi est le plus remarquable ?", options: ["Sourire", "Taille", "Regard"]),
    Question(text: "As-tu des tatouages ?", options: ["Pas de tatouages", "Quelques tatouages discrets", "Beaucoup de tatouages"]),
    Question(text: "Comment décrirais-tu ton type de corps ?", options: ["Fin et élancé", "Athlétique et tonique", "Formes généreuses"]),
    Question(text: "Quel style de coiffure as-tu ?", options: ["Cheveux lisses", "Cheveux bouclés", "Cheveux ondulés"]),
    Question(text: "Fumes-tu ?", options: ["Non fumeur", "Fumeur occasionnel", "Fumeur régulier"]),
    Question(text: "Ta religion est-elle importante pour toi dans une relation ?", options: ["Oui, même religion que moi", "Oui, mais une autre religion me convient", "Non, pas de religion"]),
    Question(text: "As-tu des enfants ?", options: ["Oui", "Non"]),
    Question(text: "Si tu devais ressembler à un personnage de film ou de dessin animé, lequel choisirais-tu ?", options: ["Super-héros musclé (comme Superman ou Wonder Woman)", "Aventurier charismatique (comme Indiana Jones ou Lara Croft)", "Personnage de conte de fées (comme Cendrillon ou le Prince Charmant)"])
]
