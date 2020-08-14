//
//  Animations.swift
//  Uvijek Korak Ispred
//
//  Created by Marko Vurnek on 14/09/2018.
//  Copyright © 2018 Marko Vurnek. All rights reserved.
//

import SpriteKit

class Animation {
    
    static func loadTextures(from atlas: SKTextureAtlas, withName name: String) -> [SKTexture]{
        var textures = [SKTexture]()
        
        for i in 0..<atlas.textureNames.count{
            let textureName = name + String(i)
            textures.append(atlas.textureNamed(textureName))
        }
        return textures
    }
    
}
