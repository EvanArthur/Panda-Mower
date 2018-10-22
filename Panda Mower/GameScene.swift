//
//  GameScene.swift
//  Puzzler
//
//  Created by Evan Arthur on 7/8/18.
//  Copyright © 2018 Evan Arthur. All rights reserved.
//

import SpriteKit
import GameplayKit
import AudioToolbox

class GameScene: SKScene {
    
    //MARK: Fields
    
    //the TileMaps
    var unmowedGrassBackground: SKTileMapNode!
    var mowedGrassBackground: SKTileMapNode!
    var pandaBackground: SKTileMapNode!
    
    //the TileGroups that we need
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
    
    var data: Data = Data()
    
    //MARK: METHODS
    
    override func didMove(to view: SKView) {
        print("here")
        //calls loadBackgrounds
        loadBackgrounds()
    }
    
    
    func loadBackgrounds(){
        
        backgroundColor = UIColor(red:0.46, green:0.77, blue:0.68, alpha:1.0)
        
        //finds tileSet to find the array of tileGroups to find the mowedGrass and panda tile groups
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
        
        guard let unmowedGrassBackground = childNode(withName: "UnmowedGrass") as? SKTileMapNode else {
            fatalError("ground not found")
        }
        self.unmowedGrassBackground = unmowedGrassBackground
        
        guard let mowedGrassBackground = childNode(withName: "MowedGrass") as? SKTileMapNode else {
            fatalError("ground not found")
        }
        self.mowedGrassBackground = mowedGrassBackground
        
        guard let pandaBackground = childNode(withName: "Panda") as? SKTileMapNode else {
            fatalError("ground not found")
        }
        self.pandaBackground = pandaBackground
        
        //******Loading Level Data to Make the TileMap******
        
        for row in 0...(data.unmowedTiles.count - 1){
            for column in 0...(data.unmowedTiles[0].count - 1){
                if data.levels[Data.currentLevel-1][row][column] == 0 {
                    unmowedGrassBackground.setTileGroup(nil, forColumn: column, row: row)
                    mowedGrassBackground.setTileGroup(nil, forColumn: column, row: row)
                    pandaBackground.setTileGroup(nil, forColumn: column, row: row)
                } else if data.levels[Data.currentLevel-1][row][column] == 1 {
                    unmowedGrassBackground.setTileGroup(data.unmowedTiles[row][column], forColumn: column, row: row)
                    pandaBackground.setTileGroup(nil, forColumn: column, row: row)
                    mowedGrassBackground.setTileGroup(nil, forColumn: column, row: row)
                } else {
                    pandaBackground.setTileGroup(pandaTileGroup, forColumn: column, row: row)
                    mowedGrassBackground.setTileGroup(mowedTileGroup, forColumn: column, row: row)
                    unmowedGrassBackground.setTileGroup(data.unmowedTiles[row][column], forColumn: column, row: row)
                    history.append([column,row])
                }
            }
        }
        
        //sets a panda as a starting point and then appends it to the history
//        pandaBackground.setTileGroup(pandaTileGroup, forColumn: startingPoint[0], row: startingPoint[1])
//        mowedGrassBackground.setTileGroup(mowedTileGroup, forColumn: startingPoint[0], row: startingPoint[1])
        
        self.numSquares = getTotalSquares()
        print(numSquares)
        
        addCloud()
        
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
    
    func isComplete() -> Bool {
        return history.count == numSquares
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        destination = touch.location(in: unmowedGrassBackground)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        destination = touch.location(in: unmowedGrassBackground)
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        updateTiles()
        checkCloud()
        
        if isComplete(){
            guard Data.currentLevel < data.levels.count else {
                return
            }
            let transition = SKTransition.reveal(with: .left, duration: 2)
            if let gameScene = SKScene(fileNamed: "GameScene") {
                gameScene.scaleMode = .aspectFill
                view?.presentScene(gameScene, transition: transition)
            }
            print("finished")
        }
        
    }
    
    func addCloud(){
        let cloudTexture = SKTexture(imageNamed: "cloud")
        let cloud = SKSpriteNode(texture: cloudTexture, size: CGSize(width: 300, height: 150))
        self.cloud = cloud
        cloud.alpha = 0.9
        addChild(cloud)
        let xPos = Int(-(size.width/2 + cloud.size.width))
        let yPos = GKRandomSource.sharedRandom().nextInt(upperBound: 2 * Int(size.height - 100)/2) - Int(size.height - 100)/2
        print(yPos)
        let startingPoint = CGPoint(x: xPos, y: yPos)
        cloud.position = startingPoint
        let moveAction = SKAction.move(to: CGPoint(x: Int(size.width/2 + cloud.size.width), y: Int(cloud.position.y)), duration: 10)
        cloud.run(moveAction)
    }
    
    func checkCloud(){
        if cloud.position.x >= (size.width/2 + cloud.size.width) {
            cloud.removeFromParent()
            addCloud()
        } else {
            return
        }
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
                pandaBackground.tileDefinition(atColumn: column, row: row)?.flipVertically = false
            case neighbors[1]:
                pandaBackground.tileDefinition(atColumn: column, row: row)?.flipVertically = false
            case neighbors[2]:
                pandaBackground.tileDefinition(atColumn: column, row: row)?.flipVertically = true
            case neighbors[3]:
                pandaBackground.tileDefinition(atColumn: column, row: row)?.flipHorizontally = false
                pandaBackground.tileDefinition(atColumn: column, row: row)?.flipVertically = false
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
            while history.first! != [column,row]{
                mowedGrassBackground.setTileGroup(nil, forColumn: history.first![0], row: history.first![1])
                history.remove(at: 0)
            }
            
            //this line is just for now
            //            mowedGrassBackground.setTileGroup(nil, forColumn: column, row: row)
            
            pandaBackground.setTileGroup(pandaTileGroup, forColumn: history.first![0], row: history.first![1])
            generator.impactOccurred()
        }
    }
    
}
