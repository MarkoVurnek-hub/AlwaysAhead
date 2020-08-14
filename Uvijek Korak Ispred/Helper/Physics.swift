//
//  Physics.swift
//  Uvijek Korak Ispred
//
//  Created by Marko Vurnek on 13/09/2018.
//  Copyright © 2018 Marko Vurnek. All rights reserved.
//

import SpriteKit

class Physics {
    
    static func addPhsicsBody(to sprite: SKSpriteNode, with name:String){
        
        switch name {
        case "Player":
            sprite.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sprite.size.width/2, height: sprite.size.height/2))
            sprite.physicsBody!.restitution = 0
            sprite.physicsBody!.allowsRotation = false
            sprite.physicsBody!.categoryBitMask = Constants.PhysicsGroup.playerGroup
            sprite.physicsBody!.collisionBitMask = Constants.PhysicsGroup.groundGropu | Constants.PhysicsGroup.finishedFroup
            sprite.physicsBody!.contactTestBitMask = Constants.PhysicsGroup.allGroup
        case "END":
            sprite.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
            sprite.physicsBody!.categoryBitMask = Constants.PhysicsGroup.finishedFroup
        case "Enemy":
            sprite.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
            sprite.physicsBody!.categoryBitMask = Constants.PhysicsGroup.enemyGroup
        case "Coin", "Super1", "Super2", "Super3":
            sprite.physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.width/2)
            sprite.physicsBody!.categoryBitMask = Constants.PhysicsGroup.collectableGroup
       
        default:
            sprite.physicsBody = SKPhysicsBody(rectangleOf: sprite.size)
        }
        if name != "Player"{
            sprite.physicsBody!.contactTestBitMask = Constants.PhysicsGroup.playerGroup
            sprite.physicsBody!.isDynamic = false
        }
        
    }
    
    static func addPhysicsBody (to tileMap: SKTileMapNode, and tileInfo: String){
        
        let tileSize = tileMap.tileSize
        
        for r in 0..<tileMap.numberOfRows{
            var tiles = [Int]()
            for c in 0..<tileMap.numberOfColumns{
                let tileDefinition = tileMap.tileDefinition(atColumn: c, row: r)
                let isUsed = tileDefinition?.userData?[tileInfo] as? Bool
                if (isUsed ?? false){
                    tiles.append(1)
                }else{
                    tiles.append(0)
                }
            }
            if tiles.contains(1){
            
                var groundPlatorm = [Int]()
            
                for (index, tile) in tiles.enumerated(){
                    if tile == 1 && index < (tileMap.numberOfColumns - 1){
                        groundPlatorm.append(index)
                    }else if !groundPlatorm.isEmpty{
                        let x = CGFloat(groundPlatorm[0]) * tileSize.width
                        let y = CGFloat(r) * tileSize.height
                      
                        let tileNode = GroundNode(with: CGSize(width: tileSize.width * CGFloat(groundPlatorm.count), height: tileSize.height))
                        tileNode.position = CGPoint(x: x, y: y)
                        tileNode.anchorPoint = CGPoint.zero
                        tileMap.addChild(tileNode)
                        
                        groundPlatorm.removeAll()
                    }
                }
        
            }
        }
       
    }
  
    
}




