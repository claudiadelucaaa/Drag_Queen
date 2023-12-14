//
//  GameView.swift
//  Test2
//
//  Created by yatziri on 13/12/23.
//


import SwiftUI
import SpriteKit

struct GameView: View {
    
    @StateObject var gameLogic: ArcadeGameLogic = ArcadeGameLogic.shared
    @Binding var currentGameState: GameState
    
    private var screenWidth: CGFloat { UIScreen.main.bounds.size.width }
    private var screenHeight: CGFloat { UIScreen.main.bounds.size.height }
    
    var arcadeGameScene: GameScene {
        let scene = GameScene()
        scene.size = CGSize(width: screenWidth, height: screenHeight)
        scene.scaleMode = .fill
        return scene
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            SpriteView(scene: self.arcadeGameScene)
                .frame(width: screenWidth, height: screenHeight)
                .position(CGPoint(x: screenWidth / 2 , y: screenHeight / 2))
                .ignoresSafeArea()
                .statusBar(hidden: true)
            
            HStack() {
                GameDurationView(lives: $gameLogic.liveScore)
                
                Spacer()
                
                GameScoreView(score: $gameLogic.currentScore)
            }
            .padding()
            .padding(.top, 40)
        }
        .onChange(of: gameLogic.liveScore) { newLiveScore in
            if newLiveScore == 0 {
                withAnimation {
                    self.presentGameOverScreen()
                }
            }
        }
        .onAppear {
            gameLogic.restart_Game()
        }
    }
    
    private func presentMainScreen() {
        self.currentGameState = .playing
    }
    
    private func presentGameOverScreen() {
        self.currentGameState = .gameOver
    }
}



#Preview {
    GameView(currentGameState: .constant(GameState.playing))
}

