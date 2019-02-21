//
//  GameScene.swift
//  Hermit
//
//  Created by Enrico Castelli on 21/02/2019.
//  Copyright © 2019 Enrico Castelli. All rights reserved.
//

import SpriteKit
import GameplayKit
import AudioToolbox

class GameScene: SKScene {
    
    private var hermit : Hermit!
    private var opponent : Hermit!
    var force: Double = 0

    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        hermit = self.children[0] as! Hermit
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        borderBody.friction = 0
        self.physicsBody = borderBody
        addFloor()
        hermit.prepare()
    }
    
    func addFloor() {
        let floor = SKSpriteNode(color: UIColor.white, size: CGSize(width: UIScreen.main.bounds.width, height: 10))
        floor.position = CGPoint(x: 0, y: -100)
        floor.physicsBody = SKPhysicsBody(rectangleOf: floor.size)
        floor.physicsBody!.affectedByGravity = false
        floor.physicsBody!.isDynamic = false
        floor.physicsBody?.categoryBitMask = CollisionType.floor
        floor.physicsBody?.contactTestBitMask = CollisionType.hermit
        floor.physicsBody?.collisionBitMask = CollisionType.floor
        addChild(floor)
    }
    
    func addHermit() {
        hermit.size = CGSize(width: 100, height: 90)
        hermit.position = CGPoint(x: 60, y: 0)
        addChild(hermit)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        hermit.start()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let forceTouch = Double(touch.force)
        guard forceTouch < 6.6 else {
            shell()
            return
        }
        self.force = forceTouch
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        self.force = 0
        hermit.stop()
    }

    override func update(_ currentTime: TimeInterval) {
        hermit.physicsBody?.applyForce(CGVector(dx: self.force*30, dy: 0))
    }
    
    func shell() {
        self.force = 0
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        hermit.becomeShell()
        hermit.physicsBody = nil
    }

}

extension GameScene: SKPhysicsContactDelegate {
    
    func didBeginContact(contact: SKPhysicsContact) {
        print(contact.bodyA.node?.name)
    }
}
