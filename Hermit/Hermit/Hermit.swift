
import SpriteKit

class Hermit: SKSpriteNode {
    
    let textureArray: [SKTexture] = [SKTexture(imageNamed: "crab1"), SKTexture(imageNamed: "crab2")]
    
    var isSprint = false
    var isOpponent: Bool = false
    var shell: Shell?
    
//    init(opponent : Bool) {
//        isOpponent = opponent
//        let texture = SKTexture(imageNamed: "crab1")
//        super.init(texture: texture, color: SKColor.clear, size: texture.size())
//        self.name = opponent ? "opponent" : "hermit"
//        self.physicsBody = SKPhysicsBody(texture: SKTexture(imageNamed: "crab1"), size: size)
//        physicsBody?.categoryBitMask = CollisionType.hermit
//        physicsBody?.contactTestBitMask = CollisionType.floor
//        physicsBody?.collisionBitMask = CollisionType.floor
//        physicsBody?.restitution = 0
//        physicsBody?.mass = 0.2
//        physicsBody!.affectedByGravity = true
//        physicsBody!.isDynamic = true
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    func prepare() {
        shell = Shell(imageNamed: "classic")
        shell?.size = self.size
        shell?.zPosition = -1
        self.addChild(shell!)
    }
    
    func updateSpeed(_ force: Double) {
        if force > 6 && !isSprint {
            isSprint = true
            sprint()
        } else if isSprint {
            isSprint = false
            self.removeAllActions()
            start()
        }
    }
    
    func start() {
        let animate = SKAction.animate(with: textureArray, timePerFrame: 0.1)
        self.run(SKAction.repeatForever(animate))
    }
    
    func sprint() {
        self.removeAllActions()
        let animate = SKAction.animate(with: textureArray, timePerFrame: 0.04)
        self.run(SKAction.repeatForever(animate))
    }
    
    func stop() {
        self.removeAllActions()
    }
    
    func becomeShell() {
        self.removeAllActions()
        texture = nil
        color = UIColor.clear
    }
}
