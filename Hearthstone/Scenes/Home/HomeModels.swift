//
//  HomeModels.swift
//  Hearthstone
//
//  Created by NJ Development on 18/07/23.
//  Copyright (c) 2023 NJ Development. All rights reserved.
//

import UIKit

enum Home {
    struct Response: Codable {
        let hallOfFame: [Card]?
        
        enum CodingKeys: String, CodingKey {
            case hallOfFame = "Hall of Fame"
        }
    }
}

struct Card: Codable {
    let img, name, flavor, text, cardSet, type, faction, rarity: String?
    let attack, cost, health: Int?
    
    init(img: String?, name: String?, flavor: String?, text: String?, cardSet: String?,
         type: String?, faction: String?, rarity: String?,
         attack: Int?, cost: Int?, health: Int?) {
        self.img = img
        self.name = name
        self.flavor = flavor
        self.text = text
        self.cardSet = cardSet
        self.type = type
        self.faction = faction
        self.rarity = rarity
        self.attack = attack
        self.cost = cost
        self.health = health
    }
}

//A imagem principal do cartão
//Nome
//Descrição "flavor"
//Descrição curta
//Set pertencente
//Tipo
//Facção
//Raridade
//Ataque
//Custo
//Health
