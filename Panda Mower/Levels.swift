//
//  Levels.swift
//  Puzzler
//
//  Created by Evan Arthur on 7/16/18.
//  Copyright © 2018 Evan Arthur. All rights reserved.
//

import Foundation
import SpriteKit

class Levels{
    //fields
    let levels: [Level]
    
    var unmowedTiles: [SKTileGroup] {
        let tileSet = SKTileSet(named: "UnmowedGrass")
        let tileGroups = tileSet?.tileGroups
        var tiles: [SKTileGroup] = [SKTileGroup]()
        
        for index1 in 0...4{
            for index2 in 0...4{
                tiles.append((tileGroups?.first(where: {$0.name == "grass\(index2)\(index1)"}))!)
            }
        }
        return tiles
    }
    
    //initializer
    public init(levels: [Level]){
        self.levels = levels
    }
}
