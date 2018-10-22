//
//  TitleScene.swift
//  Puzzler
//
//  Created by Evan Arthur on 7/16/18.
//  Copyright © 2018 Evan Arthur. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class TitleScene: SKScene{
    
    var title: SKSpriteNode! = nil
    var titleFrames: [SKTexture] = []
    
    let playButtonTexture = SKTexture(imageNamed: "playButton")
    let playButtonPressedTexture = SKTexture(imageNamed: "playButtonPressed")
    
    let playRandomButtonTexture = SKTexture(imageNamed: "playRandom")
    let playRandomButtonPressedTexture = SKTexture(imageNamed: "playRandomPressed")
    
    let soundButtonTexture = SKTexture(imageNamed: "speaker_on")
    let soundButtonTextureOff = SKTexture(imageNamed: "speaker_off")
    let sleepingPandaTexture = SKTexture(imageNamed: "sleepingPanda0")
    
    var backgroundNode: SKSpriteNode! = nil
    var playButton: SKSpriteNode! = nil
    var playRandomButton: SKSpriteNode! = nil
    var soundButton: SKSpriteNode! = nil
    var sleepingPanda: SKSpriteNode! = nil
    
    
    var selectedButton: SKSpriteNode?
    
    var lastUpdateTime : TimeInterval = 0
    
    var currentStarSpawnTime: TimeInterval = 0
    var starSpawnRate: TimeInterval = 1
    var currentCloudSpawnTime: TimeInterval = 0
    var cloudSpawnRate: TimeInterval = 5
    
    var currentStars: [SKSpriteNode] = [SKSpriteNode]()
    var currentCloud: SKSpriteNode! = nil
    
    override func sceneDidLoad() {
        
        backgroundNode = SKSpriteNode(color: SKColor(red:0.00, green:0.20, blue:0.40, alpha:1.0), size: CGSize(width: 1242, height: 2208))
        backgroundNode.zPosition = 1
        addChild(backgroundNode)
        
        setUpTitle()
        runTitleAnimation()
        
        backgroundColor = SKColor(red:0.00, green:0.20, blue:0.40, alpha:1.0)
        playButton = SKSpriteNode(texture: playButtonTexture, size: CGSize(width: 75, height: 75))
        playButton.position = CGPoint(x: size.width/2 - 40, y: size.height/4)
        playButton.zPosition = 5
        addChild(playButton)
        
        playRandomButton = SKSpriteNode(texture: playRandomButtonTexture, size: CGSize(width: 75, height: 75))
        playRandomButton.position = CGPoint(x: size.width/2 + 40, y: size.height/4)
        playRandomButton.zPosition = 5
        addChild(playRandomButton)
        
        let edgeMargin: CGFloat = 25
        
        soundButton = SKSpriteNode(texture: SoundManager.sharedInstance.isMuted ? soundButtonTextureOff: soundButtonTexture)
        soundButton.position = CGPoint(x: size.width - soundButton.size.width/2 - edgeMargin, y: soundButton.size.height/2 + edgeMargin)
        soundButton.zPosition = 5
        addChild(soundButton)
        
        sleepingPanda = SKSpriteNode(texture: sleepingPandaTexture)
        sleepingPanda.position = CGPoint(x: size.width/2, y: size.height/2)
        sleepingPanda.zPosition = 4
        addChild(sleepingPanda)
        var pandaTextures = [SKTexture]()
        for i in 0...3 {
            pandaTextures.append(SKTexture(imageNamed: "sleepingPanda\(i)"))
        }
        sleepingPanda.run(SKAction.repeatForever(SKAction.animate(with: pandaTextures, timePerFrame: 0.5, resize: false, restore: false)))
        
        spawnCloud()
    }
    
    func setUpTitle(){
        let titleAtlas = SKTextureAtlas(named: "Title")
        var frames: [SKTexture] = []
        
        let numImages = titleAtlas.textureNames.count
        for i in 0...(numImages - 1) {
            var textureName = ""
            if i < 10 {
                textureName = "Title_0000\(i)"
            } else {
                textureName = "Title_000\(i)"
            }
            frames.append(titleAtlas.textureNamed(textureName))
        }
        titleFrames = frames
        
        let firstFrameTexture = titleFrames[0]
//        let titleTexture = SKTexture(imageNamed: "title")
        title = SKSpriteNode(texture: firstFrameTexture, size: CGSize(width: 500, height: 250))
        title.position = CGPoint(x: size.width/2, y: size.height - title.size.height/3)
        title.zPosition = 10
        addChild(title)
    }
    
    func runTitleAnimation(){
        title.run(SKAction.animate(with: titleFrames, timePerFrame: 0.02), completion: {
                                    self.title.texture = self.titleFrames.last
                                    })
        
//        title.alpha = 0.0
//        title.run(SKAction.fadeIn(withDuration: 2))
    }
    
    func spawnStar(){
        let starTexture = SKTexture(imageNamed: "star")
        let star = SKSpriteNode(texture: starTexture, size: CGSize(width: 20, height: 40))
        let xPos = Int(size.width + star.size.width)
        let yPos = GKRandomSource.sharedRandom().nextInt(upperBound: Int(size.height - (2 * star.size.height))) + Int(star.size.height)
        star.position = CGPoint(x: xPos, y: yPos)
        star.zPosition = 2
        addChild(star)
        currentStars.append(star)
        let moveAction = SKAction.move(to: CGPoint(x: Int(-star.size.width), y: Int(star.position.y)), duration: 15)
        star.run(moveAction, completion: {
            let index = self.currentStars.index(of: star)
            self.currentStars.remove(at: index!)
            star.removeAllActions()
            star.removeFromParent()
        })
    }
    
    func spawnCloud(){
        let cloudTexture = SKTexture(imageNamed: "cloud")
        let cloud = SKSpriteNode(texture: cloudTexture, size: CGSize(width: 100, height: 50))
        cloud.zPosition = 6
        cloud.alpha = 0.9
        addChild(cloud)
        self.currentCloud = cloud
        
        let xPos = Int(size.width + cloud.size.width)
        let yPos = GKRandomSource.sharedRandom().nextInt(upperBound: Int(size.height - (2 * cloud.size.height))) + Int(cloud.size.height)
        let startingPoint = CGPoint(x: xPos, y: yPos)
        cloud.position = startingPoint
        
        let moveAction = SKAction.move(to: CGPoint(x: Int(-cloud.size.width), y: Int(cloud.position.y)), duration: 10)
        let waitTime = SKAction.wait(forDuration: 2)
        let sequence = SKAction.sequence([waitTime,moveAction])
        
        cloud.run(sequence, completion: {
            cloud.removeAllActions()
            cloud.removeFromParent()
            self.spawnCloud()
        })
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update the Spawn Timer
        currentStarSpawnTime += dt
        
        if currentStarSpawnTime > starSpawnRate {
            currentStarSpawnTime = 0
            spawnStar()
        }
        
        self.lastUpdateTime = currentTime
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            if title.contains(touch.location(in: self)){
                runTitleAnimation()
            }
            
            if selectedButton != nil {
                handleStartButtonHover(isHovering: false)
                handleSoundButtonHover(isHovering: false)
                handleStartRandomButtonHover(isHovering: false)
            }
            
            if playButton.contains(touch.location(in: self)){
                selectedButton = playButton
                handleStartButtonHover(isHovering: true)
            } else if soundButton.contains(touch.location(in: self)){
                selectedButton = soundButton
                handleSoundButtonHover(isHovering: true)
            } else if playRandomButton.contains(touch.location(in: self)){
                selectedButton = playRandomButton
                handleStartRandomButtonHover(isHovering: true)
            }
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            if selectedButton == playButton{
                handleStartButtonHover(isHovering: playButton.contains(touch.location(in: self)))
            } else if selectedButton == soundButton {
                handleSoundButtonHover(isHovering: soundButton.contains(touch.location(in: self)))
            } else if selectedButton == playRandomButton {
                handleStartRandomButtonHover(isHovering: playRandomButton.contains(touch.location(in: self)))
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            if selectedButton == playButton{
                handleStartButtonHover(isHovering: false)
                if playButton.contains(touch.location(in: self)){
                    Data.sharedInstance.randomLevels = false
                    handleStartButtonClick()
                }
            } else if selectedButton == soundButton{
                handleSoundButtonHover(isHovering: false)
                if soundButton.contains(touch.location(in: self)){
                    handleSoundButtonClick()
                }
            } else if selectedButton == playRandomButton{
                handleStartRandomButtonHover(isHovering: false)
                if playRandomButton.contains(touch.location(in: self)){
                    Data.sharedInstance.randomLevels = true
                    handleStartButtonClick()
                }
            }
        }
        selectedButton = nil
    }
    

    func handleStartButtonHover(isHovering: Bool){
        if isHovering{
            playButton.texture = playButtonPressedTexture
            let scaleAction = SKAction.scale(to: 0.9, duration: 0.1)
            playButton.run(scaleAction)
        } else {
            playButton.texture = playButtonTexture
            let scaleAction = SKAction.scale(to: 1, duration: 0.1)
            playButton.run(scaleAction)
        }
    }
    
    func handleStartRandomButtonHover(isHovering: Bool){
        if isHovering{
            playRandomButton.texture = playRandomButtonPressedTexture
            let scaleAction = SKAction.scale(to: 0.9, duration: 0.1)
            playRandomButton.run(scaleAction)
        } else {
            playRandomButton.texture = playRandomButtonTexture
            let scaleAction = SKAction.scale(to: 1, duration: 0.1)
            playRandomButton.run(scaleAction)
        }
    }
    
    func handleSoundButtonHover(isHovering: Bool){
        if isHovering{
            soundButton.alpha = 0.5
        } else {
            soundButton.alpha = 1.0
        }
    }
    
    func handleStartButtonClick(){
        clearScreen()
        let colorChange = SKAction.colorize(with: UIColor(red:0.46, green:0.77, blue:0.68, alpha:1.0), colorBlendFactor: 1, duration: 0.75)
        backgroundNode.run(colorChange, completion: {
            self.handleTransition()
        })
    }
    
    func clearScreen(){
        let fade = SKAction.fadeOut(withDuration: 0.5)
        for star in currentStars {
            star.run(fade, completion: {
                star.removeAllActions()
                star.removeFromParent()
            })
        }
        currentCloud.run(fade, completion: {
            self.currentCloud.removeAllActions()
            self.currentCloud.removeFromParent()
        })
        playButton.run(fade)
        playRandomButton.run(fade)
        sleepingPanda.run(fade)
        soundButton.run(fade)
        title.run(fade)
    }
    
    func handleTransition(){
        let transition = SKTransition.reveal(with: .up, duration: 1)
        let gameScene = PuzzleScene(size: CGSize(width: 1242, height: 2208))
//        let gameScene = PuzzleScene(size: size)
        gameScene.scaleMode = .aspectFill
        view?.presentScene(gameScene, transition: transition)
    }

    func handleSoundButtonClick(){
        if SoundManager.sharedInstance.toggleMute() {
            soundButton.texture = soundButtonTextureOff
        } else {
            soundButton.texture = soundButtonTexture
        }
    }

}
