//
//  Ball.swift
//  Bouncy-Stairs
//
//  Created by Andrew Lundy on 5/4/20.
//  Copyright © 2020 Andrew Lundy. All rights reserved.
//

import Foundation
import SpriteKit

class Ball: SKSpriteNode {
    
    // MARK: - Properties
    var ballTextureNames: [String]!
    var currentTextureName: String!
    var ballTexture: SKTexture!
    
    
    // MARK: - Methods
    func changeBallTexture() {
        ballTextureNames = ["Ball_Blue", "Ball_Green", "Ball_Yellow", "Ball_Red"]
        currentTextureName = ballTextureNames.randomElement()
        ballTexture = SKTexture(imageNamed: "\(currentTextureName!)")
        
        self.run(SKAction.setTexture(ballTexture))
        
        switch currentTextureName {
        case "Ball_Blue":
            color = UIColor.blue
        case "Ball_Green":
            color = UIColor.green
        case "Ball_Yellow":
            color = UIColor.yellow
        case "Ball_Red":
            color = UIColor.red
        default:
            color = UIColor.red
        }
    }
    
    // MARK: - Init
    init() {
        ballTextureNames = ["Ball_Blue", "Ball_Green", "Ball_Yellow", "Ball_Red"]
        currentTextureName = ballTextureNames.randomElement()
        ballTexture = SKTexture(imageNamed: currentTextureName)
        let ballSize = CGSize(width: 115, height: 115)
        super.init(texture: ballTexture, color: UIColor.clear, size: ballSize)
        
        name = "ball"
        
        switch currentTextureName {
        case "Ball_Blue":
            color = UIColor.blue
        case "Ball_Green":
            color = UIColor.green
        case "Ball_Yellow":
            color = UIColor.yellow
        case "Ball_Red":
            color = UIColor.red
        default:
            color = UIColor.red
        }
        
        
        
//        physicsBody = SKPhysicsBody(texture: ballTexture, size: ballSize)
        physicsBody = SKPhysicsBody(circleOfRadius: ballSize.width * 0.40)
        physicsBody?.contactTestBitMask = CollisionTypes.stair.rawValue
        physicsBody?.collisionBitMask = CollisionTypes.stair.rawValue
        physicsBody?.categoryBitMask = CollisionTypes.ball.rawValue
        physicsBody?.restitution = 0.3
        physicsBody?.isDynamic = true
   
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
