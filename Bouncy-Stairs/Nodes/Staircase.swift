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
    
    init(frame: CGRect) {
        super.init()
        xPosition = frame.maxX + 150
        endPosition = frame.minX - 5000
        stairRect = CGRect(x: xPosition, y: frame.minY, width: stairSize.width, height: stairSize.height)
        moveStairs = SKAction.move(to: CGPoint(x: endPosition, y: self.position.y), duration: 8)
        moveSequence = SKAction.sequence([moveStairs, SKAction.removeFromParent()])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func createStairs() {
        // Section One
        stairOne = SKShapeNode(rect: stairRect)
        stairOne.fillColor = colors.randomElement()!
        stairOne.position = CGPoint(x: 0, y: 200)
        self.addChild(stairOne)
        
        stairTwo = SKShapeNode(rect: stairRect)
        stairTwo.fillColor = colors.randomElement()!
        stairTwo.position = CGPoint(x: stairOne.position.x + stairSize.width, y: stairOne.position.y - stairSize.height)
        self.addChild(stairTwo)
    
        stairThree = SKShapeNode(rect: stairRect)
        stairThree.fillColor = colors.randomElement()!
        stairThree.position = CGPoint(x: stairTwo.position.x + stairSize.width, y: stairTwo.position.y - stairSize.height)
        self.addChild(stairThree)
        
        stairFour = SKShapeNode(rect: stairRect)
        stairFour.fillColor = colors.randomElement()!
        stairFour.position = CGPoint(x: stairThree.position.x + stairSize.width, y: stairThree.position.y - stairSize.height)
        self.addChild(stairFour)
        
        stairFive = SKShapeNode(rect: stairRect)
        stairFive.fillColor = colors.randomElement()!
        stairFive.position = CGPoint(x: stairFour.position.x + stairSize.width, y: stairFour.position.y + stairSize.height)
        self.addChild(stairFive)
        
        stairSix = SKShapeNode(rect: stairRect)
        stairSix.fillColor = colors.randomElement()!
        stairSix.position = CGPoint(x: stairFive.position.x + stairSize.width, y: stairFive.position.y + stairSize.height)
        self.addChild(stairSix)
        
        stairSeven = SKShapeNode(rect: stairRect)
        stairSeven.fillColor = colors.randomElement()!
        stairSeven.position = CGPoint(x: stairSix.position.x + stairSize.width, y: stairSix.position.y + stairSize.height)
        self.addChild(stairSeven)
        
        
        self.run(moveSequence)

    }
    
    func createStairSections() {
//        stairOne = SKShapeNode(rect: stairRect)
//        stairOne.fillColor = colors.randomElement()!
//        stairOne.position = CGPoint(x: 0, y: 200)
//        self.addChild(stairOne)
        
        // First Section
        for i in 1...4 {
            let stair = SKShapeNode(rect: stairRect)
            stair.fillColor = colors.randomElement()!
            stair.strokeColor = stair.fillColor
            stair.position = CGPoint(x: 0 + (CGFloat(i) * stairSize.width), y: 200 - (CGFloat(i) * stairSize.height))
            stair.physicsBody = SKPhysicsBody(rectangleOf: stairSize, center: CGPoint(x: stairSize.width * 10 + 60, y: stairSize.height / 2))
            stair.physicsBody?.isDynamic = false
            self.addChild(stair)
        }
        
        for i in 1...3 {
            let stair = SKShapeNode(rect: stairRect)
            stair.fillColor = colors.randomElement()!
            stair.strokeColor = stair.fillColor
            stair.position = CGPoint(x: (stairRect.size.width * 4) + (CGFloat(i) * stairSize.width), y: (stairSize.height * 4) + (CGFloat(i) * stairSize.height))
            stair.physicsBody = SKPhysicsBody(rectangleOf: stairSize, center: CGPoint(x: stairSize.width * 10 + 60, y: stairSize.height / 2))
            stair.physicsBody?.isDynamic = false
            self.addChild(stair)
        }
        
        // Second Section
        for i in 1...4 {
            let stair = SKShapeNode(rect: stairRect)
            stair.fillColor = colors.randomElement()!
            stair.strokeColor = stair.fillColor
            stair.position = CGPoint(x: (stairRect.size.width * 7) + (CGFloat(i) * stairSize.width), y: 200 - (CGFloat(i) * stairSize.height))
            stair.physicsBody = SKPhysicsBody(rectangleOf: stairSize, center: CGPoint(x: stairSize.width * 10 + 60, y: stairSize.height / 2))
            stair.physicsBody?.isDynamic = false
            self.addChild(stair)
        }
        
        for i in 1...3 {
            let stair = SKShapeNode(rect: stairRect)
            stair.fillColor = colors.randomElement()!
            stair.strokeColor = stair.fillColor
            stair.position = CGPoint(x: (stairRect.size.width * 11) + (CGFloat(i) * stairSize.width), y: (stairSize.height * 4) + (CGFloat(i) * stairSize.height))
            stair.physicsBody = SKPhysicsBody(rectangleOf: stairSize, center: CGPoint(x: stairSize.width * 10 + 60, y: stairSize.height / 2))
            stair.physicsBody?.isDynamic = false
            self.addChild(stair)
        }
        
        // Third Section
        for i in 1...4 {
            let stair = SKShapeNode(rect: stairRect)
            stair.fillColor = colors.randomElement()!
            stair.strokeColor = stair.fillColor
            stair.position = CGPoint(x: (stairRect.size.width * 14) + (CGFloat(i) * stairSize.width), y: 200 - (CGFloat(i) * stairSize.height))
            stair.physicsBody = SKPhysicsBody(rectangleOf: stairSize, center: CGPoint(x: stairSize.width * 10 + 60, y: stairSize.height / 2))
            stair.physicsBody?.isDynamic = false
            self.addChild(stair)
        }
        
      for i in 1...3 {
            let stair = SKShapeNode(rect: stairRect)
            stair.fillColor = colors.randomElement()!
            stair.strokeColor = stair.fillColor
            stair.position = CGPoint(x: (stairRect.size.width * 18) + (CGFloat(i) * stairSize.width), y: (stairSize.height * 4) + (CGFloat(i) * stairSize.height))
            stair.physicsBody = SKPhysicsBody(rectangleOf: stairSize, center: CGPoint(x: stairSize.width * 10 + 60, y: stairSize.height / 2))
            stair.physicsBody?.isDynamic = false
            self.addChild(stair)
      }
        
        self.run(moveSequence)
        
    }
}
