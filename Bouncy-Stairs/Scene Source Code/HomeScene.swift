//
//  HomeScene.swift
//  Bouncy-Stairs
//
//  Created by Andrew Lundy on 4/28/20.
//  Copyright © 2020 Andrew Lundy. All rights reserved.
//

import Foundation
import SpriteKit

class HomeScene: SKScene {
    var playButton: SKSpriteNode!
    var optionsButton: SKSpriteNode!
    var gameTitle: SKLabelNode!
    var highScoreLabel: SKLabelNode!
    var bounce: SKAction!
    
    
    
    override func didMove(to view: SKView) {
        print("HomeScene")
        createMainMenu()
    }
}




extension HomeScene {
    func createMainMenu() {
        gameTitle = SKLabelNode(fontNamed: GlobalVariables.shared.mainFont)
        gameTitle.position = CGPoint(x: frame.midX, y: frame.maxY - 150)
        gameTitle.text = "Bouncy Stairs"
        gameTitle.fontSize = 40
        addChild(gameTitle)
        
        
        playButton = SKSpriteNode(imageNamed: "Main_Menu_Play")
        
        
        
        
        
    }
}


