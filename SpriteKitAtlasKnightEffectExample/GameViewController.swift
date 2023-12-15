//
//  GameViewController.swift
//  SpriteKitAtlasKnightEffectExample
//
//  Created by Jihun Kang on 2023/12/15.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            let scene = GameScene()
            
            scene.scaleMode = .resizeFill
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
            
            view.presentScene(scene)
        }
    }

}


