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
    var resumePlayingButton: SKSpriteNode!
    var pausedLabel: SKLabelNode!
    var scoreLabel: SKLabelNode!
    let userDefaults = UserDefaults.standard
    
    var countdownEngaged: Bool!
    
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
    
    var stairCases = [Staircase]()
    
    

    
    
    // MARK: - Methods
    func createStaircase() {
        stairCase = Staircase(frame: frame)
        stairCase.createStairSections(with: ball)
        addChild(stairCase)
//        stairCases.append(stairCase)
    }
    
    func startGame() {
        GlobalVariables.shared.gameState = .playing
        physicsWorld.contactDelegate = self
        
        ballCenterPosition = 110
        ball = Ball()
        ball.position = CGPoint(x: ballCenterPosition, y: 4800)
        addChild(ball)
        generateStaircase()
    }
    
    
    func generateStaircase() {
        let wait = SKAction.wait(forDuration: 5.033)
        var createStaircaseAction: SKAction!
        
        createStaircaseAction = SKAction.run {
           self.createStaircase()
        }
        
        let stairGenerationSequence = SKAction.sequence([createStaircaseAction, wait])
        let repeatForever = SKAction.repeatForever(stairGenerationSequence)
        run(repeatForever)
        
    }
    
    func ballCollided(with node: SKNode) {
        if node.name == "scoreDetect" {
            self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
            score += 1
            ball.changeBallTexture()
            ball.run(.rotate(byAngle: -15, duration: 5))
            updateBallAndStairColor(of: stairCase, and: ball)
        } else if node.name == "endGameDetect" {
            endGame()
        } else {
            score += 1
            ball.changeBallTexture()
            ball.run(.rotate(byAngle: -15, duration: 5))
            updateBallAndStairColor(of: stairCase, and: ball)
        }
    }
    
    func createPlayingHud() {
        pauseButton = SKSpriteNode(imageNamed: "Pause_Button")
        pauseButton.size = CGSize(width: 75, height: 80)
        pauseButton.position = CGPoint(x: (scene?.frame.maxX)! - (pauseButton.size.width + 25), y: (scene?.frame.maxY)! - 150)
        pauseButton.name = "pauseButton"
        addChild(pauseButton)
        
        scoreLabel = SKLabelNode(fontNamed: GlobalVariables.shared.mainFont)
        scoreLabel.text = "Points: 0"
        scoreLabel.color = .white
        scoreLabel.fontSize = 30
        scoreLabel.zPosition = 11
        scoreLabel.position = CGPoint(x: frame.midX, y: frame.maxY - 175)
        addChild(scoreLabel)
        
    }
    
    func endGame() {
        if score > GlobalVariables.shared.highScore! {
            userDefaults.set(score, forKey: "highScore")
        }
        
        
        scene?.isPaused
        scene?.removeAllActions()
        stairCase?.isPaused
//        stairCase.removeAllActions()
        
        gameOverLabel = SKLabelNode(fontNamed: GlobalVariables.shared.mainFont)
        gameOverLabel.fontSize = 50
        gameOverLabel.text = "GAME OVER"
        gameOverLabel.zPosition = 11
        gameOverLabel.position = CGPoint(x: frame.midX, y: frame.midY + 70)
        addChild(gameOverLabel)
        
        playAgain = SKSpriteNode(imageNamed: "Play_Again")
        playAgain.zPosition = 11
        playAgain.size = CGSize(width: frame.width / 5, height: 115)
        playAgain.position = CGPoint(x: frame.midX, y: frame.midY - 45)
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
                for node in touchedNodes {
                    if node.name == "pauseButton" {
                        GlobalVariables.shared.gameState = .paused
                        
                        scene?.isPaused = true
//                        scene?.removeAllActions()
                        
                        stairCase.isPaused = true
                        
                        pauseButton.alpha = 0
                        
                        resumePlayingButton = SKSpriteNode(imageNamed: "Play_Button")
                        resumePlayingButton.name = "playButton"
                        resumePlayingButton.size = pauseButton.size
                        resumePlayingButton.position = pauseButton.position
                        resumePlayingButton.zPosition = 10
                        addChild(resumePlayingButton)
                        
                        pausedLabel = SKLabelNode(fontNamed: GlobalVariables.shared.mainFont)
                        pausedLabel.text = "Paused"
                        pausedLabel.fontSize = 40
                        pausedLabel.zPosition = 10
                        pausedLabel.position = CGPoint(x: frame.midX, y: frame.midY)
                        addChild(pausedLabel)
                        
                        dimmer = SKSpriteNode(color: UIColor.black, size: CGSize(width: frame.width * 2, height: frame.height * 2))
                        dimmer.position = CGPoint(x: 0, y: 0)
                        dimmer.alpha = 0.6
                        dimmer.zPosition = 9
                        addChild(dimmer)
                    }
                }
                
            case .paused:
                for node in touchedNodes {
                    if node.name == "playButton" {
                        GlobalVariables.shared.gameState = .playing

                        pauseButton.alpha = 1
                        resumePlayingButton.alpha = 0
                        self.scene?.removeAllActions()
                        self.scene?.isPaused = false
                        
                        for child in children as! [SKNode] {
                           if child.name == "stairCase" {
                               child.isPaused = true
                               print(child)
                           }
                        }
                        
                        
                        pausedLabel.run(.fadeOut(withDuration: 0.5))
                        dimmer.run(.fadeOut(withDuration: 0.5))
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            for child in self.children as! [SKNode] {
                               if child.name == "stairCase" {
                                   child.isPaused = false
                                   print(child)
                               }
                            }
                        }
                        
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
//                            self.generateStaircase()
//                        }
//
                        pauseCountdownEnabled = true
//                        pauseCountdown()
                        
                    }
                }
                
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
    
    var pauseCountdownEnabled = false
    
    func pauseCountdown() {
        if pauseCountdownEnabled == true {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.generateStaircase()
            }
            pauseCountdownEnabled = false
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
        
        
//        if GlobalVariables.shared.gameState == .playing {
//            if countdownEngaged == true {
//                for child in children as! [SKNode] {
//                    if child.name == "stairCase" {
//                        child.isPaused = true
//                    }
//                }
//            }
//        }
        
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
        
//        if nodeA == ball {
//            ballCollided(with: nodeB)
//        } else if nodeB == ball {
//            ballCollided(with: nodeA)
//        }
    }
    
}


