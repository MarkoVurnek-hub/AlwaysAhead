//
//  OverlayNode.swift
//  Uvijek Korak Ispred
//
//  Created by Marko Vurnek on 16/09/2018.
//  Copyright © 2018 Marko Vurnek. All rights reserved.
//

import SpriteKit

class OverlayNode: SKSpriteNode {
    
    var myButtons = ["MenuButton", "PlayButton", "RetryButton", "CancelButton"]
    var buttonHandler: OverlayButtonDelegate
    
    init(withTitle title: String, and texture: SKTexture, buttonHandler: OverlayButtonDelegate) {
        self.buttonHandler = buttonHandler
        
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        
        let bannerLabel = Banner(withTitle: title)
        bannerLabel.scale(to: size, width: true, multiplier: 1.1)
        bannerLabel.zPosition = Constants.Positions.hud
        bannerLabel.position = CGPoint(x: frame.midX, y: frame.maxY)
        addChild(bannerLabel)
    }
    
    func add(buttons: [Int]) {
        
        let scalar = 1.0/CGFloat(buttons.count-1)
        
        for (index, button) in buttons.enumerated(){
            let buttonToAdd = SpriteKitButton(defaultButtonImage: myButtons[index], action: buttonHandler.overlayButtonHandler, index: button)
            buttonToAdd.position = CGPoint(x: -frame.maxX/2 + CGFloat(index) * scalar * (frame.size.width*0.5), y: frame.minY)
            buttonToAdd.zPosition = Constants.Positions.hud
            buttonToAdd.scale(to: frame.size, width: true, multiplier: 0.2)
            addChild(buttonToAdd)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
