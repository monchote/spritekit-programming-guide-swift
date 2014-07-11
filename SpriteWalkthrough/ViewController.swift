//
//  ViewController.swift
//  SpriteWalkthrough
//
//  Created by Ramon Arguello on 10/07/2014.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {
    var mSceneView: SKView!
                            
    override func viewDidLoad() {
        super.viewDidLoad()

        mSceneView = self.view as? SKView
        mSceneView.showsDrawCount = true
        mSceneView.showsNodeCount = true
        mSceneView.showsFPS = true
    }

    override func viewWillAppear(animated: Bool) {
        let helloScene = HelloScene(size: mSceneView.frame.size)
        mSceneView.presentScene(helloScene)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

