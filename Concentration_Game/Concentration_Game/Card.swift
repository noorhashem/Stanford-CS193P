//
//  Card.swift
//  Concentration_Game
//
//  Created by McNoor's  on 5/14/19.
//  Copyright © 2019 McNoor's . All rights reserved.
//

import Foundation
struct Card : Hashable {

    func hash(into hasher: inout Hasher){
        hasher.combine(identifier)
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }

    
    var isFaceUp = false
    var isMatched = false
    var identifier : Int
    static var uniqueIdentifierFactory = 0
    static func getUniqueIdentifier()-> Int
    {   uniqueIdentifierFactory+=1
        return uniqueIdentifierFactory
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    } 
}
