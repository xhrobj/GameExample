//
//  GameScene.swift
//  Pong2
//
//  Created by Jared Davidson on 10/11/16.
//  Copyright © 2016 Archetapp. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
   
    fileprivate var menuLabel : SKLabelNode?
    fileprivate var ball = SKSpriteNode()
    fileprivate var enemy = SKSpriteNode()
    fileprivate var main = SKSpriteNode()
    
    var topLbl = SKLabelNode()
    var btmLbl = SKLabelNode()
    
    var score = [Int]()
    
    class func newScene() -> GameScene {
        // Load 'SettingsScene.sks' as an SKScene.
        guard let scene = SKScene(fileNamed: "GameScene") as? GameScene else {
            print("Failed to load GameScene.sks")
            abort()
        }
        
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .resizeFill
        
        return scene
    }
    
    override func didMove(to view: SKView) {
        menuLabel = childNode(withName: "//menuLabel") as? SKLabelNode
        
        topLbl = self.childNode(withName: "topLabel") as! SKLabelNode
        btmLbl = self.childNode(withName: "btmLabel") as! SKLabelNode
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        
        print(self.view?.bounds.height)
        print(self.view?.bounds.width)
        print(self.frame)

        menuLabel?.position.x = (self.frame.width / 2) - 50
        menuLabel?.position.y = (self.frame.height / 2) - 50
        
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        enemy.position.y = (self.frame.height / 2) - 50

        main = self.childNode(withName: "main") as! SKSpriteNode
        main.position.y = (-self.frame.height / 2) + 50
        
        let border  = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        
        startGame()
    }
    
    func startGame() {
        score = [0,0]
        topLbl.text = "\(score[1])"
        btmLbl.text = "\(score[0])"
        ball.physicsBody?.applyImpulse(CGVector(dx: 5 , dy: 5))
    }

    func addScore(playerWhoWon : SKSpriteNode){
        
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerWhoWon == main {
            score[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: 5, dy: 5))
        }
        else if playerWhoWon == enemy {
            score[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx: -5, dy: -5))
        }
        
        topLbl.text = "\(score[1])"
        btmLbl.text = "\(score[0])"
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.3))
        
        if ball.position.y <= main.position.y - 30 {
            addScore(playerWhoWon: enemy)
        }
        else if ball.position.y >= enemy.position.y + 30 {
            addScore(playerWhoWon: main)
        }
    }
}

#if os(iOS) || os(tvOS)
// Touch-based event handling
extension GameScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            main.run(SKAction.moveTo(x: location.x, duration: 0.2))
            
            let touchNode:SKNode = self.atPoint(location)
            if touchNode.name == "menuLabel" {
                menuLabel?.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
                view?.presentScene(MenuScene.newScene())
            }
        }
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            main.run(SKAction.moveTo(x: location.x, duration: 0.2))
        }
    }
}
#endif

#if os(OSX)
// Mouse-based event handling
extension GameScene {
    override func mouseDown(with event: NSEvent) {
        let location = event.location(in: self)
        let touchNode:SKNode = self.atPoint(location)
        
        main.run(SKAction.moveTo(x: location.x, duration: 0.2))
        
        if touchNode.name == "menuLabel" {
            menuLabel?.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
            view?.presentScene(MenuScene.newScene())
        }
    }
    
    override func mouseDragged(with event: NSEvent) {
        let location = event.location(in: self)
        main.run(SKAction.moveTo(x: location.x, duration: 0.2))
    }
}
#endif




