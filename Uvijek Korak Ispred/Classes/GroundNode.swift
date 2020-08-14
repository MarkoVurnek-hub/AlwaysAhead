//
//  GroundNode.swift
//  Uvijek Korak Ispred
//
//  Created by Marko Vurnek on 13/09/2018.
//  Copyright © 2018 Marko Vurnek. All rights reserved.
//

import SpriteKit

class GroundNode: SKSpriteNode {

    var isActivated: Bool = false{
        
        didSet{
            
            physicsBody = isActivated ? activated : nil
        }
  }
    private var activated: SKPhysicsBody?
    
    init(with size: CGSize) {
        super.init(texture: nil, color: UIColor.clear, size: size)
        let initialPoint = CGPoint(x: 0, y: size.height)
        let endPoint = CGPoint(x: size.width, y: size.height)
        activated = SKPhysicsBody(edgeFrom: initialPoint, to: endPoint)
        activated!.restitution = 0
        activated!.categoryBitMask = Constants.PhysicsGroup.groundGropu
        activated!.collisionBitMask = Constants.PhysicsGroup.playerGroup
        physicsBody = isActivated ? activated : nil
        name = "GroundNode"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
