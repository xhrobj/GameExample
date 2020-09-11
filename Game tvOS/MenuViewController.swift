//
//  GameViewController.swift
//
//  Created by Szymon Lorenz on 21/1/20.
//  Copyright © 2020 Szymon Lorenz. All rights reserved.
//

import UIKit
import SwiftUI
import SpriteKit
import GameplayKit

struct MenuView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<MenuView>) -> MenuViewController {
        return MenuViewController()
    }

    func updateUIViewController(_ uiViewController: MenuViewController, context: UIViewControllerRepresentableContext<MenuView>) {
        
    }
}

class MenuViewController: UIViewController {
    override func loadView() {
        super.loadView()
        view = SKView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = MenuScene.newScene()
        
        // Present the scene
        let skView = self.view as! SKView
        skView.presentScene(scene)
        
        skView.ignoresSiblingOrder = true
        skView.isPaused = false
        skView.showsFPS = true
        skView.showsNodeCount = true
    }
    
    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        // Detect a remote button press
        
        let skView = self.view as? SKView
        
        if presses.first?.type == .menu && skView?.scene?.name != "menu" {
           
            skView?.presentScene(MenuScene.newScene())
        }
        else { // Pass it to 'super' to allow it to do what it's supposed to do if it's not a menu press
            super.pressesBegan(presses, with: event)
        }
    }
}
