//
//  GameViewController.swift
//
//  Created by Szymon Lorenz on 21/1/20.
//  Copyright © 2020 Szymon Lorenz. All rights reserved.
//

import Cocoa
import SwiftUI
import SpriteKit
import GameplayKit

struct MenuView: NSViewControllerRepresentable {
    func makeNSViewController(context: NSViewControllerRepresentableContext<MenuView>) -> MenuViewController {
        return MenuViewController()
    }

    func updateNSViewController(_ nsViewController: MenuViewController, context: NSViewControllerRepresentableContext<MenuView>) {
        
    }
}

class MenuViewController: NSViewController {
    override func loadView() {
        view = SKView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = MenuScene.newScene()
        
        // Present the scene
        let skView = self.view as! SKView
        skView.presentScene(scene)
        
        skView.ignoresSiblingOrder = true
        
        skView.showsFPS = true
        skView.showsNodeCount = true
    }
}
