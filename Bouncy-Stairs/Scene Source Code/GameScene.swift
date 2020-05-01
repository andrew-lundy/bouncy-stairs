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
        
    var stairCase: Staircase!
    
    
    func createStaircase() {
        stairCase = Staircase(frame: frame)
        stairCase.createStairs()
        addChild(stairCase)
    }
    
    func startStairs() {
        let create = SKAction.run {
            self.createStaircase()
        }
        
        let wait = SKAction.wait(forDuration: 1)
        let stairGenerationSequence = SKAction.sequence([wait, create, wait])
        let repeatForever = SKAction.repeatForever(stairGenerationSequence)
        run(repeatForever)
    }
    
        
    
    override func didMove(to view: SKView) {
        
        startStairs()
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            
    }
        
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
   
    }
}


