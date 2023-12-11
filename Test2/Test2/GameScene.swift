//
//  GameScene.swift
//  Test2
//
//  Created by Claudia De Luca on 07/12/23.
//
/*
import SpriteKit
import GameplayKit

class GameScene: SKScene {
    weak var gameVC : GameViewController?
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
*/

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    weak var gameVC : GameViewController?
    
    var heroInAir = false
    var gameIsPaused = false {
        didSet {
            endGame()
        }
    }
    
    var jumpCount = 0
    
    var timer = Timer()
    
    
    var isMovingToTheRight: Bool = false
    var isMovingToTheLeft: Bool = false
    
    var heroNodeTexture = SKTexture(imageNamed: "Warrior_Run_1")
    var heroSpriteNode = SKSpriteNode()
    var heroNode = SKNode()
    
    var backGroundNodeArray = [SKNode]()
    var enemyNodeArray = [SKNode]()
    
    var groundSpriteNode = SKSpriteNode()
    var groundNode = SKNode()
    
    var wallSpriteNode = SKSpriteNode()
    var wallNode = SKNode()
    
    var secondWallSpriteNode = SKSpriteNode()
    var secondWallNode = SKNode()
        
    let textures = Textures()
    
//  var musicNode = SKAudioNode()
    
    var heroMask : UInt32 = 1
    var groundMask : UInt32 = 2
    var wallMask : UInt32 = 3
    var enemyMask : UInt32 = 4
    var advantagMask : UInt32 = 5
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        initialSetUp()
    }
    
    func initialSetUp() {
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -10 )
        
        addBackground(texture: textures.bg[0], zPosOffset: 1)
        createHero()
        createGround()
        createWall()
       // createAudio()
        startSpawn()
        
        addChild(heroNode)
        addChild(groundNode)
        addChild(wallNode)
        addChild(secondWallNode)
//      addChild(musicNode)
    }
    
    func addBackground(texture: SKTexture, zPosOffset: CGFloat) {
        // Nodo per lo sfondo fisso
        let backgroundNode = SKSpriteNode(texture: texture)
        backgroundNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        backgroundNode.size = size
        backgroundNode.zPosition = -zPosOffset - 2
        
        // Aggiungi lo sfondo come figlio della scena
        addChild(backgroundNode)
    }
    
    func createGround() {
        groundSpriteNode.position = CGPoint.zero
        groundSpriteNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: size.width * 2, height: 220))
        groundSpriteNode.physicsBody?.isDynamic = false
        groundSpriteNode.physicsBody?.categoryBitMask = groundMask
        groundSpriteNode.zPosition = 1
        
        groundNode.addChild(groundSpriteNode)
    }
    
    func createWall() {
        wallSpriteNode.position = CGPoint.zero
        wallSpriteNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 60, height: size.height * 2))
        wallSpriteNode.physicsBody?.isDynamic = false
        wallSpriteNode.physicsBody?.categoryBitMask = wallMask
        wallSpriteNode.zPosition = 1
        
        secondWallSpriteNode.position = CGPoint(x: size.width + 60, y: 0)
        secondWallSpriteNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 60, height: size.height * 2))
        secondWallSpriteNode.physicsBody?.isDynamic = false
        secondWallSpriteNode.physicsBody?.categoryBitMask = wallMask
        secondWallSpriteNode.zPosition = 1
        
        secondWallNode.addChild(secondWallSpriteNode)
        wallNode.addChild(wallSpriteNode)
    }
    
    // MARK: - Hero
    
    func addHero(at position: CGPoint) {
        heroSpriteNode = SKSpriteNode(texture: heroNodeTexture)
        let heroRunAnimation = SKAction.animate(with: textures.dragWalking , timePerFrame: 0.1)
        let heroRun = SKAction.repeatForever(heroRunAnimation)
        heroSpriteNode.run(heroRun)
        
        heroSpriteNode.position = position
        heroSpriteNode.zPosition = 1
        heroSpriteNode.setScale(4)
        
        
        heroSpriteNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: heroNodeTexture.size().width - 30, height: heroNodeTexture.size().height + 10))
        heroSpriteNode.physicsBody?.mass = 0.3
        heroSpriteNode.physicsBody?.categoryBitMask = heroMask
        heroSpriteNode.physicsBody?.contactTestBitMask = groundMask
        heroSpriteNode.physicsBody?.collisionBitMask = groundMask
        
        
        heroSpriteNode.physicsBody?.isDynamic = true
        heroSpriteNode.physicsBody?.allowsRotation = false
        
