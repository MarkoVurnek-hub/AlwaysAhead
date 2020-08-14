//
//  Banner.swift
//  Uvijek Korak Ispred
//
//  Created by Marko Vurnek on 16/09/2018.
//  Copyright © 2018 Marko Vurnek. All rights reserved.
//

import SpriteKit

class Banner: SKSpriteNode {

    init(withTitle title: String) {
        let texture = SKTexture(imageNamed: "Banner")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        
        let label = SKLabelNode(fontNamed: "Oswald Stencil")
        label.fontSize = 200
        label.verticalAlignmentMode = .center
        label.text = title
        label.scale(to: size, width: false, multiplier: 0.3)
        label.zPosition = Constants.Positions.hud
        addChild(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
