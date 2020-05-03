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
    
    var xPosition: CGFloat!
    var endPosition: CGFloat!
    
    var moveStairs: SKAction!
    var moveSequence: SKAction!
    
    init(frame: CGRect) {
        super.init()
        xPosition = frame.maxX + 150
        endPosition = frame.minX - 2500
        stairRect = CGRect(x: xPosition, y: frame.minY, width: stairSize.width, height: stairSize.height)
        moveStairs = SKAction.move(to: CGPoint(x: endPosition, y: self.position.y), duration: 4)
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
        
        

        
        
        // Section Two
//        stairEight = SKShapeNode(rect: stairRect)
//        stairEight.fillColor = colors.randomElement()!
//        stairEight.position = CGPoint(x: 0, y: 200)
//        self.addChild(stairEight)
//
//        stairNine = SKShapeNode(rect: stairRect)
//        stairNine.fillColor = colors.randomElement()!
//        stairNine.position = CGPoint(x: stairEight.position.x + stairSize.width, y: stairEight.position.y - stairSize.height)
//        self.addChild(stairNine)
//
//        stairTen = SKShapeNode(rect: stairRect)
//        stairTen.fillColor = colors.randomElement()!
//        stairTen.position = CGPoint(x: stairNine.position.x + stairSize.width, y: stairNine.position.y - stairSize.height)
//        self.addChild(stairTen)
        self.run(moveSequence)
//        createStairs()
        
        for i in 0...7 {
            
        }
        
    }
    
    func createStairSections() {
        stairOne = SKShapeNode(rect: stairRect)
        stairOne.fillColor = colors.randomElement()!
        stairOne.position = CGPoint(x: 0, y: 200)
        self.addChild(stairOne)
        
        for i in 1...3 {
            let stair = SKShapeNode(rect: stairRect)
            stair.fillColor = colors.randomElement()!
            stair.position = CGPoint(x: 0 + (CGFloat(i) * stairSize.width), y: 200 - (CGFloat(i) * stairSize.height))
            self.addChild(stair)
        }
        
        for i in 1...3 {
            let stair = SKShapeNode(rect: stairRect)
            stair.fillColor = colors.randomElement()!
            stair.position = CGPoint(x: (stairRect.size.width * 3) + (CGFloat(i) * stairSize.width), y: 125 + (CGFloat(i) * stairSize.height))
            self.addChild(stair)
        }
        
        self.run(moveSequence)
        
        
    }

    
    
}