//        let moveLeft = SKAction.moveBy(x: -size.width / 3, y: 0, duration: 10)
//        let moveLeftRepeat = SKAction.repeatForever(moveLeft)
//        heroSpriteNode.run(moveLeftRepeat)
        
        heroNode.addChild(heroSpriteNode)
    }
    
    // MARK: - Hero position
    func createHero() {
        addHero(at: CGPoint(x: size.width / 2, y: size.height / 3))
    }
    
   /* func createAudio() {
        guard let musicURL = Bundle.main.url(forResource: "makai-symphony-dragon-slayer", withExtension: "mp3") else {
            fatalError()
        }
        musicNode = SKAudioNode(url: musicURL)
        musicNode.autoplayLooped = true
        musicNode.run(SKAction.play())
    }*/
    
    // MARK: - Enemy
    
    func createEnemy(width: CGFloat) {
        let enemyNode = SKNode()
        let enemySpriteNode = SKSpriteNode(texture: textures.heroRunTextureArray[0])
        let enemyAnimation = SKAction.animate(with: textures.heroRunTextureArray, timePerFrame: 0.1)
        let enemyAnimationRepeat = SKAction.repeatForever(enemyAnimation)
        enemySpriteNode.run(enemyAnimationRepeat)
        
        enemySpriteNode.position = CGPoint(x:  self.size.width - 50, y: 2)
        enemySpriteNode.zPosition = 1
        enemySpriteNode.setScale(2)
        
        enemySpriteNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: textures.enemyTexture[0].size().width, height: textures.enemyTexture[0].size().height))
        
        enemySpriteNode.physicsBody?.categoryBitMask = enemyMask
        enemySpriteNode.physicsBody?.contactTestBitMask = heroMask
        enemySpriteNode.physicsBody?.collisionBitMask = groundMask
        
        enemySpriteNode.physicsBody?.isDynamic = true
        enemySpriteNode.physicsBody?.affectedByGravity = true
        enemySpriteNode.physicsBody?.allowsRotation = false
        
//        duration till the enemy arrive the -100
        let moveLeft = SKAction.moveBy(x: -100, y: 0, duration: 0.5)
        let moveLeftRepeat = SKAction.repeatForever(moveLeft)
        enemySpriteNode.run(moveLeftRepeat)
        
        enemyNodeArray.append(enemyNode)
        enemyNode.addChild(enemySpriteNode)
        addChild(enemyNode)
    }

    
    // MARK: - herojump
    /*
    func heroJump(tapPos: CGPoint) {
        heroInAir = true
        jumpCount += 1
        let jumpAnimation = SKAction.animate(with: textures.dragWalking , timePerFrame: 0.1)
        heroSpriteNode.run(jumpAnimation)
        heroSpriteNode.physicsBody?.velocity = CGVector.zero
        
//        let xTar = size.width / 2 < tapPos.x ? 1 : -1
        heroSpriteNode.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 150))
//        heroSpriteNode.physicsBody?.applyImpulse(CGVector(dx: 100 * xTar, dy: 120))
    }
    */
    
    // MARK: - herodied
    func heroDied() {
        let deathAnim = SKAction.animate(with: textures.dragWalking , timePerFrame: 0.1)
        heroSpriteNode.run(deathAnim)
    }
    
    
    // MARK: - random num enemies inicialiced
    
    func startSpawn() {
        var timeInterval: TimeInterval = 3.0

        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { _ in
            self.createEnemy(width: self.size.width - self.size.width/20)

            // Reduzca el intervalo de tiempo para aumentar la frecuencia con el tiempo
            timeInterval *= 0.2
            // Asegúrate de que el intervalo de tiempo no sea menor que un límite mínimo
            timeInterval = max(timeInterval, 0.5)
            
            // Puedes ajustar los valores según sea necesario
        }
    }

//    func startSpawn() {
//        timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
//            self.createEnemy(width:  CGFloat.random(in: self.size.width/3...self.size.width) )
//        }
//    }
    
    
    // MARK: - Logic end game
    
    func endGame() {
        if gameIsPaused == true {
            timer.invalidate()
            children.forEach { node in
                node.removeAllActions()
                node.children.forEach { node in
                    node.removeAllActions()
                }
            }
            
//      musicNode.run(SKAction.stop())
            enemyNodeArray.forEach { node in
                node.removeFromParent()
            }
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                let blurView = UIVisualEffectView(frame: self.frame)
                blurView.alpha = 1
                blurView.layer.zPosition = 2
                self.gameVC?.view.addSubview(blurView)
                UIView.animate(withDuration: 3) {
                    blurView.effect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
                } completion: { _ in
                    let vc = self.gameVC?.storyboard?.instantiateViewController(identifier: "startVC") as! StartViewController
                    self.gameVC?.present(vc, animated: false, completion: nil)
                    self.gameVC?.removeFromParent()
                }
            }
        }
    }
}

// MARK: - contact enemi

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == 1 && contact.bodyB.categoryBitMask == 2 {
            heroInAir = false
            jumpCount = 0
            if gameIsPaused {
                physicsWorld.gravity = CGVector(dx: 0, dy: -10)
            }
        }
        
        if contact.bodyA.categoryBitMask == 4 && contact.bodyB.categoryBitMask == 1 || contact.bodyA.categoryBitMask == 1 && contact.bodyB.categoryBitMask == 4 {
            gameIsPaused = true
            heroDied()
            physicsWorld.gravity = CGVector(dx: 0, dy: -10)
        }
        
        if contact.bodyA.categoryBitMask == 4 && contact.bodyB.categoryBitMask == 3 || contact.bodyA.categoryBitMask == 3 && contact.bodyB.categoryBitMask == 4 {
            if contact.bodyA.categoryBitMask == 4 {
                contact.bodyA.node?.removeFromParent()
            } else {
                contact.bodyB.node?.removeFromParent()
            }
        }
    }
}

extension GameScene {
    
    enum SideOfTheScreen {
        case right, left
    }
    
    private func sideTouched(for position: CGPoint) -> SideOfTheScreen {
        if position.x < self.frame.width / 2 {
            return .left
        } else {
            return .right
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        switch sideTouched(for: touchLocation) {
        case .right:
            self.isMovingToTheRight = true
        case .left:
            self.isMovingToTheLeft = true
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isMovingToTheRight = false
        self.isMovingToTheLeft = false
    }
    
}

/*extension GameScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
}
*/
