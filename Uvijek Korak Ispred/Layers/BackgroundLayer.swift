//
//  BackgroundLayer.swift
//  Uvijek Korak Ispred
//
//  Created by Marko Vurnek on 13/09/2018.
//  Copyright © 2018 Marko Vurnek. All rights reserved.
//

import SpriteKit

class BackgroundLayer: WorldLayer {
    
    override func updateNodes(_ delta: TimeInterval, childNode: SKNode) {
        if let node = childNode as? SKSpriteNode {
            if node.position.x >= node.size.width{
                if node.name == "0"  || node.name == "1"  {
                    
                    node.position = CGPoint(x: node.position.x + node.size.width*2, y: node.position.y)
                }
            }
        }
    }
    
}

