//claudia
//yat
//  GameScene.swift
//  Test2
//
//  Created by Claudia De Luca on 07/12/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var gameLogic: ArcadeGameLogic = ArcadeGameLogic.shared
    
    var heroInAir = false
    var gameIsPaused = false
    {
        didSet {
            endGame()
        }
    }
    var timeInterval: TimeInterval = 4.0
    var fast: TimeInterval = 10.0
    
//    var jumpCount = 0
    
    var timer = Timer()
    
    
    var isMovingToTheRight: Bool = false
    var isMovingToTheLeft: Bool = false
    
    var heroNodeTexture = SKTexture(imageNamed: "Warrior_Run_1")
    var heroSpriteNode = SKSpriteNode()
    var heroNode = SKNode()
    
    var lacaNodeTexture = SKTexture(imageNamed: "laca3")
    var lacaSpriteNode = SKSpriteNode()
    var lacaNode = SKNode()
    
    var backGroundNodeArray = [SKNode]()
    var enemyNodeArray = [SKNode]()
    
    var groundSpriteNode = SKSpriteNode()
    var groundNode = SKNode()
    
    var wallSpriteNode = SKSpriteNode()
    var wallNode = SKNode()
    
    var secondWallSpriteNode = SKSpriteNode()
    var secondWallNode = SKNode()
    
    let textures = Textures()
    
    var lastUpdate: TimeInterval = 0
    //
    
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
        self.gameLogic.setUpGame()
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
        let heroRunAnimation = SKAction.animate(with: textures.biancaWalking , timePerFrame: 0.1)
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
        addHero(at: CGPoint(x: size.width / 2, y: size.height / 2))
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
    
    func createEnemy(fast: TimeInterval) {
        let enemyNode = SKNode()
        let enemySpriteNode = SKSpriteNode(texture: textures.heroRunTextureArray[0])
        let enemyAnimation = SKAction.animate(with: textures.heroRunTextureArray, timePerFrame: 0.1)
        let enemyAnimationRepeat = SKAction.repeatForever(enemyAnimation)
        enemySpriteNode.run(enemyAnimationRepeat)
        
        enemySpriteNode.setScale(2.0)
        
        enemySpriteNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: textures.enemyTexture[0].size().width, height: textures.enemyTexture[0].size().height))
        //        enemySpriteNode.setScale(3)
        let direction = Bool.random()
        
        if direction {
            print("derecha")
            enemySpriteNode.position = CGPoint(x: size.width - 40, y: size.height / 4)
            enemySpriteNode.zPosition = 1
            enemySpriteNode.xScale *= -1
            
            // duration till the enemy arrives at -150
            let moveLeft = SKAction.moveBy(x: -size.width - 150, y: 0, duration: fast)
            let moveLeftRepeat = SKAction.repeatForever(moveLeft)
            enemySpriteNode.run(moveLeftRepeat)
            
            
        } else{
            print("izquierda")
            
            enemySpriteNode.position = CGPoint(x: size.width/8 , y: size.height / 12)
            enemySpriteNode.zPosition = 1
            enemySpriteNode.xScale *= 1
            
            
            // duration till the enemy arrives at 150
            let moveRight = SKAction.moveBy(x: size.width + 150, y: 0, duration: fast)
            let moveRightRepeat = SKAction.repeatForever(moveRight)
            enemySpriteNode.run(moveRightRepeat)
        }
        
        
        enemySpriteNode.physicsBody?.categoryBitMask = enemyMask
        enemySpriteNode.physicsBody?.contactTestBitMask = heroMask
        enemySpriteNode.physicsBody?.collisionBitMask = groundMask
        
        enemySpriteNode.physicsBody?.isDynamic = true
        enemySpriteNode.physicsBody?.affectedByGravity = true
        enemySpriteNode.physicsBody?.allowsRotation = false
        
        
        enemyNodeArray.append(enemyNode)
        enemyNode.addChild(enemySpriteNode)
        addChild(enemyNode)
    }
    
    // MARK: - random num enemies inicialiced
    
    func startSpawn() {
        if gameIsPaused == false{
            var timeInterval = timeInterval
            var fast = fast
            
            timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { _ in
                
                fast -= 0.4
                fast = max(fast,2.0)
                
                timeInterval -= 0.4
                timeInterval = max(timeInterval, 0.01)
                
                
                print("Enemy created in time interval \(timeInterval), and fast \(fast) ")
                
                self.createEnemy(fast: fast)
            }
        }
    }
    
    
    
    // MARK: - herojump
    /*
     func heroJump(tapPos: CGPoint) {
     heroInAir = true
     jumpCount += 1
     let jumpAnimation = SKAction.animate(with: textures.dragWalking , timePerFrame: 0.1)
     heroSpriteNode.run(jumpAnimation)
     heroSpriteNode.physicsBody?.velocity = CGVector.zero
     
     let xTar = size.width / 2 < tapPos.x ? 1 : -1
     heroSpriteNode.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 150))
     heroSpriteNode.physicsBody?.applyImpulse(CGVector(dx: 100 * xTar, dy: 120))
     }
     */
    
    
    
    // MARK: - herodied
    func heroDied() {
        let deathAnim = SKAction.animate(with: textures.deathTextureArray, timePerFrame: 0.2)
        heroSpriteNode.run(deathAnim) {
            self.gameLogic.lives(points: 1)
            print("lives: \(self.gameLogic.liveScore)")
            //            self.restartGame()
        }
        if gameLogic.liveScore == 0 {
            self.restartGame()
            
//            print(" REESTART..................")
        }
    }
    private func restartGame() {
        self.gameLogic.restart_Game()
        timeInterval = 4.0
        fast = 10.0
        gameIsPaused = true
//        print("----------------------------------\(timeInterval),     \(fast)")
    }
    func endGame() {
        if gameIsPaused == true {
            timer.invalidate()
            children.forEach { node in
                node.removeAllActions()
                node.children.forEach { node in
                    node.removeAllActions()
                }
            }
            
//            musicNode.run(SKAction.stop())
            enemyNodeArray.forEach { node in
                node.removeFromParent()
            }
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                let blurView = UIVisualEffectView(frame: self.frame)
                blurView.alpha = 1
                blurView.layer.zPosition = 2
//                self.gameVC?.view.addSubview(blurView)
                UIView.animate(withDuration: 3) {
                    blurView.effect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
                } completion: { _ in
//                    let vc = self.gameVC?.storyboard?.instantiateViewController(identifier: "startVC") as! StartViewController
//                    self.gameVC?.present(vc, animated: false, completion: nil)
//                    self.gameVC?.removeFromParent()
                }
            }
        }
    }
    
}



