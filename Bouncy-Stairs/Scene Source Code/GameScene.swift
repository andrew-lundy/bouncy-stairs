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
    
    var ballCenterPosition: CGFloat!
    
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
        ballCenterPosition = 110
        ball = Ball()
        ball.position = CGPoint(x: ballCenterPosition, y: 4700)
        addChild(ball)
        
        let wait = SKAction.wait(forDuration: 5.03)
        let stairGenerationSequence = SKAction.sequence([create, wait])
        let repeatForever = SKAction.repeatForever(stairGenerationSequence)
        run(repeatForever)
    }
    
    func ballCollided(with node: SKNode) {
//        print("BALL COLLIDED")
        if node.name == "scoreDetect" {
//            print("PLAYER SCORED")
            self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
            score += 1
            ball.changeBallTexture()
            ball.run(.rotate(byAngle: -15, duration: 5))
            updateBallAndStairColor(of: stairCase, and: ball)
        } else if node.name == "endGameDetect" {
//            print("END GAME")
            endGame()
        } else {
//            print("NO NODE NAME")
            score += 1
            ball.changeBallTexture()
            ball.run(.rotate(byAngle: -15, duration: 5))
            updateBallAndStairColor(of: stairCase, and: ball)
        }
    }
    
    func endGame() {
        scene?.removeAllActions()
        stairCase.isPaused = true
    }
    
    func returnDistanceBetweenPoints(startingPoint: CGPoint, endingPoint: CGPoint) -> CGFloat {
        let distanceBetweenX = startingPoint.x - endingPoint.x
        let distanceBetweenY = startingPoint.y - endingPoint.y
        
        let distanceBetweenPoints = sqrt(distanceBetweenX * distanceBetweenX + distanceBetweenY * distanceBetweenY)
        
        return distanceBetweenPoints
        
    }
    
    // MARK: - Init
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        startGame()
        
    }
    
    var dragDistance: CGFloat!
    var startingX: CGFloat!
    var endingX: CGFloat!
    var startingY: CGFloat!
    var endingY: CGFloat!
    
    var startingPoint: CGPoint!
    var endingPoint: CGPoint!
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            startingPoint = touch.location(in: self)
            print(touch.location(in: self).y)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
      
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            endingPoint = touch.location(in: self)
            
            let dragDistance = returnDistanceBetweenPoints(startingPoint: startingPoint, endingPoint: endingPoint)
            ball.physicsBody?.applyImpulse(CGVector(dx: 0, dy: -dragDistance))
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        if ball.position.x < ballCenterPosition || ball.position.x > ballCenterPosition {
            ball.position.x = ballCenterPosition
        }
    }
    
    
    func updateBallAndStairColor(of staircase: SKNode, and ball: SKSpriteNode) {
        for stair in staircase.children {
            guard let stair = stair as? SKShapeNode else { return }
            if stair.fillColor == ball.color {
                stair.name = "scoreDetect"
            } else if stair.fillColor != ball.color {
                stair.name = "endGameDetect"
            }
        }
    }
    
    
    // MARK: - Delegate Methods
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


