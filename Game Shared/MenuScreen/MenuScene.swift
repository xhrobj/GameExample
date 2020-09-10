//
//  GameScene.swift
//  test Shared
//
//  Created by Szymon Lorenz on 10/2/20.
//  Copyright © 2020 Szymon Lorenz. All rights reserved.
//

import SpriteKit
#if os(watchOS)
import WatchKit
#endif

class MenuScene: SKScene {
    fileprivate var playLabel : SKLabelNode? = SKLabelNode()
    fileprivate var settingsLabel : SKLabelNode?
    fileprivate var leaderboardLabel : SKLabelNode?
    
    private var currentLabelName: String? = nil

    class func newScene() -> MenuScene {
        // Load 'MenuScene.sks' as an SKScene.
        guard let scene = SKScene(fileNamed: "MenuScene") as? MenuScene else {
            print("Failed to load MenuScene.sks")
            abort()
        }
        
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        
        return scene
    }
    
    func setUpScene() {
        // Get label node from scene and store it for use later
        playLabel = childNode(withName: "//playLabel") as? SKLabelNode

        playLabel?.alpha = 0.0
        playLabel?.run(SKAction.fadeIn(withDuration: 0.5))
        
        settingsLabel = childNode(withName: "//settingsLabel") as? SKLabelNode

        settingsLabel?.alpha = 0.0
        settingsLabel?.run(SKAction.fadeIn(withDuration: 0.7))
        
        leaderboardLabel = childNode(withName: "//leaderboardLabel") as? SKLabelNode

        leaderboardLabel?.alpha = 0.0
        leaderboardLabel?.run(SKAction.fadeIn(withDuration: 1.0))
    }
    
    func resetLabels() {
        playLabel?.fontColor = .white
        settingsLabel?.fontColor = .white
        leaderboardLabel?.fontColor = .white
    }
    
    #if os(watchOS)
    override func sceneDidLoad() {
        self.setUpScene()
    }
    #else
    override func didMove(to view: SKView) {
        self.setUpScene()
    }
    #endif
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}


#if os(iOS) || os(tvOS)
// Touch-based event handling
extension MenuScene {
    
    func pressIn() {
        if currentLabelName == "playLabel" {
            playLabel?.run(SKAction.init(named: "PressIn")!, withKey: "fadeInOut")
            playLabel?.fontColor = .red
        }
        if currentLabelName == "settingsLabel" {
            settingsLabel?.run(SKAction.init(named: "PressIn")!, withKey: "fadeInOut")
            settingsLabel?.fontColor = .red
            
        }
        if currentLabelName == "leaderboardLabel" {
            leaderboardLabel?.run(SKAction.init(named: "PressIn")!, withKey: "fadeInOut")
            leaderboardLabel?.fontColor = .red
        }
    }
    
    func pressOut() {
        if currentLabelName == "playLabel" {
            playLabel?.run(SKAction.init(named: "PressOut")!, withKey: "fadeInOut")
            playLabel?.fontColor = .white
        }
        if currentLabelName == "settingsLabel" {
            settingsLabel?.run(SKAction.init(named: "PressOut")!, withKey: "fadeInOut")
            settingsLabel?.fontColor = .white
            
        }
        if currentLabelName == "leaderboardLabel" {
            leaderboardLabel?.run(SKAction.init(named: "PressOut")!, withKey: "fadeInOut")
            leaderboardLabel?.fontColor = .white
        }
    }
    
    func navigateIfPressed() {
        if currentLabelName == "playLabel" {
            view?.presentScene(GameScene.newScene())
        }
        if currentLabelName == "settingsLabel" {
            view?.presentScene(SettingsScene.newScene())
        }
        if currentLabelName == "leaderboardLabel" {
            view?.presentScene(LeaderboardScene.newScene())
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        let touchNode:SKNode = self.atPoint(location)
        if touchNode.name != currentLabelName {
            currentLabelName = touchNode.name
            pressIn()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        let touchNode:SKNode = self.atPoint(location)
        if touchNode.name != nil && touchNode.name != currentLabelName {
            pressOut()
            currentLabelName = touchNode.name
            pressIn()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        pressOut()
        navigateIfPressed()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}
#endif

#if os(OSX)
// Mouse-based event handling
extension MenuScene {
    override func mouseDown(with event: NSEvent) {
        let location = event.location(in: self)
        let touchNode:SKNode = self.atPoint(location)
        
        if touchNode.name == "playLabel" {
            playLabel?.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        if touchNode.name == "settingsLabel" {
            settingsLabel?.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        if touchNode.name == "leaderboardLabel" {
            leaderboardLabel?.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
    }
    
    override func mouseDragged(with event: NSEvent) {
       
    }
    
    override func mouseUp(with event: NSEvent) {
        let location = event.location(in: self)
        let touchNode:SKNode = self.atPoint(location)
        
        if touchNode.name == "playLabel" {
            view?.presentScene(GameScene.newScene())
        }
        if touchNode.name == "settingsLabel" {
            view?.presentScene(SettingsScene.newScene())
        }
        if touchNode.name == "leaderboardLabel" {
            view?.presentScene(LeaderboardScene.newScene())
        }
    }
}
#endif

#if os(watchOS)
extension MenuScene {
    func didTapGesture(gesture: WKTapGestureRecognizer, completion: (SKScene) -> Void) {
        let location = gesture.locationInObject()
        let screenBounds = WKInterfaceDevice.current().screenBounds
        let newX = ((location.x / screenBounds.width) * self.size.width) - (self.size.width / 2)
        let newY = -(((location.y / screenBounds.height) * self.size.height) - (self.size.height / 2)) - 30
        let newLocation = CGPoint(x: newX, y: newY)
        let touchNode:SKNode = self.atPoint(newLocation)
        if touchNode.name == "playLabel" {
            playLabel?.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
            completion(GameScene.newScene())
        }
        if touchNode.name == "settingsLabel" {
            settingsLabel?.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
            completion(SettingsScene.newScene())
        }
        if touchNode.name == "leaderboardLabel" {
            leaderboardLabel?.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
            completion(LeaderboardScene.newScene())
        }
    }
}
#endif
