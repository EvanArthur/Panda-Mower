//
//  PuzzleScene.swift
//  Puzzler
//
//  Created by Evan Arthur on 7/20/18.
//  Copyright © 2018 Evan Arthur. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AudioToolbox

class PuzzleScene: SKScene {
        
    //MARK: Fields

    //the TileMaps
    var unmowedGrassBackground: SKTileMapNode!
    var mowedGrassBackground: SKTileMapNode!
    var pandaBackground: SKTileMapNode!

    //the TileGroups that we need
    var unmowedTileGroup: SKTileGroup!
    var mowedTileGroup: SKTileGroup!
    var pandaTileGroup: SKTileGroup!


    //the destination of the touch response
    var destination: CGPoint = .zero

    //the starting point of the puzzle
    let startingPoint: [Int] = [1,1]

    //an array of [Int] that store the coordinates of the past moves
    var history: [[Int]] = [[Int]]()

    //a count of the total number of non-nil squares in the unmowedGrassBackground
    var numSquares: Int = 0

    var generator = UIImpactFeedbackGenerator(style: .light)

    var cloud: SKSpriteNode!
    
    let backButtonTexture = SKTexture(imageNamed: "backButton")
    let backButtonPressedTexture = SKTexture(imageNamed: "backButtonPressed")
    var backButton: SKSpriteNode! = nil
    let swipeDownGesture = UISwipeGestureRecognizer()
    
    
    var selectedButton: SKSpriteNode?
    
    var data: Data = Data.sharedInstance
    
    var startTime: Double! = nil
    var endTime: Double! = nil

    //MARK: METHODS

    override func didMove(to view: SKView) {
        //calls loadBackgrounds
        loadBackgrounds()
    }
        
    override func sceneDidLoad() {
        if Data.sharedInstance.randomLevels {
            Data.sharedInstance.prepareNextRandomLevel(numSquares: GKRandomSource.sharedRandom().nextInt(upperBound: 20) + 10)
        }
    }

    func loadBackgrounds(){
        
        backgroundColor = UIColor(red:0.46, green:0.77, blue:0.68, alpha:1.0)
        
        //finds tileSet to find the array of tileGroups to find the mowedGrass and panda tile groups
        guard let unmowedTileSet = SKTileSet(named: "UnmowedGrass") else{
            fatalError("unmowed grass tile set not found")
        }
        guard let mowedTileSet = SKTileSet(named: "MowedGrass") else {
            fatalError("mowed grass tile set not found")
        }
        guard let pandaTileSet = SKTileSet(named: "Panda") else {
            fatalError("panda tile set not found")
        }
        let mowedTileGroups = mowedTileSet.tileGroups
        let pandaTileGroups = pandaTileSet.tileGroups
        self.mowedTileGroup = mowedTileGroups.first(where: {$0.name == "MowedGrass"})
        self.pandaTileGroup = pandaTileGroups.first(where: {$0.name == "Panda"})
        
        //*****finds the unmowed, mowed, and panda backgrounds******
        unmowedGrassBackground = SKTileMapNode(tileSet: unmowedTileSet, columns: 5, rows: 7, tileSize: CGSize(width: 200, height: 200))
        unmowedGrassBackground.zPosition = 1
        unmowedGrassBackground.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(unmowedGrassBackground)
        
        mowedGrassBackground = SKTileMapNode(tileSet: mowedTileSet, columns: 5, rows: 7, tileSize: CGSize(width: 200, height: 200))
        mowedGrassBackground.zPosition = 2
        mowedGrassBackground.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(mowedGrassBackground)
        
        pandaBackground = SKTileMapNode(tileSet: pandaTileSet, columns: 5, rows: 7, tileSize: CGSize(width: 200, height: 200))
        pandaBackground.zPosition = 3
        pandaBackground.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(pandaBackground)
        
        let safeAreaInsets = (view?.safeAreaInsets)!
        backButton = SKSpriteNode(texture: backButtonTexture, size: CGSize(width: 120, height: 100))
        backButton.zPosition = 4
        if UIScreen.main.nativeBounds.height == 2436 {
            backButton.position = CGPoint(x: safeAreaInsets.left + backButton.size.width + 60, y: size.height - safeAreaInsets.top -  backButton.size.height)
        } else {
            backButton.position = CGPoint(x: safeAreaInsets.left + backButton.size.width, y: size.height - safeAreaInsets.top -  backButton.size.height)
        }
        addChild(backButton)
        
        createBackground()
        
        self.numSquares = getTotalSquares()
        print(numSquares)
        
        addCloud()
        
        startTime = Double(DispatchTime.now().uptimeNanoseconds)
    }
    

