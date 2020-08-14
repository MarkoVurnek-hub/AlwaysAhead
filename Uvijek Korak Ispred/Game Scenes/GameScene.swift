//
//  GameScene.swift
//  Uvijek Korak Ispred
//
//  Created by Marko Vurnek on 12/09/2018.
//  Copyright © 2018 Marko Vurnek. All rights reserved.
//

import SpriteKit

enum State {
    case ready, going, paused, finished
}

class GameScene: SKScene {
    
    var mapNode: SKNode!
    var tileMap: SKTileMapNode!
    var mapLayer: WorldLayer!
    var time: TimeInterval = 0
    var dt: TimeInterval = 0
    var worldState = State.ready{
        willSet{
            switch newValue {
            case .going:
                player.state = .running
            case .finished:
                player.state = .idle
            default:
                break
            }
            
        }
    }
    var brake = false
    var coins = 0
    var bigCoin = 0
    var background: BackgroundLayer!
    var player: Professor!
    
   var hudDelegate: HUDDelegate?
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -7)
        
        physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: frame.minX, y: frame.minY), to: CGPoint(x: frame.maxX, y: frame.minY))
        physicsBody!.categoryBitMask = Constants.PhysicsGroup.frameGroup
        physicsBody!.contactTestBitMask = Constants.PhysicsGroup.playerGroup
        
       buildLayer()
    }
    
    func buildLayer(){
        mapLayer = WorldLayer()
        mapLayer.zPosition = Constants.Positions.world
        addChild(mapLayer)
        mapLayer.layerVelocity = CGPoint(x: -190, y: 0)
        background = BackgroundLayer()
        background.zPosition = Constants.Positions.farBG
        addChild(background)
        
        for i in 0...1{
            let backgroundImage = SKSpriteNode(imageNamed: "BG")
            backgroundImage.name = String(i)
            backgroundImage.scale(to: frame.size, width: false, multiplier: 1)
            backgroundImage.anchorPoint = CGPoint.zero
            backgroundImage.position = CGPoint(x: 0 + CGFloat(i) * backgroundImage.size.width, y: 0)
            background.addChild(backgroundImage)
        }
        background.layerVelocity = CGPoint(x: -95, y: 0)
        load(level: "Level0_1")
        
    }
    
    func load(level: String){
        if let levelNode = SKNode.unarchiveFile(file: level){
            mapNode = levelNode
            mapLayer.addChild(mapNode)
            loadTileMap()
        }
        
    }
    func loadTileMap(){
        if let groundTiles = mapNode.childNode(withName: "Graveyard Tiles") as? SKTileMapNode{
            tileMap = groundTiles
            tileMap.scale(to: frame.size, width: false, multiplier: 1)
            Physics.addPhysicsBody(to: tileMap, and: "ground")
            for child in groundTiles.children{
                if let sprite = child as? SKSpriteNode, sprite.name != nil {
                    Object.handleChild(sprite: sprite, with: sprite.name!)
                }
            }
        }
        addProfessor()
      addHUD()
    }
    
    func addProfessor(){
        
        player = Professor(imageNamed: "gameCharacter_00000")
        player.scale(to: frame.size, width: false, multiplier: 0.3)
        player.name = "Player"
        Physics.addPhsicsBody(to: player, with: player.name!)
        player.position = CGPoint(x: frame.midX/2, y: frame.midY)
        player.zPosition = Constants.Positions.player
        player.loadTextures()
        player.state = .idle
        addChild(player)
        addPlayerActions()
    }
    
    func addPlayerActions(){
        let up = SKAction.moveBy(x: 0, y: frame.size.height/4, duration: 0.3)
        up.timingMode = .easeOut
        
        player.createUserData(entry: up, forKey: "jumpUp")
        
        let move = SKAction.moveBy(x: 0, y: player.size.height, duration: 0.3)
        let jump = SKAction.animate(with: player.jump, timePerFrame: 0.3 / Double(player.jump.count))
        let group = SKAction.group([move, jump])
        player.createUserData(entry: group, forKey: "descend")
    }
    func jump(){
        player.air = true
        player.turnGravity(on: false)
        player.run(player.userData?.value(forKey: "jumpUp") as! SKAction){
            self.player.turnGravity(on: true)
        }
    }
    func descend(){
        brake = true
        player.physicsBody!.velocity.dy = 10
        player.run(player.userData?.value(forKey: "descend") as! SKAction)
    }
    
    func enemyContact(){
        die(reason: 0)
        
    }
    func handleCOllectable(sprite: SKSpriteNode){
        switch sprite.name! {
        case "Coin", "Super1", "Super2", "Super3":
            collectCoin(sprite: sprite)
        default:
            break
        }
    }
    
    func collectCoin(sprite: SKSpriteNode){
        let bigGold = ["Super3", "Super1", "Super2"]
        
        if bigGold.contains(sprite.name!){
           
            bigCoin += 1
            
            for index in 0..<3 {
                
                if  bigGold[index] == sprite.name!{
                    hudDelegate?.addBigCoins(index: index)
                }
            }
            
        }else{
            coins += 1
            hudDelegate?.updateCoinLabel(coins: coins)
        }
        
     
        
        /*if let coinMagic = Particle.addEffect(name: "CoinMagic", particlePositionRange: CGVector(dx: 5, dy: 5), position: CGPoint.zero){
            coinMagic.zPosition = Constants.Positions.object
            sprite.addChild(coinMagic)
            sprite.run(SKAction.fadeOut(withDuration: 0.5), completion: {
                coinMagic.removeFromParent()
                sprite.removeFromParent()
            })
        }*/
         sprite.removeFromParent()
    }

    func addHUD(){
        
        let hud = HUDGame(with: CGSize(width: frame.width, height: frame.height*0.1))
        hud.position = CGPoint(x: frame.midX, y: frame.maxY - frame.height*0.05)
        hud.zPosition = Constants.Positions.hud
        hudDelegate = hud
        addChild(hud)
    }
   
    func die(reason: Int){
        worldState = .finished
        player.turnGravity(on: false)
        
        let heaven = SKAction.moveTo(y: frame.maxY * 2, duration: 0.8)
        let up = SKAction.moveTo(y: player.frame.height, duration: 0.25)
        let down = SKAction.moveTo(y: -player.size.height, duration: 0.3)
        let wait = SKAction.wait(forDuration: 0.2)
        let death: SKAction!
        switch reason {
        case 0:
           death = SKAction.sequence([wait,heaven])
        case 1:
            death = SKAction.sequence([up, wait, down])
        default:
            death = SKAction.sequence([wait, down])
        }
        player.run(death){
            self.player.removeFromParent()
        }
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch worldState {
        case .ready:
            worldState = .going
        case .going:
            if !player.air {
                
                 jump()
                
            }else if !brake {
                descend()
            }
           
        default:
            break
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        player.turnGravity(on: true)
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        player.turnGravity(on: true)
    }
   
    override func update(_ currentTime: TimeInterval) {
       
        if time > 0{
            dt = currentTime - time
        }else{
            dt = 0
        }
        time = currentTime
        if worldState == .going{
        mapLayer.update(dt)
        background.update(dt)
        }
    }

    override func didSimulatePhysics() {
        for node in tileMap["GroundNode"]{
            if let groundNode = node as? GroundNode{
                let groundY = (groundNode.position.y + groundNode.size.height) * tileMap.yScale
                let playerY = player.position.y - player.size.height/4
                groundNode.isActivated = playerY > groundY
            }
        }
    }



}

extension GameScene: SKPhysicsContactDelegate{
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        switch contactMask {
        
        case Constants.PhysicsGroup.playerGroup | Constants.PhysicsGroup.groundGropu:
            player.air = false
            brake = false
        case Constants.PhysicsGroup.playerGroup | Constants.PhysicsGroup.finishedFroup:
            worldState = .finished
        case Constants.PhysicsGroup.playerGroup | Constants.PhysicsGroup.enemyGroup:
            enemyContact()
        case Constants.PhysicsGroup.playerGroup | Constants.PhysicsGroup.frameGroup:
           physicsBody = nil
            die(reason: 1)
        case Constants.PhysicsGroup.playerGroup | Constants.PhysicsGroup.collectableGroup:
            let collectable = contact.bodyA.node?.name == player.name ? contact.bodyB.node as! SKSpriteNode : contact.bodyA.node as! SKSpriteNode
            handleCOllectable(sprite: collectable)
        default:
            break
        }
 
    func didEnd(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        switch contactMask {
        case Constants.PhysicsGroup.playerGroup | Constants.PhysicsGroup.groundGropu:
            player.air = true
        default:
            break
        
        }
    }
    
}
}








