//
//  EndScene.swift
//  Puzzler
//
//  Created by Evan Arthur on 7/21/18.
//  Copyright © 2018 Evan Arthur. All rights reserved.
//

import Foundation
import SpriteKit

class EndScene: SKScene {
    
    //textures
    let playAgainButtonTexture = SKTexture(imageNamed: "playAgain")
    let playAgainButtonPressedTexture = SKTexture(imageNamed: "playAgainPressed")
    let backgroundTexture = SKTexture(imageNamed: "pandaHammock")
    
    //nodes
    var gameOverLabel: SKLabelNode! = nil
    var playAgainButton: SKSpriteNode! = nil
    var backgroundSprite: SKSpriteNode! = nil
    var timeLabelNode: SKLabelNode! = nil
    
    var selectedButton: SKSpriteNode?
    
    override func sceneDidLoad() {
        
        let timeFormatted = String(format: "%.2f", (Data.sharedInstance.elapsedTime/1000000000)/60)
        print("total Time: \(timeFormatted) seconds");
        Data.sharedInstance.reset()
        
//        gameOverLabel = SKLabelNode(fontNamed: "Herculanum")
//        gameOverLabel.text = "Congratulations!!"
//        gameOverLabel.fontSize = 60
//        gameOverLabel.position = CGPoint(x: size.width/2, y: size.height/3 * 2)
//        addChild(gameOverLabel)
        
        backgroundSprite = SKSpriteNode(texture: backgroundTexture, size: size)
        backgroundSprite.position = CGPoint(x: size.width/2, y: size.height/2)
        backgroundSprite.zPosition = 2
        addChild(backgroundSprite)
        
        playAgainButton = SKSpriteNode(texture: playAgainButtonTexture, size: CGSize(width: 200, height: 200))
        playAgainButton.position = CGPoint(x: size.width - playAgainButton.size.width/2 - 25, y: playAgainButton.size.height/2 + 25)
        playAgainButton.zPosition = 3
        addChild(playAgainButton)
        
        timeLabelNode = SKLabelNode(text: "Total Time: \(timeFormatted) minutes")
        timeLabelNode.position = CGPoint(x: size.width/2, y: size.height/2)
        timeLabelNode.zPosition = 3
        timeLabelNode.fontSize = 100
        timeLabelNode.fontColor = UIColor.white
        addChild(timeLabelNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            if selectedButton != nil {
                handlePlayAgainButtonHover(isHovering: false)
            }
            if playAgainButton.contains(touch.location(in: self)){
                selectedButton = playAgainButton
                handlePlayAgainButtonHover(isHovering: true)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            if selectedButton == playAgainButton{
                handlePlayAgainButtonHover(isHovering: playAgainButton.contains(touch.location(in: self)))
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            if selectedButton == playAgainButton{
                handlePlayAgainButtonHover(isHovering: false)
                if playAgainButton.contains(touch.location(in: self)){
                    handlePlayAgainButtonClick()
                }
        }
        selectedButton = nil
        }
    }
    
    func handlePlayAgainButtonHover(isHovering: Bool){
        if isHovering{
            playAgainButton.texture = playAgainButtonPressedTexture
            let scaleAction = SKAction.scale(to: 0.9, duration: 0.1)
            playAgainButton.run(scaleAction)
        } else {
            playAgainButton.texture = playAgainButtonTexture
            let scaleAction = SKAction.scale(to: 1, duration: 0.1)
            playAgainButton.run(scaleAction)
        }
    }
    
    func handlePlayAgainButtonClick(){
        let transition = SKTransition.reveal(with: .left, duration: 1.5)
        let gameScene = TitleScene(size: view!.frame.size)
        gameScene.scaleMode = .aspectFill
        view?.presentScene(gameScene, transition: transition)
    }
    
    
}
