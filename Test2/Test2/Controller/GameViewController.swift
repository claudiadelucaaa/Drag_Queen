//
//  GameViewController.swift
//  DragGame
//
//  Created by Claudia De Luca on 06/12/23.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

     var gameLogic: ArcadeGameLogic =  ArcadeGameLogic.shared
    
    // The game state is used to transition between the different states of the game
//    @Binding var currentGameState: GameState
    
    private var screenWidth: CGFloat { UIScreen.main.bounds.size.width }
    private var screenHeight: CGFloat { UIScreen.main.bounds.size.height }
    
    weak var startVC : StartViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            let scene = GameScene(size: self.view.frame.size)
//            view.showsFPS = true
//            view.showsPhysics = true
//            view.showsNodeCount = true
            view.ignoresSiblingOrder = true
            scene.gameVC = self
            view.presentScene(scene)
        }
    }
    
    func initialSetUp() {

    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

}
//import SwiftUI
//import SpriteKit
//import GameplayKit
//
//
//struct GameContainerView: View {
//    
//    @StateObject private var gameLogic = ArcadeGameLogic.shared
//    private var screenWidth: CGFloat { UIScreen.main.bounds.size.width }
//    private var screenHeight: CGFloat { UIScreen.main.bounds.size.height }
//
//    var body: some View {
//        ZStack(alignment: .top) {
//            // View that presents the game scene
//            SpriteView(scene: GameScene())
//                .frame(width: screenWidth, height: screenHeight)
//                .statusBar(hidden: true)
//
//            HStack() {
//                /**
//                 * UI element showing the duration of the game session.
//                 * Remove it if your game is not based on time.
//                 */
//                GameDurationView(time: $gameLogic.sessionDuration)
//
//                Spacer()
//
//                /**
//                 * UI element showing the current score of the player.
//                 * Remove it if your game is not based on scoring points.
//                 */
//                GameScoreView(score: $gameLogic.currentScore)
//            }
//            .padding()
//            .padding(.top, 40)
//        }
//        .onChange(of: gameLogic.isGameOver) { _ in
//            if gameLogic.isGameOver {
//                withAnimation {
//                    self.presentGameOverScreen()
//                }
//            }
//        }
//        .onAppear {
//            gameLogic.restartGame()
//        }
//    }
//
//    private func presentGameOverScreen() {
//        // Implement the logic to present the game over screen here
//    }
//}
//
//class GameViewController: UIViewController {
//    private var gameContainerViewController: UIHostingController<GameContainerView>?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Set up the SwiftUI hosting controller
//        let gameContainerView = GameContainerView()
//        gameContainerViewController = UIHostingController(rootView: gameContainerView)
//        addChild(gameContainerViewController!)
//        view.addSubview(gameContainerViewController!.view)
//        gameContainerViewController!.didMove(toParent: self)
//    }
//
//    override var shouldAutorotate: Bool {
//        return true
//    }
//
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
//}
