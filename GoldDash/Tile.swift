//
//  Tile.swift
//  GoldDash
//
//  Created by Tony Cioara on 3/2/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import SpriteKit

enum TileTypes: Int {
    case grassTile, wheatTile, winTile
    
    func getTile() -> String {
        switch self {
        case .grassTile:
            return "grassTile"
        case .wheatTile:
            return "wheatTile"
        case .winTile:
            return "winTile"
        }
    }
    
    func getTexture() -> SKTexture {
        switch self {
        case .grassTile:
            return SKTexture(imageNamed: "GrassTile")
        case .wheatTile:
            return SKTexture(imageNamed: "WheatTile")
        case .winTile:
            return SKTexture(imageNamed: "WinTile")
        }
    }
}

class Tile: SKSpriteNode {
    
    init(tileNumber: Int) {
        let tile = TileTypes(rawValue: tileNumber)
        let tileTexture = tile!.getTexture()
        let color = UIColor(white: 0, alpha: 0)
        super.init(texture: tileTexture, color: color, size: tileTexture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
