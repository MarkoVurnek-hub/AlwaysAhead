//
//  Constants.swift
//  Uvijek Korak Ispred
//
//  Created by Marko Vurnek on 13/09/2018.
//  Copyright © 2018 Marko Vurnek. All rights reserved.
//

import Foundation
import CoreGraphics

struct Constants {
    
    struct PhysicsGroup{
        
        static let noGroup: UInt32 = 0
        static let allGroup: UInt32 = UInt32.max
        static let playerGroup: UInt32 = 0x1
        static let groundGropu: UInt32 = 0x1 << 1
        static let finishedFroup: UInt32 = 0x1 << 2
        static let collectableGroup: UInt32 = 0x1 << 3
        static let enemyGroup: UInt32 = 0x1 << 4
        static let frameGroup: UInt32 = 0x1 << 5
        static let ceilingGroup: UInt32 = 0x1 << 6
        
    }
    
    struct Positions {
        static let farBG: CGFloat = 0
        static let closeBG: CGFloat = 1
        static let world: CGFloat = 2
        static let object: CGFloat = 3
        static let player: CGFloat = 4
        static let hud: CGFloat = 5
    }
}
