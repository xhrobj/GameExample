//
//  GameScene.swift
//  test Shared
//
//  Created by Szymon Lorenz on 10/2/20.
//  Copyright © 2020 Szymon Lorenz. All rights reserved.
//

import SpriteKit

class SettingsScene: SKScene {
    fileprivate var title : SKLabelNode?
    fileprivate var menuLabel : SKLabelNode?
    
    class func newScene() -> SettingsScene {
        // Load 'SettingsScene.sks' as an SKScene.
        guard let scene = SKScene(fileNamed: "SettingsScene") as? SettingsScene else {
            print("Failed to load SettingsScene.sks")
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
extension SettingsScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        let touchNode:SKNode = self.atPoint(location)
        
        if touchNode.name == "menuLabel" {
            menuLabel?.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        let touchNode:SKNode = self.atPoint(location)
        
        if touchNode.name == "menuLabel" {
            view?.presentScene(MenuScene.newScene())
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}
#endif

#if os(OSX)
// Mouse-based event handling
extension SettingsScene {
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
