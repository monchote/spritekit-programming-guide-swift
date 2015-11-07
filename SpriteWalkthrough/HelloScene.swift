//
//  HelloScene.swift
//  SpriteWalkthrough
//
//  Created by Ramon Arguello on 10/07/2014.
//
import SpriteKit

class HelloScene : SKScene {
    let HELLO_WORLD_LABEL_NAME = "helloWorld"

    var contentCreated = false

    override func didMoveToView(view: SKView) {
        if !contentCreated {
            createContents()
            contentCreated = true
        }
    }

    func createContents() {
        self.backgroundColor = SKColor.blueColor()
        self.scaleMode = SKSceneScaleMode.AspectFit
        self.addChild(newHelloNode())
    }

    func newHelloNode() -> SKNode {
        let helloNode = SKLabelNode(fontNamed: "Chalkduster")
        helloNode.text = "Hello, World!"
        helloNode.fontSize = 42
        helloNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        helloNode.name = HELLO_WORLD_LABEL_NAME
        return helloNode
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let helloNode = childNodeWithName(HELLO_WORLD_LABEL_NAME)
        if (helloNode != nil) {
            helloNode?.name = nil
            let moveUp = SKAction.moveByX(0, y: 100.0, duration: 0.5)
            let zoom = SKAction.scaleTo(2.0, duration: 0.25)
            let pause = SKAction.waitForDuration(0.5)
            let fadeAway = SKAction.fadeOutWithDuration(0.25)
            let remove = SKAction.removeFromParent()
            let moveSequence = SKAction.sequence([moveUp, zoom, pause, fadeAway, remove])
            helloNode?.runAction(moveSequence) {
                let spaceshipScene = SpaceshipScene(size: self.size)
                let doors = SKTransition.doorsOpenVerticalWithDuration(0.5)
                self.view?.presentScene(spaceshipScene, transition: doors)
            }
        }
    }
}