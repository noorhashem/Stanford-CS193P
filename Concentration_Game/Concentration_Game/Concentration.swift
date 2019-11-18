//
//  Concentration.swift
//  Concentration_Game
//
//  Created by McNoor's  on 5/14/19.
//  Copyright © 2019 McNoor's . All rights reserved.
//

import Foundation
class concentration {
    
    var cards = [Card]()
    var indexOfOneandOnlyFaceUp : Int? {
        get{
            
            let FacedUpIndices = cards.indices.filter {cards[$0].isFaceUp}
            return FacedUpIndices.count == 1 ? FacedUpIndices.first : nil
            
//            var foundIndex : Int?
//            for index in cards.indices{
//                if cards[index].isFaceUp {
//                    if foundIndex == nil {
//                        foundIndex = index
//                    }
//                    else {
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
        }
        
        set {
            
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
            
        }
    }
    
    
    var Score : Int
    var SeenBeforeEmoji = [Card :Int]() // [Card , counter]
    
    func ChooseCard(at index : Int) {
        //if card is visible, hence, not already matched
        if !cards[index].isMatched{
            /*  if card is not marked as matched
             1. we see if it matches with the other card faced up, if another card is faced up
             or
             2. if there are already two cards faced up, or all the card are faced down, we mark the current card as faced up*/
            
            if let matchWithIndex = indexOfOneandOnlyFaceUp, matchWithIndex != index {
                if cards[index] == cards[matchWithIndex] {
                    cards[index].isMatched = true
                    cards[matchWithIndex].isMatched = true
                    Score+=2
                }
                else {
                    SeenBeforeEmoji[cards[index]] = SeenBeforeEmoji[cards[index]]! + 1
                    SeenBeforeEmoji[cards[matchWithIndex]] = SeenBeforeEmoji[cards[matchWithIndex]]! + 1
                    
                    
                    if SeenBeforeEmoji[cards[index]]! > 1  {
                        Score = Score - 1
                    }
                    
                    if SeenBeforeEmoji[cards[matchWithIndex]]! > 1  {
                        
                        Score = Score - 1
                    }
                    
                }
                cards[index].isFaceUp = true

                
                
            }
            else {
                
                //choose a new card since all cards are faced down or two cards faced up
                indexOfOneandOnlyFaceUp = index
            }
            
        }
    }
    
    init(noOfPairsOfCards : Int){
        Score = 0
        for _ in 1...noOfPairsOfCards{
            let card = Card()
            cards.append(card)
            cards.append(card)
            //cards+=[card,card]
            
        }
        for card in cards {
            SeenBeforeEmoji[card] = 0
        }
        //MARK: SHUFFLE CARDS
        cards = cards.shuffled()
        
    }
    
}
