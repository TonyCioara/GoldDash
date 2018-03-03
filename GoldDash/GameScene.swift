//
//  GameScene.swift
//  GoldDash
//
//  Created by Tony Cioara on 3/1/18.
//  Copyright © 2018 Tony Cioara. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var player: Player!
    var mapNode: SKNode!
    var currentTile: TileTypes!
    var mapArray = [Array<Int>]()
    
    override func didMove(to view: SKView) {
        
//        Initialize Sprites
        mapNode = childNode(withName: "mapNode") as! SKNode
        player = childNode(withName: "player") as! Player
        
//        Generate map
        generateRandomMapArray()
        generateMapWithArray()
        
//        Set currentTile
        currentTile = TileTypes(rawValue: mapArray[0][0])
        
//        Initialize swipe gesture recognizers
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view?.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view?.addGestureRecognizer(swipeLeft)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.up
        self.view?.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        self.view?.addGestureRecognizer(swipeDown)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                swipeRight()
            case UISwipeGestureRecognizerDirection.left:
                swipeLeft()
            case UISwipeGestureRecognizerDirection.down:
                swipeDown()
            case UISwipeGestureRecognizerDirection.up:
                swipeUp()
            default:
                break
            }
        }
    }
    
    func updateCurrentTile () {
        let currentTileNumber = mapArray[player.yCoord][player.xCoord]
        currentTile = TileTypes(rawValue: currentTileNumber)!
    }
    
    func moveMap(x: Int, y: Int, amplifier: Int = 1) {
        let moveAction = SKAction.moveBy(x: CGFloat(x * amplifier), y: CGFloat(y * amplifier), duration: 0.05 * Double(amplifier))
        mapNode.run(moveAction)
    }
    
    func calculateMoveAmplifier() -> Int {
        var amplifier = 1
        switch currentTile! {
        case .wheatTile:
            amplifier = 2
        default:
            break
        }
        return amplifier
    }
    
    func swipeRight() {
//        Move player Right
        let amplifier = calculateMoveAmplifier()
        moveMap(x: -100, y: 0, amplifier: amplifier)
        player.move(direction: .right, withAmplifier: amplifier)
        updateCurrentTile ()
    }
    
    func swipeLeft() {
//        Move player Left
        let amplifier = calculateMoveAmplifier()
        moveMap(x: 100, y: 0, amplifier: amplifier)
        player.move(direction: .left, withAmplifier: amplifier)
        updateCurrentTile ()
    }
    
    func swipeUp() {
//        Move player Up
        let amplifier = calculateMoveAmplifier()
        moveMap(x: -50, y: -65, amplifier: amplifier)
        player.move(direction: .up, withAmplifier: amplifier)
        updateCurrentTile ()
    }
    
    func swipeDown() {
//        Move player Down
        let amplifier = calculateMoveAmplifier()
        moveMap(x: 50, y: 65, amplifier: amplifier)
        player.move(direction: .down, withAmplifier: amplifier)
        updateCurrentTile ()
    }
    
    //    MARK: Map Generation
    
    func generateTile(tileType: Int, xCoord: Int, yCoord: Int) {
        let yOffset = 0
        let xOffset = 0
        let newTile = Tile(tileNumber: tileType)
        newTile.position.x = CGFloat(
            Int(self.player.position.x) +
            xOffset +
            xCoord * 100 +
            yCoord * 50
        )
        newTile.position.y = CGFloat(
            Int(self.player.position.y) +
            yOffset +
            yCoord * 65
        )
        newTile.zPosition = CGFloat(xCoord - yCoord)
        if tileType == 2 {
            newTile.anchorPoint = CGPoint(x: 0.5, y: 0.25)
        }
        self.mapNode.addChild(newTile)
    }
    
    func generateMapWithArray() {
        for row in 0 ..< self.mapArray.count {
            let innerArray = self.mapArray[row]
            for col in 0 ..< innerArray.count {
                generateTile(tileType: innerArray[col], xCoord: col, yCoord: row)
            }
        }
    }
    
    func generateRandomMapArray() {
        for _ in 1 ... 20 {
            var innerArray = [Int]()
            for _ in 1 ... 20 {
                let rand = arc4random_uniform(2)
                innerArray.append(Int(rand))
            }
        self.mapArray.append(innerArray)
        }
        
//        Add winTile
        self.mapArray[18][18] = 2
    }
}