    func getNeighbors(col: Int, row: Int) -> [[Int?]]{
        //finds the neighbors and returns them in a 2d array
        //goes right,top,bottom,left
        var neighbors: [[Int?]] = [[Int?]]()
        let numCols: Int = (unmowedGrassBackground?.numberOfColumns)!
        let numRows: Int = (unmowedGrassBackground?.numberOfRows)!
        //right neighbor
        if col < (numCols - 1) {
            neighbors.append([col+1,row])
        } else {
            neighbors.append([-1,-1])
        }
        //top neighbor
        if row < (numRows - 1){
            neighbors.append([col, row + 1])
        } else {
            neighbors.append([-1,-1])
        }
        //bottom neighbor
        if row > 0 {
            neighbors.append([col, row - 1])
        } else {
            neighbors.append([-1,-1])
        }
        //left neighbor
        if col > 0 {
            neighbors.append([col - 1, row])
        } else {
            neighbors.append([-1,-1])
        }
        return neighbors
    }

    func getTotalSquares() -> Int {
        let numCol = unmowedGrassBackground.numberOfColumns
        print("numCol: \(numCol)")
        let numRow = unmowedGrassBackground.numberOfRows
        print("numRow: \(numRow)")
        var count: Int = 0
        for col in 0...(numCol - 1) {
            for row in 0...(numRow - 1){
                guard unmowedGrassBackground.tileDefinition(atColumn: col, row: row) != nil else {continue}
                count += 1
            }
        }
        return count
    }
    
    func createBackground(){
        //Check to see if we're doing random or non-random levels
        var level = [[Int]]()
        
        if Data.sharedInstance.randomLevels {
            
            if Data.sharedInstance.nextRandomLevel != nil {
                level = Data.sharedInstance.nextRandomLevel!
                level = level.reversed()
            } else {
                level = Data.sharedInstance.randomLevel(numSquares: GKRandomSource.sharedRandom().nextInt(upperBound: 20) + 10)
                level = level.reversed()
            }
            
        } else {
            
            level = data.levels[data.currentLevel-1]
            
            let levelIndicator = SKLabelNode(text: String(data.currentLevel))
            levelIndicator.fontColor = UIColor.black
            levelIndicator.fontSize = 150
            levelIndicator.position = CGPoint(x: size.width/2, y: levelIndicator.fontSize/2 + 25)
            levelIndicator.zPosition = 4
            addChild(levelIndicator)
        }
        
        for row in 0...(data.unmowedTiles.count - 1){
            for column in 0...(data.unmowedTiles[0].count - 1){
                if level[row][column] == 0 {
                    unmowedGrassBackground.setTileGroup(nil, forColumn: column, row: row)
                    mowedGrassBackground.setTileGroup(nil, forColumn: column, row: row)
                    pandaBackground.setTileGroup(nil, forColumn: column, row: row)
                } else if level[row][column] == 1 {
                    unmowedGrassBackground.setTileGroup(data.unmowedTiles[row][column], forColumn: column, row: row)
                    pandaBackground.setTileGroup(nil, forColumn: column, row: row)
                    mowedGrassBackground.setTileGroup(nil, forColumn: column, row: row)
                } else if level[row][column] == 2{
                    pandaBackground.setTileGroup(pandaTileGroup, forColumn: column, row: row)
                    mowedGrassBackground.setTileGroup(mowedTileGroup, forColumn: column, row: row)
                    unmowedGrassBackground.setTileGroup(data.unmowedTiles[row][column], forColumn: column, row: row)
                    history.append([column,row])
                }
            }
        }
    }

