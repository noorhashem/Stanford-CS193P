//
//  ViewController.swift
//  Concentration_Game
//
//  Created by McNoor's  on 5/3/19.
//  Copyright © 2019 McNoor's . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
   lazy var game = concentration(noOfPairsOfCards : (CardButtons.count + 1) / 2)
    var newGame = false
    var score = 0
    
    var Themes = [0:"🍎🥑🍆🍕🍣🥐",1:"🐶🐱🐼🐒🦋🦄", 2:"🚀✈️🚁🚑🏎🛵"]
    var emoji = [Card :String]()
    lazy var  Choices = Themes[0]!
    
    let textAttributes : [NSAttributedStringKey: Any ] = [
        
        .strokeColor : UIColor.orange,
        .strokeWidth : 5.0
    ]
    
    var flipCounts = 0
    {
        didSet{
            
            Flips.attributedText = TextDraw(todraw: "Flips : \(flipCounts)")
        }
        }

    @IBOutlet var CardButtons: [UIButton]!
    @IBOutlet weak var Flips: UILabel! {
        didSet{
             Flips.attributedText = TextDraw(todraw: "Flips : \(flipCounts)")
        }
    }
    @IBOutlet weak var Score: UILabel! {
        didSet{
            Score.attributedText = TextDraw(todraw: "Score : \(game.Score)")

        }
    }
    
    
func TextDraw(todraw text : String) -> NSAttributedString {

        let  attributedString = NSAttributedString(string: text, attributes: textAttributes)
        return attributedString
}
        
    
    @IBAction func newGame(_ sender: UIButton) {
        for cardIndex in CardButtons.indices {
            game.cards[cardIndex].isFaceUp = false
            game.cards[cardIndex].isMatched = false
        }
        flipCounts = 0
        game.cards = game.cards.shuffled()
        newGame = true
        Score.text = "Score : 0"
        game.Score = 0

        for card in game.cards{
            emoji[card] = nil
        }

        for card in game.cards{
            emoji[card] = emojiSetter(for: card)
        }
        for card in game.cards {
            game.SeenBeforeEmoji[card] = 0
        }
        
        UpdateViewFromModel()
       
    }
    
    
    
    func emojiSetter(for card : Card )-> String {
        
        if newGame {
            Choices = Themes[Int(arc4random_uniform(3))]!
            newGame = false
        }
        
   
        
        if Choices.count > 0 {
            if emoji[card] == nil {
                let randomindex = Choices.index(Choices.startIndex, offsetBy: Int(arc4random_uniform(UInt32(Choices.count))))
                emoji[card] = String(Choices.remove(at: randomindex))
            }
            
        }
        return emoji[card] ?? "?"
    }
        
    
    

    @IBAction func TouchCard(_ sender: UIButton) {
       flipCounts += 1
       if let cardNumber = CardButtons.index(of: sender)
       {
            game.ChooseCard(at: cardNumber)
            UpdateViewFromModel()
       }
       else
       {
        print("Not Here!")
       }
    }
    
    func UpdateViewFromModel(){
        for index in CardButtons.indices {
            let button = CardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emojiSetter(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            else
            {
                button.setTitle(" ", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        Score.attributedText = TextDraw(todraw: "Score : \(game.Score)")
    }
    


    
    
}

