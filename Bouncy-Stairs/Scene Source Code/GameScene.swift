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
    var ballCenterPosition: CGFloat!
    var pauseButton: SKSpriteNode!
    var scoreLabel: SKLabelNode!
    let userDefaults = UserDefaults.standard
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Points: \(score)"
        }
    }
    
    var gameOverLabel: SKLabelNode!
    var playAgain: SKSpriteNode!
    var dimmer: SKSpriteNode!
    
    var dragDistance: CGFloat!
    var startingPoint: CGPoint!
    var endingPoint: CGPoint!
    
    
    // MARK: - Methods
    func createStaircase() {
        stairCase = Staircase(frame: frame)
        stairCase.createStairSections(with: ball)
        addChild(stairCase)
    }
    
    func startGame() {
        physicsWorld.contactDelegate = self
        let create = SKAction.run {
            self.createStaircase()
        }
        
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
    
    func createPlayingHud() {
        pauseButton.size = CGSize(width: 75, height: 80)
        pauseButton.position = CGPoint(x: (scene?.frame.maxX)! - (pauseButton.size.width + 25), y: (scene?.frame.maxY)! - 150)
        addChild(pauseButton)
        
        scoreLabel = SKLabelNode(fontNamed: GlobalVariables.shared.mainFont)
        scoreLabel.text = "Points: 0"
        scoreLabel.color = .white
        scoreLabel.fontSize = 32
        scoreLabel.zPosition = 11
        scoreLabel.position = CGPoint(x: (scene?.frame.midX)!, y: (scene?.frame.maxY)! - 175)
        addChild(scoreLabel)
        
    }
    
    func endGame() {
        if score > GlobalVariables.shared.highScore! {
            userDefaults.set(score, forKey: "highScore")
        }
        
        scene?.removeAllActions()
        stairCase.removeAllActions()
        
        
        gameOverLabel = SKLabelNode(fontNamed: GlobalVariables.shared.mainFont)
        gameOverLabel.fontSize = 50
        gameOverLabel.text = "GAME OVER"
        gameOverLabel.zPosition = 11
        gameOverLabel.position = CGPoint(x: frame.midX, y: frame.midY + 70)
        addChild(gameOverLabel)
        
        playAgain = SKSpriteNode(imageNamed: "Play_Again")
        playAgain.zPosition = 11
        playAgain.size = CGSize(width: frame.width / 5, height: 115)
        playAgain.position = CGPoint(x: frame.midX, y: frame.midY - 50)
        playAgain.name = "playAgainButton"
        GlobalVariables.shared.bounce(node: playAgain)
        addChild(playAgain)
        
        dimmer = SKSpriteNode(color: UIColor.black, size: CGSize(width: frame.width * 2, height: frame.height * 2))
        dimmer.position = CGPoint(x: 0, y: 0)
        dimmer.alpha = 0.6
        dimmer.zPosition = 9
        addChild(dimmer)
        
        pauseButton.removeFromParent()
        
        GlobalVariables.shared.gameState = .gameOver
        ball.removeFromParent()
        
        
    }
    
    func returnDistanceBetweenPoints(startingPoint: CGPoint, endingPoint: CGPoint) -> CGFloat {
        let distanceBetweenX = startingPoint.x - endingPoint.x
        let distanceBetweenY = startingPoint.y - endingPoint.y
        
        let distanceBetweenPoints = sqrt(distanceBetweenX * distanceBetweenX + distanceBetweenY * distanceBetweenY)
        
        return distanceBetweenPoints
        
    }
    
    // MARK: - Init
    override func sceneDidLoad() {
         pauseButton = SKSpriteNode(imageNamed: "Pause_Button")
    }
    
    override func didMove(to view: SKView) {
        startGame()
        createPlayingHud()
    }
    
    
        
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            startingPoint = touch.location(in: self)
            let touchedNodes = nodes(at: startingPoint)
            
            switch GlobalVariables.shared.gameState {
            case .playing:
                print("playing")
            case .gameOver:
                for node in touchedNodes {
                    if node.name == "playAgainButton" {
                        guard let newGameScene = SKScene(fileNamed: "GameScene") else { return }
                        newGameScene.scaleMode = .aspectFill
                        scene?.view?.presentScene(newGameScene, transition: .fade(withDuration: 0.7))
                    }
                }
            default:
                print("DEFAULT CASE")
            }
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


