//
//  SpaceshipScene.swift
//  SpriteWalkthrough
//
//  Created by Ramon Arguello on 10/07/2014.
//
import SpriteKit

class SpaceshipScene : SKScene {
    let ROCK_NODE_NAME = "rock"

    var contentCreated = false

    override func didMoveToView(view: SKView!) {
        if !contentCreated {
            createContents()
            contentCreated = true
        }
    }

    func createContents() {
        self.backgroundColor = SKColor.blackColor()
        self.scaleMode = SKSceneScaleMode.AspectFit

        let spaceship = newSpaceship()
        spaceship.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.addChild(spaceship)

        let makeRocks = SKAction.sequence([
            SKAction.runBlock(self.addRock),
            SKAction.waitForDuration(0.10, withRange: 0.15)])

        self.runAction(SKAction.repeatActionForever(makeRocks))
    }

    func newSpaceship() -> SKNode {
        let hull = SKSpriteNode(color: UIColor.grayColor(), size: CGSize(width: 64, height: 32))
        hull.physicsBody = SKPhysicsBody(rectangleOfSize: hull.size)
        hull.physicsBody.dynamic = false

        let light1 = newLight()
        light1.position = CGPoint(x: -28, y: 6)
        let light2 = newLight()
        light2.position = CGPoint(x: 28, y: 6)
        hull.addChild(light1)
        hull.addChild(light2)

        let hover = SKAction.sequence([
                SKAction.waitForDuration(1),
                SKAction.moveByX(100, y: 50, duration: 1),
                SKAction.waitForDuration(1),
                SKAction.moveByX(-100, y: -50, duration: 1)])
        hull.runAction(SKAction.repeatActionForever(hover))

        return hull
    }

    func newLight() -> SKNode {
        let light = SKSpriteNode(color: SKColor.yellowColor(), size: CGSize(width: 8, height: 8))
        let blink = SKAction.sequence([
            SKAction.fadeOutWithDuration(0.25),
            SKAction.fadeInWithDuration(0.25)])
        let blinkforever = SKAction.repeatActionForever(blink)
        light.runAction(blinkforever)
        return light
    }

    func addRock() {
        let rock = SKSpriteNode(color: SKColor.brownColor(), size: CGSize(width: 8, height: 8))
        rock.position = CGPoint(x: Double(arc4random()) % self.size.width, y: self.size.height)
        rock.name = ROCK_NODE_NAME
        rock.physicsBody = SKPhysicsBody(rectangleOfSize: rock.size)
        rock.physicsBody.usesPreciseCollisionDetection = true
        self.addChild(rock)
    }

    override func didSimulatePhysics() {
        var toRemove = [SKNode]()
        self.enumerateChildNodesWithName(ROCK_NODE_NAME) {
            node, stop in if node.position.y < 0 { toRemove += node }
        }
        for node in toRemove {
            node.removeFromParent()
        }
    }
}