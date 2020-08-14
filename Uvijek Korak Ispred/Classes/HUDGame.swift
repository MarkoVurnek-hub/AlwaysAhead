//
//  HUDGame.swift
//  Uvijek Korak Ispred
//
//  Created by Marko Vurnek on 16/09/2018.
//  Copyright © 2018 Marko Vurnek. All rights reserved.
//

import SpriteKit

class HUDGame: SKSpriteNode, HUDDelegate {
    
    var coinLabel: SKLabelNode
    var superCoinCOunter: SKSpriteNode
    
    init(with size: CGSize){
        coinLabel = SKLabelNode(fontNamed: "Oswald Stencil")
        
        superCoinCOunter = SKSpriteNode(texture: nil, color: UIColor.clear, size: CGSize(width: size.width*0.2, height: size.height*0.8))
        super.init(texture: nil, color: UIColor.clear, size: size)
        
        coinLabel.verticalAlignmentMode = .center
        coinLabel.text = "0"
        coinLabel.fontSize = 200
        coinLabel.scale(to: frame.size, width: false, multiplier: 0.8)
        coinLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        coinLabel.zPosition = Constants.Positions.hud
        addChild(coinLabel)
        
        superCoinCOunter.position = CGPoint(x: frame.maxX - superCoinCOunter.frame.size.width, y: frame.midY)
        superCoinCOunter.zPosition = Constants.Positions.hud
        addChild(superCoinCOunter)
        
        for i in 0..<3{
            let empty = SKSpriteNode(imageNamed: "BigGold")
           
            empty.name = String(i)
            empty.alpha = 0.5
            empty.scale(to: superCoinCOunter.size, width: true, multiplier: 0.5)
            empty.position = CGPoint(x: -superCoinCOunter.size.width/2 + empty.size.width/2 + CGFloat(i)*superCoinCOunter.size.width/2 + superCoinCOunter.size.width*0.05  , y: superCoinCOunter.frame.midY )
            empty.zPosition = Constants.Positions.hud
            superCoinCOunter.addChild(empty)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func updateCoinLabel(coins: Int) {
        coinLabel.text = "\(coins)"
    }
    
    func addBigCoins(index: Int) {
        let empty = superCoinCOunter[String(index)].first as! SKSpriteNode
        empty.alpha = 1
    }
    
}

