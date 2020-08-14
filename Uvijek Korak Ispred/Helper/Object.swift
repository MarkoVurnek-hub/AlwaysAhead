//
//  Object.swift
//  Uvijek Korak Ispred
//
//  Created by Marko Vurnek on 14/09/2018.
//  Copyright © 2018 Marko Vurnek. All rights reserved.
//

import SpriteKit

class Object {
    
    static func handleChild(sprite: SKSpriteNode, with name: String){
        
        switch name {
        case "END", "Enemy", "Super1", "Super2", "Super3":
            Physics.addPhsicsBody(to: sprite, with: name)
        default:
            let component = name.components(separatedBy: NSCharacterSet.decimalDigits.inverted)
            if let rows = Int(component[0]), let columns = Int(component[1]){
                calculateGridWidth(rows: rows, columns: columns, parent: sprite)
            }
        }
        
    }
    
    static func calculateGridWidth(rows: Int, columns: Int, parent: SKSpriteNode){
        parent.color = UIColor.clear
       
        for i in 0..<columns{
            for j in 0..<rows{
                let position = CGPoint(x: i, y: j)
                addCoin(to: parent, at: position, columns: columns)
            }
        }
        
    }
    
    static func addCoin(to parent: SKSpriteNode, at position: CGPoint, columns: Int){
   
        let coin = SKSpriteNode(imageNamed: "gold_0")
        coin.size = CGSize(width: parent.size.width/CGFloat(columns), height: parent.size.width/CGFloat(columns))
        coin.name = "Coin"
        
        
        coin.position = CGPoint(x: position.x * coin.size.width + coin.size.width/2, y: position.y * coin.size.height + coin.size.height/2)
        
        let coinAnimate = Animation.loadTextures(from: SKTextureAtlas(named: "Coins"), withName: "gold_")
        coin.run(SKAction.repeatForever(SKAction.animate(with: coinAnimate, timePerFrame: 0.1)))
        Physics.addPhsicsBody(to: coin, with: "Coin")
        
        parent.addChild(coin)
    }
    
    
}
