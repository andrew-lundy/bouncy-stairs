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
        stairCase.createStairSections(with: ball)
        addChild(stairCase)
    }
    
    func startGame() {
        
        let create = SKAction.run {
            self.createStaircase()
        }
        
        score = 0
        
        ball = Ball()
        ball.position = CGPoint(x: 100, y: 4700)
        addChild(ball)
        
        let wait = SKAction.wait(forDuration: 5.03)
        let stairGenerationSequence = SKAction.sequence([create, wait])
        let repeatForever = SKAction.repeatForever(stairGenerationSequence)
        run(repeatForever)
    }
    
    func ballCollided(with node: SKNode) {
        print("BALL COLLIDED")
        if node.name == "scoreDetect" {
            print("PLAYER SCORED")
            self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
            score += 1
            ball.changeBallTexture()
            ball.run(.rotate(byAngle: -15, duration: 5))
        } else if node.name == "endGameDetect" {
            print("END GAME")
        } else {
            print("NO NODE NAME")
        }
    }
    
    // MARK: - Init
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        startGame()
       
    }
    
    var dragDistance: CGFloat!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let startingX = touch.location(in: self).x
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
//        if ball.position.x
   
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if nodeA == ball {
            ballCollided(with: nodeB)
        } else if nodeB == ball {
            ballCollided(with: nodeA)
        }
    }
    
    
    
}