extension GameScene {
    
    
    var isGameOver: Bool {
        // TODO: Customize!
        
        // Did you reach the time limit?
        // Are the health points depleted?
        // Did an enemy cross a position it should not have crossed?
        
        return gameLogic.isGameOver
    }
    
    private func finishGame() {
        
        // TODO: Customize!
        
        gameLogic.isGameOver = true
    }
    
}

// MARK: - contact enemi

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == heroMask && contact.bodyB.categoryBitMask == enemyMask ||
            contact.bodyA.categoryBitMask == enemyMask && contact.bodyB.categoryBitMask == heroMask {
            heroDied()
            enemyDied()
        }
    }
    
    func enemyDied() {
        for enemyNode in enemyNodeArray {
            guard let enemySpriteNode = enemyNode.children.first as? SKSpriteNode else { continue }
            
            enemySpriteNode.removeFromParent() // Remove enemy from the scene
        }
    }
}




// MARK: - Handle Player Inputs
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
    
    // MARK: - Hero Atac
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        switch sideTouched(for: touchLocation) {
        case .right:
            self.isMovingToTheRight = true
            launchAttack(isRightSide: true)
            launch2Attack(isRightSide: true)
            //             print("ℹ️ Touching the RIGHT side.")
        case .left:
            self.isMovingToTheLeft = true
            launchAttack(isRightSide: false)
            launch2Attack(isRightSide: false)
            //             print("ℹ️ Touching the LEFT side.")
        }
    }
    
    func createLaca(space: Int) {
        lacaSpriteNode = SKSpriteNode(texture: lacaNodeTexture)
        lacaSpriteNode.setScale(0.1)
        lacaSpriteNode.position = CGPoint(x: heroSpriteNode.position.x + CGFloat(space) , y: heroSpriteNode.position.y)
        lacaSpriteNode.zPosition = 1

        lacaSpriteNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: lacaNodeTexture.size().width, height: lacaNodeTexture.size().height))
        lacaSpriteNode.physicsBody?.isDynamic = false
        lacaSpriteNode.physicsBody?.categoryBitMask = advantagMask
        lacaSpriteNode.physicsBody?.contactTestBitMask = enemyMask
        lacaSpriteNode.physicsBody?.collisionBitMask = 5

        heroNode.addChild(lacaSpriteNode)
    }
    
    func launchAttack(isRightSide: Bool) {
        if lacaSpriteNode.parent != nil {
            // La laca ya está en la escena, puedes reiniciar su posición o realizar otras acciones necesarias
            self.lacaSpriteNode.removeFromParent()
        }
        if isRightSide {
            createLaca(space: 70)
            let deathAnim = SKAction.animate(with: textures.biancaAttack, timePerFrame: 0.1)
            lacaSpriteNode.xScale *= -1
            let lacaAnim = SKAction.animate(with: textures.lacaAttack, timePerFrame: 0.1)
            heroSpriteNode.run(deathAnim) {
               
                self.lacaSpriteNode.run(lacaAnim) {
                    
                    self.lacaSpriteNode.removeFromParent()
                }
                
            }
           
            //             print("💥 Attacking on the RIGHT side!")
        } else {
            createLaca(space: -70)
            let deathAnim = SKAction.animate(with: textures.biancaAttack, timePerFrame: 0.1)
            let lacaAnim = SKAction.animate(with: textures.lacaAttack, timePerFrame: 0.1)
            
            heroSpriteNode.run(deathAnim) {
               
                self.lacaSpriteNode.run(lacaAnim) {
                    
                    self.lacaSpriteNode.removeFromParent()
                }
                
            }
            
            //             print("💥 Attacking on the LEFT side!")
        }
        
    }
    func launch2Attack(isRightSide: Bool) {
        // Iterate over all enemies to check if they are on the attacked side
        for enemyNode in enemyNodeArray {
            guard let enemySpriteNode = enemyNode.children.first as? SKSpriteNode else { continue }
            
            // Calculate the attack range based on hero's position and direction
            let attackRange: CGFloat = 170.0
            let heroPositionX = lacaSpriteNode.position.x
            let enemyPositionX = enemySpriteNode.position.x
            let deathAnim = SKAction.animate(with: textures.deathTextureArray, timePerFrame: 0.2)
            if (isRightSide && heroPositionX < enemyPositionX && enemyPositionX - heroPositionX < attackRange) ||
                (!isRightSide && heroPositionX > enemyPositionX && heroPositionX - enemyPositionX < attackRange) {
                
                enemySpriteNode.removeAllActions()
                enemySpriteNode.run(deathAnim) {
                   
                    enemySpriteNode.removeFromParent()
                    self.gameLogic.score(points: 1)
                }
                
                //                 printContent("------Point : \(gameLogic.currentScore)")
                
                print("💥 Attacking on the \(isRightSide ? "RIGHT" : "LEFT") side! Enemy defeated!")
                
                // Break out of the loop, as we only want to defeat one enemy per attack
                break
            }
        }
    }
    
}
