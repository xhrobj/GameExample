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
        skView.showsFPS = true
        skView.showsNodeCount = true
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
