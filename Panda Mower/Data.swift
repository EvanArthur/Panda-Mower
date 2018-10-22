//
//  Constants.swift
//  Puzzler
//
//  Created by Evan Arthur on 7/16/18.
//  Copyright © 2018 Evan Arthur. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Data{
    
    static let sharedInstance = Data()
    
//    let level1 = [[2,1,1,1,1],
//                  [1,1,1,1,1],
//                  [1,1,1,1,1],
//                  [1,1,1,1,1],
//                  [1,1,1,1,1],
//                  [1,1,1,1,1],
//                  [1,1,1,1,1]]
    
    let level1 = [[0,0,0,0,0],
                  [0,0,0,0,0],
                  [0,0,0,0,0],
                  [2,1,1,1,1],
                  [0,0,0,0,0],
                  [0,0,0,0,0],
                  [0,0,0,0,0]]
    
    let level2 = [[0,0,0,0,0],
                  [2,1,1,1,1],
                  [0,0,0,0,1],
                  [0,0,0,0,1],
                  [0,0,0,0,1],
                  [0,0,0,0,0],
                  [0,0,0,0,0]]
    
    let level3 = [[0,0,0,0,0],
                  [0,0,0,0,0],
                  [0,2,1,1,0],
                  [0,1,1,1,0],
                  [0,1,1,1,0],
                  [0,0,0,0,0],
                  [0,0,0,0,0]]
    
    let level4 = [[0,0,0,0,0],
                  [2,1,0,0,0],
                  [0,1,1,0,0],
                  [0,0,1,1,0],
                  [0,0,0,1,1],
                  [0,0,0,0,1],
                  [0,0,0,0,0]]
    
    let level5 = [[0,0,0,0,0],
                  [0,1,1,1,0],
                  [1,1,1,1,0],
                  [1,1,2,0,0],
                  [0,0,0,0,0],
                  [0,0,0,0,0],
                  [0,0,0,0,0]]
    
    let level6 = [[0,0,0,0,0],
                  [1,1,1,1,1],
                  [1,0,2,1,1],
                  [1,0,0,0,1],
                  [1,1,1,1,1],
                  [0,0,1,1,0],
                  [0,0,0,0,0]]
    
    let level7 = [[0,0,0,0,0],
                  [1,1,1,1,1],
                  [1,0,1,1,1],
                  [2,0,0,0,1],
                  [0,0,1,1,1],
                  [0,1,1,0,0],
                  [0,0,0,0,0]]
    
    let level8 = [[0,0,0,0,0],
                  [0,0,1,1,1],
                  [1,1,1,0,1],
                  [1,0,1,1,1],
                  [1,2,1,1,1],
                  [0,0,0,0,0],
                  [0,0,0,0,0]]
    
    let level9 = [[0,0,0,0,0],
                  [1,1,2,0,0],
                  [1,1,0,1,1],
                  [0,1,1,1,1],
                  [1,1,0,0,1],
                  [1,1,1,1,1],
                  [0,0,0,0,0]]
    
    let level10 = [[0,0,0,0,0],
                   [1,1,1,1,1],
                   [1,0,1,1,1],
                   [1,1,2,1,1],
                   [0,1,1,1,1],
                   [0,0,0,0,0],
                   [0,0,0,0,0]]
    
    let level11 = [[0,0,0,0,0],
                   [1,1,0,0,0],
                   [2,1,0,1,1],
                   [0,1,1,1,1],
                   [1,1,1,0,1],
                   [0,0,1,1,1],
                   [0,0,0,0,0]]
    
    let level12 = [[0,0,0,0,0],
                   [1,1,1,1,0],
                   [1,1,0,1,1],
                   [0,1,1,0,2],
                   [0,1,1,1,1],
                   [0,1,1,1,1],
                   [0,0,0,0,0]]
    
    let level13 = [[0,0,0,0,0],
                   [1,1,1,1,2],
                   [1,1,1,1,1],
                   [1,0,1,1,1],
                   [1,1,1,1,1],
                   [0,1,0,1,1],
                   [0,0,0,0,0]]
    
    let level14 = [[0,0,0,0,0],
                   [0,1,1,0,0],
                   [0,2,1,1,1],
                   [0,0,1,1,1],
                   [0,1,1,1,1],
                   [0,0,0,0,0],
                   [0,0,0,0,0]]
    
    let level15 = [[0,0,0,0,0],
                   [1,1,1,1,1],
                   [1,1,0,2,1],
                   [1,1,0,1,1],
                   [1,1,0,1,1],
                   [0,1,1,1,1],
                   [0,0,0,0,0]]
    
    let level16 = [[0,0,0,0,0],
                   [2,1,0,1,1],
                   [0,1,1,1,1],
                   [1,0,1,1,1],
                   [1,1,1,1,0],
                   [0,1,1,1,0],
                   [0,0,0,0,0]]
    
    let level17 = [[0,0,0,0,0],
                   [0,1,1,1,1],
                   [1,1,2,0,1],
                   [0,1,1,1,1],
                   [1,1,0,1,1],
                   [1,1,1,1,1],
                   [0,0,0,0,0]]
    
    let level18 = [[0,0,0,0,0],
                   [1,1,1,1,1],
                   [1,0,0,2,1],
                   [1,1,1,1,1],
                   [0,0,1,1,1],
                   [0,0,0,0,0],
                   [0,0,0,0,0]]
    
    let level19 = [[0,0,0,0,0],
                   [2,1,0,1,1],
                   [1,1,0,1,1],
                   [1,0,1,1,1],
                   [1,1,0,0,1],
                   [0,1,1,1,1],
                   [0,0,0,0,0]]
    
    let level20 = [[0,0,0,0,0],
                   [1,1,0,1,1],
                   [1,1,1,0,1],
                   [2,1,1,1,1],
                   [1,1,0,1,1],
                   [1,1,1,1,1],
                   [0,0,0,0,0]]
    
    let level21 = [[0,0,0,0,0],
                   [1,1,1,1,1],
                   [1,0,1,1,1],
                   [1,1,1,1,1],
                   [1,1,1,0,2],
                   [1,0,1,1,1],
                   [0,0,0,0,0]]
    
    let level22 = [[0,0,0,0,0],
                   [0,1,1,0,0],
                   [1,1,1,1,1],
                   [1,0,0,1,1],
                   [1,2,1,1,0],
                   [0,0,1,1,1],
                   [0,0,0,0,0]]
    
    let level23 = [[0,0,0,0,0],
                   [0,0,1,1,1],
                   [1,1,1,0,1],
                   [1,0,1,1,1],
                   [1,1,1,1,0],
                   [0,0,2,1,0],
                   [0,0,0,0,0]]
    
    let level24 = [[0,0,0,0,0],
                   [1,1,1,0,0],
                   [1,1,1,1,1],
                   [1,1,0,2,1],
                   [1,1,0,1,0],
                   [0,1,1,1,0],
                   [0,0,0,0,0]]
    
    let level25 = [[0,0,0,0,0],
                   [1,1,1,1,1],
                   [1,2,0,0,1],
                   [1,1,1,1,1],
                   [1,1,0,1,1],
                   [0,1,1,1,1],
                   [0,0,0,0,0]]
    
    let level26 = [[2,1,1,1,1],
                   [0,0,0,0,1],
                   [1,1,1,1,1],
                   [1,0,0,0,0],
                   [1,1,1,1,1],
                   [0,0,0,0,1],
                   [1,1,1,1,1]]
    
    let level27 = [[1,1,1,1,1],
                   [0,0,0,0,1],
                   [1,1,1,1,1],
                   [1,0,0,1,1],
                   [1,0,2,1,1],
                   [1,0,0,0,1],
                   [1,1,1,1,1]]
    
    let level28 = [[2,1,1,1,1],
                   [0,0,0,0,1],
                   [0,1,1,1,1],
                   [0,1,1,1,0],
                   [0,1,1,1,1],
                   [0,0,0,0,1],
                   [1,1,1,1,1]]
    
    let level29 = [[0,1,1,1,0],
                   [0,1,1,1,1],
                   [0,1,1,0,1],
                   [1,1,0,2,0],
                   [1,1,0,1,0],
                   [0,1,0,1,1],
                   [0,1,1,1,1]]
    
    let level30 = [[2,1,1,0,0],
                   [0,0,1,1,0],
                   [0,1,1,1,0],
                   [0,1,0,1,1],
                   [0,1,0,1,1],
                   [0,1,1,1,1],
                   [0,0,0,0,1]]
    
    let level31 = [[1,1,1,1,1],
                   [1,1,0,1,1],
                   [0,1,1,1,1],
                   [0,0,2,0,1],
                   [0,1,1,1,1],
                   [1,1,1,0,0],
                   [1,1,1,0,0]]
    
    let level32 = [[0,1,1,1,0],
                   [1,1,0,1,0],
                   [1,0,1,1,0],
                   [2,0,1,1,0],
                   [0,1,1,1,0],
                   [1,1,0,0,1],
                   [1,1,1,1,1]]
    
    let level33 = [[1,1,1,1,1],
                   [1,0,0,0,1],
                   [1,1,1,1,1],
                   [1,1,0,1,1],
                   [1,1,0,0,0],
                   [1,0,2,1,0],
                   [1,1,1,1,0]]
    
    let level34 = [[0,0,1,1,1],
                   [1,1,1,0,1],
                   [1,0,1,1,1],
                   [1,0,2,1,1],
                   [1,0,0,1,1],
                   [1,1,1,1,0],
                   [1,1,0,0,0]]
    
    let level35 = [[1,1,1,1,1],
                   [1,0,0,0,1],
                   [1,1,1,1,1],
                   [1,0,1,1,1],
                   [2,0,1,0,1],
                   [1,1,1,0,1],
                   [1,1,1,1,1]]
    
    let level36 = [[1,1,1,1,0],
                   [1,0,1,1,0],
                   [1,1,2,0,0],
                   [1,1,0,1,1],
                   [1,1,1,1,1],
                   [1,1,0,0,1],
                   [1,1,1,1,1]]
    
    let level37 = [[1,1,1,1,1],
                   [1,0,1,1,1],
                   [0,2,0,0,1],
                   [0,1,1,0,1],
                   [1,1,1,0,1],
                   [1,0,1,1,1],
                   [1,1,1,0,0]]
    
    let level38 = [[1,1,0,2,0],
                   [1,1,1,1,0],
                   [1,1,0,0,0],
                   [0,1,1,1,0],
                   [0,0,1,1,0],
                   [1,1,1,1,1],
                   [1,1,1,1,0]]
    
    let level39 = [[0,0,1,1,1],
                   [0,0,1,1,1],
                   [1,1,1,1,1],
                   [1,0,1,1,0],
                   [1,0,1,1,2],
                   [1,0,1,1,0],
                   [1,1,1,1,0]]
    
    let level40 = [[1,1,0,0,1],
                   [1,1,1,1,1],
                   [1,0,1,1,0],
                   [1,1,1,1,0],
                   [1,2,0,1,1],
                   [1,0,1,1,1],
                   [1,1,1,0,0]]
    
    let level41 = [[1,2,1,1,1],
                   [1,1,1,1,1],
                   [0,1,1,1,1],
                   [1,1,1,1,1],
                   [0,1,0,0,1],
                   [0,1,1,1,1],
                   [0,0,0,0,0]]
    
    let level42 = [[0,0,0,0,0],
                   [0,1,1,1,1],
                   [1,1,1,1,1],
                   [1,1,1,0,0],
                   [1,1,0,0,1],
                   [1,1,1,1,1],
                   [1,1,1,1,2]]
    
    let level43 = [[0,1,1,1,2],
                   [0,1,1,0,0],
                   [1,1,1,0,0],
                   [1,1,1,1,1],
                   [0,0,0,0,1],
                   [1,1,1,1,1],
                   [1,1,0,1,1]]
    
    let level44 = [[0,0,0,1,1],
                   [0,1,1,1,1],
                   [0,1,0,0,1],
                   [0,2,0,1,1],
                   [1,1,1,1,0],
                   [1,1,1,1,0],
                   [0,0,0,1,1]]
    
    let level45 = [[1,1,1,0,0],
                   [1,1,1,1,0],
                   [1,1,1,1,0],
                   [1,1,1,1,2],
                   [1,1,1,1,1],
                   [1,1,1,0,1],
                   [0,0,0,0,0]]
    
    let level46 = [[0,0,0,1,1],
                   [1,1,1,1,1],
                   [1,1,1,0,1],
                   [0,1,1,0,1],
                   [2,1,0,0,1],
                   [0,1,1,1,1],
                   [0,1,1,1,0]]
    
    let level47 = [[0,0,0,1,1],
                   [1,1,1,1,1],
                   [1,1,1,0,0],
                   [0,0,1,1,0],
                   [1,1,1,1,1],
                   [1,2,1,0,1],
                   [1,1,1,1,1]]
    
    let level48 = [[0,0,0,0,0],
                   [1,1,1,1,1],
                   [1,1,1,2,1],
                   [1,0,1,1,1],
                   [0,1,1,1,1],
                   [0,1,1,1,1],
                   [0,0,1,1,1]]
    
    let level49 = [[0,1,1,1,1],
                   [1,1,1,1,0],
                   [1,1,0,1,1],
                   [0,1,0,1,1],
                   [1,1,2,1,1],
                   [1,1,1,1,1],
                   [0,0,0,0,0]]
    
    let level50 = [[1,1,1,0,0],
                   [1,1,1,1,1],
                   [0,1,0,1,1],
                   [1,1,0,1,0],
                   [1,1,1,2,1],
                   [0,1,1,0,1],
                   [0,1,1,1,1]]

    
    
    var levels: [[[Int]]] = [[[Int]]]()
    
    var currentLevel: Int = 0
    
    var unmowedTiles: [[SKTileGroup]] {
        let tileSet = SKTileSet(named: "UnmowedGrass")
        let tileGroups = tileSet?.tileGroups
        var tiles: [[SKTileGroup]] = [[SKTileGroup]]()
        
        for index1 in 0...6{
            var rowTiles = [SKTileGroup]()
            for index2 in 0...4{
                rowTiles.append((tileGroups?.first(where: {$0.name == "grass\(index2)\(index1)"}))!)
            }
            tiles.append(rowTiles)
        }
        return tiles
    }
    
    var elapsedTime: Double = UserDefaults.standard.double(forKey: "time")
    
    var randomLevels: Bool = false
    var nextRandomLevel: [[Int]]? = nil
    
    public init(){
        levels = [level1.reversed(),level2.reversed(),level3.reversed(),level4.reversed(),level5.reversed(),
                  level6.reversed(),level7.reversed(),level8.reversed(),level9.reversed(),level10.reversed(),
                  level11.reversed(),level12.reversed(),level13.reversed(),level14.reversed(),level15.reversed(),
                  level16.reversed(),level17.reversed(),level18.reversed(),level19.reversed(),level20.reversed(),
                  level21.reversed(),level22.reversed(),level23.reversed(),level24.reversed(),level25.reversed(),
                  level26.reversed(),level27.reversed(),level28.reversed(),level29.reversed(),level30.reversed(),
                  level31.reversed(),level32.reversed(),level33.reversed(),level34.reversed(),level35.reversed(),
                  level36.reversed(),level37.reversed(),level38.reversed(),level39.reversed(),level40.reversed(),
                  level41.reversed(),level42.reversed(),level43.reversed(),level44.reversed(),level45.reversed(),
                  level46.reversed(),level47.reversed(),level48.reversed(),level49.reversed(),level50.reversed()]

        
//        levels = [level1.reversed(),level2.reversed()]
        
        let level = UserDefaults.standard.integer(forKey: "level")
        if level == 0 {
            currentLevel = level + 1
            UserDefaults.standard.setValue(currentLevel, forKey: "level")
        } else {
            currentLevel = level
        }

    }
    
    func newLevel(){
        if !randomLevels{
            currentLevel += 1
            UserDefaults.standard.setValue(currentLevel, forKey: "level")
        }
    }
    
    func updateTime(elapsedTime: Double){
        print("time: \(elapsedTime)")
        UserDefaults.standard.setValue((UserDefaults.standard.double(forKey: "time") + elapsedTime), forKey: "time")
        self.elapsedTime = UserDefaults.standard.double(forKey: "time")
        print("stored time: \(self.elapsedTime)")
    }
    
    func reset(){
        currentLevel = 1
        UserDefaults.standard.setValue(currentLevel, forKey: "level")
        UserDefaults.standard.setValue(0.0, forKey: "time")
    }
    
    func randomLevel(numSquares: Int) -> [[Int]]{
        //take in the number of squares to be covered
        var level: [[Int]] = [[Int]]()
        for i in 0...6{
            level.append([Int]())
            for _ in 0...4{
                level[i].append(0)
            }
        }
        
        
        var history: [[Int]] = [[Int]]()
        var mostRecentMistake: [Int] = [Int]()
        
        
        let startingCol = GKRandomSource.sharedRandom().nextInt(upperBound: 5)
        let startingRow = GKRandomSource.sharedRandom().nextInt(upperBound: 7)
        level[startingRow][startingCol] = 2
        //    print("starting row \(startingRow)")
        //    print("starting Col \(startingCol)")
        //    print(level[startingRow][startingCol])
        
        var currentPoint: [Int] = [startingCol,startingRow]
        history.append(currentPoint)
        
        var iterations: Int = 0
        
        while history.count < numSquares {
            iterations += 1
            guard iterations < 500 else {
                return self.randomLevel(numSquares: numSquares)
            }
            
            //        print("history \(history)")
            
            currentPoint = history.last!
            //first get the neighbors of current point
            var neighbors = getNeighbors(col: currentPoint[0], row: currentPoint[1])

            //get rid of all non-valid neighbors
            for neighbor in neighbors {
                if level[neighbor[1]][neighbor[0]] != 0 || neighbor == mostRecentMistake {
                    let index = neighbors.index(of: neighbor)!
                    neighbors.remove(at: index)
                }
            }
            
            
            //if no options, goes back one square
            if neighbors.count == 0 {
                level[currentPoint[1]][currentPoint[0]] = 0
                mostRecentMistake = history.removeLast()
//                print("going back")
                continue
            }
            
            //then choose a direction
            let direction = GKRandomSource.sharedRandom().nextInt(upperBound: neighbors.count)
            let chosenSquare = neighbors[direction]
            level[chosenSquare[1]][chosenSquare[0]] = 1
            history.append(chosenSquare)
            //        print("*******done with current iteration********")
        }
        
//        print(history)
        return level
    }
    
    func getNeighbors(col: Int, row: Int) -> [[Int]]{
        //finds the neighbors and returns them in a 2d array
        //goes right,top,bottom,left
        //adds [-1,-1] if neighbor does not exist
        var neighbors: [[Int]] = [[Int]]()
        let numCols: Int = 5
        let numRows: Int = 7
        //right neighbor
        if col < (numCols - 1) {
            neighbors.append([col+1,row])
        }
        
        //top neighbor
        if row < (numRows - 1){
            neighbors.append([col, row + 1])
        }
        
        //bottom neighbor
        if row > 0 {
            neighbors.append([col, row - 1])
        }
        
        //left neighbor
        if col > 0 {
            neighbors.append([col - 1, row])
        }
        
        return neighbors
    }
    
    func prepareNextRandomLevel(numSquares: Int){
        nextRandomLevel = self.randomLevel(numSquares: numSquares)
    }
    
    
}

