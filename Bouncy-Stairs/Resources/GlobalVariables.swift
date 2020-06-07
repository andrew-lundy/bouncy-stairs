//
//  GlobalVariables.swift
//  Bouncy-Stairs
//
//  Created by Andrew Lundy on 4/28/20.
//  Copyright © 2020 Andrew Lundy. All rights reserved.
//

import Foundation
import SpriteKit

enum GameState {
    case playing
    case mainMenu
    case gameOver
    case paused
    case antiGravity
}

enum CollisionTypes: UInt32 {
    case ball = 1
    case stair = 2
    case ground = 4
    case scoreDetect = 8
}


struct GlobalVariables {
    static var shared = GlobalVariables()
    
    var highScore: Int?
    var gameState: GameState?
    var ballTexture = SKTexture(imageNamed: "Ball_Blue")
    var mainFont = "PressStart2P"
    var firstStaircaseCreated = false
    
    func bounce(node: SKSpriteNode) {
        let moveUp = SKAction.moveBy(x: 0, y: 10, duration: 0.3)
        let moveDown = SKAction.moveBy(x: 0, y: -10, duration: 0.3)
        let scaleActionSequence = SKAction.sequence([moveUp, moveDown])
        let repeatAction = SKAction.repeatForever(scaleActionSequence)
        node.run(repeatAction)
    }

    
    
    
}
