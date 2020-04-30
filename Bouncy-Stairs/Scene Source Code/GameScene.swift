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


class GameScene: SKScene {
        
        
    
    override func didMove(to view: SKView) {

    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            
    }
        
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        createStairs()
    }
}



extension GameScene {
    
    func createStairs() {
        colors.shuffle()
        
        
        
        let stairOne = SKShapeNode(rect: stairRect)
        stairOne.fillColor = colors.randomElement()!
        stairOne.position = CGPoint(x: 0, y: 200)
        stairCase.addChild(stairOne)
        
        let stairTwo = SKShapeNode(rect: stairRect)
        stairTwo.fillColor = colors.randomElement()!
        stairTwo.position = CGPoint(x: stairOne.position.x + stairSize.width, y: stairOne.position.y - stairSize.height)
        stairCase.addChild(stairTwo)
    
        let stairThree = SKShapeNode(rect: stairRect)
        stairThree.fillColor = colors.randomElement()!
        stairThree.position = CGPoint(x: stairTwo.position.x + stairSize.width, y: stairTwo.position.y - stairSize.height)
        stairCase.addChild(stairThree)
        
        let stairFour = SKShapeNode(rect: stairRect)
        stairFour.fillColor = colors.randomElement()!
        stairFour.position = CGPoint(x: stairThree.position.x + stairSize.width, y: stairThree.position.y - stairSize.height)
        stairCase.addChild(stairFour)
        
        let stairFive = SKShapeNode(rect: stairRect)
        stairFive.fillColor = colors.randomElement()!
        stairFive.position = CGPoint(x: stairFour.position.x + stairSize.width, y: stairFour.position.y + stairSize.height)
        stairCase.addChild(stairFive)
        
        let stairSix = SKShapeNode(rect: stairRect)
        stairSix.fillColor = colors.randomElement()!
        stairSix.position = CGPoint(x: stairFive.position.x + stairSize.width, y: stairFive.position.y + stairSize.height)
        stairCase.addChild(stairSix)
        
        let stairSeven = SKShapeNode(rect: stairRect)
        stairSeven.fillColor = colors.randomElement()!
        stairSeven.position = CGPoint(x: stairSix.position.x + stairSize.width, y: stairSix.position.y + stairSize.height)
        stairCase.addChild(stairSeven)
        
        addChild(stairCase)
        stairSections.append(stairCase)
        
        let moveStairs = SKAction.move(to: CGPoint(x: frame.minX - 1500, y: self.position.y), duration: 4)
        stairCase.run(moveStairs)
        
    }
}
