//
//  Professor.swift
//  Uvijek Korak Ispred
//
//  Created by Marko Vurnek on 13/09/2018.
//  Copyright © 2018 Marko Vurnek. All rights reserved.
//

import SpriteKit

enum ProfessorState{
    case idle, running
}

class Professor: SKSpriteNode {

    var air = false
    var run = [SKTexture]()
    var idle = [SKTexture]()
    var jump = [SKTexture]()
    
    var state = ProfessorState.idle{
        willSet{
            animate(for: newValue)
        }
        
    }
    func loadTextures(){
        idle = Animation.loadTextures(from: SKTextureAtlas(named: "Idle"), withName: "gameCharacter_0000")
        run = Animation.loadTextures(from: SKTextureAtlas(named: "Run"), withName: "Run")
        jump = Animation.loadTextures(from: SKTextureAtlas(named: "Jump"), withName: "jump#_")
    }
    
    func animate(for state: ProfessorState){
        removeAllActions()
        switch state {
        case .idle:
            self.run(SKAction.repeatForever(SKAction.animate(with: idle, timePerFrame: 0.1, resize: true, restore: true)))
        case .running:
            self.run(SKAction.repeatForever(SKAction.animate(with: run, timePerFrame: 0.01, resize: true, restore: true)))
        }
    }
}
