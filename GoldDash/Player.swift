//
//  Player.swift
//  GoldDash
//
//  Created by Tony Cioara on 3/2/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import SpriteKit

enum PlayerMove {
    case up, down, left, right
    
    func getPlayerTexture() -> SKTexture {
        switch self {
        case .up:
            return SKTexture(imageNamed: "lookingUp")
        case .down:
            return SKTexture(imageNamed: "lookingDown")
        case .left:
            return SKTexture(imageNamed: "lookingLeft")
        case .right:
            return SKTexture(imageNamed: "lookingRight")
        }
    }
}

class Player: SKSpriteNode {
    
    var xCoord = 0
    var yCoord = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func move(direction: PlayerMove, withAmplifier: Int = 1) {
//        Change player texture
        self.texture = direction.getPlayerTexture()
//        Change player coordibnates
        switch direction {
        case .up:
            self.yCoord += withAmplifier
        case .down:
            self.yCoord -= withAmplifier
        case .right:
            self.xCoord += withAmplifier
        case .left:
            self.xCoord -= withAmplifier
        }
    }
}
