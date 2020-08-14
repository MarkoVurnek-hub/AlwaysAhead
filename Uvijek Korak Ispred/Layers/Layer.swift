//
//  Layer.swift
//  Uvijek Korak Ispred
//
//  Created by Marko Vurnek on 13/09/2018.
//  Copyright © 2018 Marko Vurnek. All rights reserved.
//

import SpriteKit

//Infix operators for CGPoint operations

public func * (point: CGPoint, scalar: CGFloat) -> CGPoint{
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

public func + (left: CGPoint, right: CGPoint) -> CGPoint{
   return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

public func += (left: inout CGPoint, right: CGPoint){
    left = left + right
}

public

class WorldLayer: SKNode {
    
    var layerVelocity = CGPoint.zero
    
    func update(_ delta: TimeInterval){
        for child in children{
            updateNodesGlobal(delta, childNode: child)
        }
        
    }
    
    func updateNodesGlobal(_ delta: TimeInterval, childNode: SKNode){
        
        let offset = layerVelocity * CGFloat(delta)
        childNode.position += offset
        updateNodes(delta, childNode: childNode)
    }
    
    
    
    func updateNodes(_ delta: TimeInterval, childNode: SKNode){
        
        
    }

}






