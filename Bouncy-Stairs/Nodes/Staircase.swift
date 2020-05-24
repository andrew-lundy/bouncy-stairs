//
//  Staircase.swift
//  Bouncy-Stairs
//
//  Created by Andrew Lundy on 4/29/20.
//  Copyright © 2020 Andrew Lundy. All rights reserved.
//

import Foundation
import SpriteKit

class Staircase: SKNode {
    var colors = [UIColor.yellow, UIColor.red, UIColor.blue, UIColor.green]
    let stairSize = CGSize(width: 150, height: 25)
    var stairRect: CGRect!

    var stairOne: SKShapeNode!
    var stairTwo: SKShapeNode!
    var stairThree: SKShapeNode!
    var stairFour: SKShapeNode!
    var stairFive: SKShapeNode!
    var stairSix: SKShapeNode!
    var stairSeven: SKShapeNode!
    var stairEight: SKShapeNode!
    var stairNine: SKShapeNode!
    var stairTen: SKShapeNode!
    var stairEleven: SKShapeNode!
    var stairTwelve: SKShapeNode!
    var stairThirteen: SKShapeNode!
    var stairFourteen: SKShapeNode!
    var stairFifteen: SKShapeNode!
    var stairSixteen: SKShapeNode!
    var stairSeventeen: SKShapeNode!
    var stairEighteen: SKShapeNode!
    var stairNineteen: SKShapeNode!
    var stairTwenty: SKShapeNode!
    var stairTwentyOne: SKShapeNode!
    
    var lastStair: SKNode!
    
    var xPosition: CGFloat!
    var endPosition: CGFloat!
    
    var moveStairs: SKAction!
    var moveSequence: SKAction!
    
    // Pass a 'last stair' node to the initizialization of the staircase so the staircase has the option of being created at the end point of the previous staircase on screen.
    
    init(frame: CGRect) {
        super.init()
        name = "stairCase"
        xPosition = frame.maxX + 150
        createStaircase(at: xPosition)
    }
    
    
    init(frame: CGRect, connectedTo lastStair: SKNode) {
        super.init()
        name = "stairCase"
        xPosition = lastStair.position.x
        createStaircase(at: xPosition)
    
    }
    
    
    func createStaircase(at xPosition: CGFloat) {
        endPosition = frame.minX - 5000
        stairRect = CGRect(x: xPosition, y: frame.minY, width: stairSize.width, height: stairSize.height)
        moveStairs = SKAction.move(to: CGPoint(x: endPosition, y: self.position.y), duration: 8)
        moveSequence = SKAction.sequence([moveStairs, SKAction.removeFromParent()])
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func assignPhysicsBodyAndName(to stair: SKShapeNode, with ball: SKSpriteNode) {
        
        stair.physicsBody = SKPhysicsBody(rectangleOf: stairSize, center: CGPoint(x: stairSize.width * 10 + 60, y: stairSize.height / 2))
        
        stair.physicsBody?.isDynamic = false
        stair.physicsBody?.contactTestBitMask = CollisionTypes.ball.rawValue
        stair.physicsBody?.collisionBitMask = CollisionTypes.ball.rawValue
        stair.physicsBody?.categoryBitMask = CollisionTypes.stair.rawValue
        
        if stair.fillColor == ball.color {
            stair.name = "scoreDetect"
        } else if stair.fillColor != ball.color {
            stair.name = "endGameDetect"
        } else {
            stair.name = "scoreDetect"
        }
    }
    
    func setStairColor(of stair: SKShapeNode, withIterator iterator: Int, withBall ball: SKSpriteNode) {
        if iterator == 1 {
            stair.fillColor = ball.color
        } else {
            stair.fillColor = colors.randomElement()!
        }
        
        stair.strokeColor = stair.fillColor
    }
    
    func createStairSections(with ball: SKSpriteNode) {
        // First Section
        for i in 1...4 {
            let stair = SKShapeNode(rect: stairRect)
            
            setStairColor(of: stair, withIterator: i, withBall: ball)
            
            stair.position = CGPoint(x: 0 + (CGFloat(i) * stairSize.width), y: 200 - (CGFloat(i) * stairSize.height))
            assignPhysicsBodyAndName(to: stair, with: ball)
            
            self.addChild(stair)
        }
        
        for i in 1...3 {
            let stair = SKShapeNode(rect: stairRect)
            stair.fillColor = colors.randomElement()!
            stair.strokeColor = stair.fillColor
            stair.position = CGPoint(x: (stairRect.size.width * 4) + (CGFloat(i) * stairSize.width), y: (stairSize.height * 4) + (CGFloat(i) * stairSize.height))
            assignPhysicsBodyAndName(to: stair, with: ball)
            
            self.addChild(stair)
        }
        
        // Second Section
        for i in 1...4 {
            let stair = SKShapeNode(rect: stairRect)
            stair.fillColor = colors.randomElement()!
            stair.strokeColor = stair.fillColor
            stair.position = CGPoint(x: (stairRect.size.width * 7) + (CGFloat(i) * stairSize.width), y: 200 - (CGFloat(i) * stairSize.height))
            assignPhysicsBodyAndName(to: stair, with: ball)
            
            self.addChild(stair)
        }
        
        for i in 1...3 {
            let stair = SKShapeNode(rect: stairRect)
            stair.fillColor = colors.randomElement()!
            stair.strokeColor = stair.fillColor
            stair.position = CGPoint(x: (stairRect.size.width * 11) + (CGFloat(i) * stairSize.width), y: (stairSize.height * 4) + (CGFloat(i) * stairSize.height))
            assignPhysicsBodyAndName(to: stair, with: ball)
            
            self.addChild(stair)
        }
        
        // Third Section
        for i in 1...4 {
            let stair = SKShapeNode(rect: stairRect)
            stair.fillColor = colors.randomElement()!
            stair.strokeColor = stair.fillColor
            stair.position = CGPoint(x: (stairRect.size.width * 14) + (CGFloat(i) * stairSize.width), y: 200 - (CGFloat(i) * stairSize.height))
            assignPhysicsBodyAndName(to: stair, with: ball)
            
            self.addChild(stair)
        }
        
      for i in 1...3 {
        
        let stair = SKShapeNode(rect: stairRect)
        stair.fillColor = colors.randomElement()!
        stair.strokeColor = stair.fillColor
        stair.position = CGPoint(x: (stairRect.size.width * 18) + (CGFloat(i) * stairSize.width), y: (stairSize.height * 4) + (CGFloat(i) * stairSize.height))
        assignPhysicsBodyAndName(to: stair, with: ball)
        
        if i == 3 {
            stair.name = "lastStair"
        }
        
        self.addChild(stair)
        
        }
        self.run(moveSequence)
    }
}
