//
//  Particle.swift
//  Uvijek Korak Ispred
//
//  Created by Marko Vurnek on 15/09/2018.
//  Copyright © 2018 Marko Vurnek. All rights reserved.
//

import SpriteKit

class Particle {
    
    static func addEffect(name: String, particlePositionRange: CGVector, position: CGPoint) -> SKEmitterNode?{
        
        if let emitter = SKEmitterNode(fileNamed: name){
            emitter.particlePositionRange = particlePositionRange
            emitter.position = position
            emitter.name = name
            return emitter
        }
        return nil
    }
    static func removeEffect(name: String, from node: SKNode) {
            let emitters = node[name]
        
        for emitter in emitters {
            emitter.removeFromParent()
        }
    }
    
}
