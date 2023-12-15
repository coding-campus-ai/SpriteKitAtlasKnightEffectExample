//
//  GameScene.swift
//  SpriteKitAtlasKnightEffectExample
//
//  Created by Jihun Kang on 2023/12/15.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var knight: SKSpriteNode!
    private var ghostKnight:SKSpriteNode!

    var textures : [SKTexture] = [SKTexture]()
    var lastKnightTexture : SKTexture!

    override func didMove(to view: SKView) {
        self.physicsWorld.gravity = CGVector.zero

        //self.physicsWorld.gravity = CGVector(dx:0, dy:-2)
        let imageAtlas = SKTextureAtlas(named: "knight")
        for i in 1...imageAtlas.textureNames.count {
            let knightImage = "knight\(i)"
            textures.append(SKTexture(imageNamed: knightImage))
        }
        if textures.count>0 {
            // Prepare the ghost
            ghostKnight = SKSpriteNode(texture:textures.first)
            addChild(ghostKnight)
            ghostKnight.alpha = 0.2
            ghostKnight.position = CGPoint(x:self.frame.midX,y:100)
            lastKnightTexture = ghostKnight.texture

            // Prepare my sprite
            knight =  SKSpriteNode(texture:textures.first,size:CGSize(width:1,height:1))
            knight.zPosition = 2
            addChild(knight)
            knight.position = CGPoint(x:self.frame.midX,y:self.frame.midY)
        }
        let ghostAnimation = SKAction.repeatForever(SKAction.animate(with: textures, timePerFrame: 0.15, resize: true, restore: false))
        ghostKnight.run(ghostAnimation,withKey:"ghostAnimation")
        let animation = SKAction.repeatForever(SKAction.animate(with: textures, timePerFrame: 0.15, resize: false, restore: false))
        knight.run(animation,withKey:"knight")

    }
    
    override func didEvaluateActions() {
        if ghostKnight.action(forKey: "ghostAnimation") != nil {
            if ghostKnight.texture != lastKnightTexture {
                setPhysics()
                lastKnightTexture = ghostKnight.texture
            }
        }
    }

    func setPhysics() {
        if let _ = knight.physicsBody{
            knight.xScale = ghostKnight.frame.size.width
            knight.yScale = ghostKnight.frame.size.height
        } else {
            knight.physicsBody = SKPhysicsBody.init(rectangleOf: knight.frame.size)
            knight.physicsBody?.isDynamic = true
            knight.physicsBody?.allowsRotation = false
            knight.physicsBody?.affectedByGravity = true
        }
    }

}