    func isComplete() -> Bool {
        return history.count == numSquares
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        destination = touch.location(in: unmowedGrassBackground)
        if selectedButton != nil {
            handleBackButtonHover(isHovering: false)
        }
        if backButton.contains(touch.location(in: self)){
            selectedButton = backButton
            handleBackButtonHover(isHovering: true)
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        destination = touch.location(in: unmowedGrassBackground)
        if selectedButton == backButton{
            handleBackButtonHover(isHovering: backButton.contains(touch.location(in: self)))
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            if selectedButton == backButton{
                handleBackButtonHover(isHovering: false)
                if backButton.contains(touch.location(in: self)){
                    handleBackButtonClick()
                }
            }
            selectedButton = nil
        }
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        updateTiles()
    
        //checks if the puzzle has been solved
        if isComplete(){
            
            let tryAgain = SystemSoundID(1102)
            AudioServicesPlaySystemSound(tryAgain)
            
            if !Data.sharedInstance.randomLevels{
                endTime = Double(DispatchTime.now().uptimeNanoseconds)
                let elapsedTime = endTime - startTime
                Data.sharedInstance.updateTime(elapsedTime: elapsedTime)
                
                guard data.currentLevel < data.levels.count else {
                    let endScene = EndScene(size: size)
                    let transition = SKTransition.moveIn(with: .up, duration: 1)
                    endScene.scaleMode = .aspectFill
                    view?.presentScene(endScene, transition: transition)
                    return
                }
            }
            
            data.newLevel()
            let transition = SKTransition.reveal(with: .left, duration: 1.5)
            let gameScene = PuzzleScene(size: size)
            gameScene.scaleMode = .aspectFill
            view?.presentScene(gameScene, transition: transition)
            print("finished")
        }
        
    }

    func addCloud(){
        let cloudTexture = SKTexture(imageNamed: "cloud")
        let cloud = SKSpriteNode(texture: cloudTexture, size: CGSize(width: 300, height: 150))
        self.cloud = cloud
        cloud.zPosition = 5
        cloud.alpha = 0.9
        addChild(cloud)
        let xPos = Int(-(cloud.size.width))
        let yPos = GKRandomSource.sharedRandom().nextInt(upperBound: Int(size.height - (2 * cloud.size.height))) + Int(cloud.size.height)
        let startingPoint = CGPoint(x: xPos, y: yPos)
        cloud.position = startingPoint
        let moveAction = SKAction.move(to: CGPoint(x: Int(size.width + cloud.size.width), y: Int(cloud.position.y)), duration: 10)
        cloud.run(moveAction, completion: {
            self.addCloud()
        })
    }

    func updateTiles(){
        //finds column and row of the touch location
        let column = unmowedGrassBackground.tileColumnIndex(fromPosition: destination)
        let row = unmowedGrassBackground.tileRowIndex(fromPosition: destination)
        //        print("[\(column), \(row)]")
        
        //finds neighbors of touch location
        let neighbors = getNeighbors(col: column, row: row)
        guard neighbors.contains(history.first!) else {
            //            print("not a neighbor of most recent tile")
            return
        }
        
        //checks to make sure the touch location is not nil
        guard unmowedGrassBackground.tileDefinition(atColumn: column, row: row) != nil else {
            return
        }
        
        //If the touch location is unmowed, then switch to mowed and add to history array
        if mowedGrassBackground.tileDefinition(atColumn: column, row: row) == nil{
            mowedGrassBackground.setTileGroup(mowedTileGroup, forColumn: column, row: row)
            pandaBackground.setTileGroup(nil, forColumn: history.first![0], row: history.first![1])
            generator.impactOccurred()
            pandaBackground.setTileGroup(pandaTileGroup, forColumn: column, row: row)
            
            
            //determines the orientation of the panda based on where it's coming from
            switch history.first!{
            case neighbors[0]:
                pandaBackground.tileDefinition(atColumn: column, row: row)?.flipHorizontally = true
            case neighbors[3]:
                pandaBackground.tileDefinition(atColumn: column, row: row)?.flipHorizontally = false
            default:
                pandaBackground.tileDefinition(atColumn: column, row: row)?.flipHorizontally = false
            }
            
            history.insert([column,row], at: 0)
        }
            //This is if the panda goes over a square he has already mowed, making the game go back to that tile
            //makes sure that there is at least one tile still mowed
        else if history.count > 1 {
            //goes back in history until the target location is the most recent tile
            pandaBackground.setTileGroup(nil, forColumn: history.first![0], row: history.first![1])
            var temp = [[Int]]()
            while history.first! != [column,row]{
                mowedGrassBackground.setTileGroup(nil, forColumn: history.first![0], row: history.first![1])
                temp.append(history.first!)
                history.remove(at: 0)
            }
            
            pandaBackground.setTileGroup(pandaTileGroup, forColumn: history.first![0], row: history.first![1])
            generator.impactOccurred()
            
            switch temp.first!{
            case neighbors[0]:
                pandaBackground.tileDefinition(atColumn: column, row: row)?.flipHorizontally = true
            case neighbors[3]:
                pandaBackground.tileDefinition(atColumn: column, row: row)?.flipHorizontally = false
            default:
                return
            }
        }
    }
    
    func handleBackButtonHover(isHovering: Bool){
        if isHovering{
            backButton.alpha = 0.5
        } else {
            backButton.alpha = 1.0
        }
    }
    
    func handleBackButtonClick(){
        let transition = SKTransition.moveIn(with: .up, duration: 1)
        let gameScene = TitleScene(size: view!.frame.size)
        gameScene.scaleMode = .aspectFill
        view?.presentScene(gameScene, transition: transition)
    }

}
