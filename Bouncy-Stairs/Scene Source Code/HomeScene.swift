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
        gameTitle.position = CGPoint(x: frame.midX, y: frame.maxY - 175)
        gameTitle.text = "Bouncy Stairs"
        gameTitle.fontSize = 40
        addChild(gameTitle)
        
        highScoreLabel = SKLabelNode(fontNamed: GlobalVariables.shared.mainFont)
        highScoreLabel.fontSize = 19
        highScoreLabel.text = "Score to Beat: 1"
        highScoreLabel.horizontalAlignmentMode = .center
        highScoreLabel.position = CGPoint(x: gameTitle.position.x, y: gameTitle.position.y - 80)
        addChild(highScoreLabel)
        
        playButton = SKSpriteNode(imageNamed: "Main_Menu_Play")
        playButton.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
        playButton.size = CGSize(width: playButton.size.width / 3, height: playButton.size.height / 3)
        playButton.name = "playButton"
        GlobalVariables.shared.bounce(node: playButton)
        addChild(playButton)
        
        
        optionsButton = SKSpriteNode(imageNamed: "Options_Button")
        optionsButton.position = CGPoint(x: playButton.position.x, y: playButton.position.y - 150)
        optionsButton.size = CGSize(width: optionsButton.size.width / 4, height: optionsButton.size.height / 4)
        optionsButton.name = "optionsButton"
        addChild(optionsButton)
        
    }
}


