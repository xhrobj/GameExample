//
//  GameScene.swift
//  test Shared
//
//  Created by Szymon Lorenz on 10/2/20.
//  Copyright © 2020 Szymon Lorenz. All rights reserved.
//

import SpriteKit

class LeaderboardScene: SKScene {
    fileprivate var title : SKLabelNode?
    fileprivate var menuLabel : SKLabelNode?
    
    private var currentLabelName: String? = nil
    
    class func newScene() -> LeaderboardScene {
        // Load 'LeaderboardScene.sks' as an SKScene.
        guard let scene = SKScene(fileNamed: "LeaderboardScene") as? LeaderboardScene else {
            print("Failed to load LeaderboardScene.sks")
            abort()
        }
        
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill
        
        return scene
    }
    
    func setUpScene() {
        // Get label node from scene and store it for use later
        title = childNode(withName: "//title") as? SKLabelNode
        menuLabel = childNode(withName: "//menuLabel") as? SKLabelNode
        
        #if os(iOS)
        if UIDevice.current.userInterfaceIdiom == .pad {
            title?.position.y = (self.frame.height / 2) - 100
            menuLabel?.position.y = (self.frame.height / 2) - 100
        }
        #endif
        
        #if os(tvOS)
        menuLabel?.isHidden = true
        #endif
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
extension LeaderboardScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        let touchNode:SKNode = self.atPoint(location)
        
        currentLabelName = touchNode.name
        if touchNode.name == "menuLabel" {
            menuLabel?.run(SKAction.init(named: "PressIn")!, withKey: "fadeInOut")
            menuLabel?.fontColor = .red
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        let touchNode:SKNode = self.atPoint(location)
        if touchNode.name != nil && touchNode.name != currentLabelName {
            currentLabelName = touchNode.name
            if touchNode.name == "menuLabel" {
                menuLabel?.run(SKAction.init(named: "PressIn")!, withKey: "fadeInOut")
                menuLabel?.fontColor = .red
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if currentLabelName == "menuLabel" {
            view?.presentScene(MenuScene.newScene())
        }
    }
}
#endif

#if os(OSX)
// Mouse-based event handling
extension LeaderboardScene {
    override func mouseDown(with event: NSEvent) {
        let location = event.location(in: self)
        let touchNode:SKNode = self.atPoint(location)
        
        if touchNode.name == "menuLabel" {
            menuLabel?.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
    }
    
    override func mouseDragged(with event: NSEvent) {
        
    }
    
    override func mouseUp(with event: NSEvent) {
        let location = event.location(in: self)
        let touchNode:SKNode = self.atPoint(location)
        
        if touchNode.name == "menuLabel" {
            view?.presentScene(MenuScene.newScene())
        }
    }
}
#endif
