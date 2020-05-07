//
//  GameScene.swift
//  Bouncy-Stairs
//
//  Created by Andrew Lundy on 4/28/20.
//  Copyright © 2020 Andrew Lundy. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // MARK: - Properties
    var stairCase: Staircase!
    var secondStairCase: Staircase!
    var ball: Ball!
    var score: Int!
    
    
    // MARK: - Methods
    func createStaircase() {
        stairCase = Staircase(frame: frame)
        stairCase.createStairSections()
        addChild(stairCase)
    }
    
    func startGame() {
        
        let create = SKAction.run {
            self.createStaircase()
        }
        
        score = 0
        
        ball = Ball()
        addChild(ball)
        
        let wait = SKAction.wait(forDuration: 5.03)
        let stairGenerationSequence = SKAction.sequence([create, wait])
        let repeatForever = SKAction.repeatForever(stairGenerationSequence)
        run(repeatForever)
    }
    
    func ballCollided(with node: SKNode) {
        if node.name == "scoreDetect" {
            print("PLAYER SCORED")
            self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
            score += 1
            ball.changeBallTexture()
            
        }
    }
    
    // MARK: - Init
    override func didMove(to view: SKView) {
        startGame()
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
   
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if nodeA == ball {
            
        }
        
    }
    
}


