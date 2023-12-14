//
//  ContentView.swift
//  Test2
//
//  Created by yatziri on 13/12/23.
//

import SwiftUI


struct ContentView: View {
    
    // The navigation of the app is based on the state of the game.
    // Each state presents a different view on the SwiftUI app structure
    @State var currentGameState: GameState = .firstTime
    @State var currentDragSelected: DragChoice = .bianca
    // The game logic is a singleton object shared among the different views of the application
    @StateObject var gameLogic: ArcadeGameLogic = ArcadeGameLogic()
    
    var body: some View {
        switch currentGameState {
        case .firstTime: StartView(currentGameState: $currentGameState)
            
        case .chooseChar:
            ChooseChar(currentGameState: $currentGameState, currentDragSelected: $currentDragSelected)

            
        case .playing:
            GameView(currentGameState: $currentGameState)
                .environmentObject(gameLogic)
        
        case .gameOver:
            GameOverView(currentGameState: $currentGameState)
                .environmentObject(gameLogic)
        }
    }
}

#Preview {
    ContentView()
}
