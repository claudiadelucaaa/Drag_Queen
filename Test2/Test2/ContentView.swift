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
    @State var currentGameState: GameState = .playing
    
    // The game logic is a singleton object shared among the different views of the application
    @StateObject var gameLogic: ArcadeGameLogic = ArcadeGameLogic()
    
    var body: some View {
        
        switch currentGameState {
//        case .mainScreen:
//            MainScreenView(currentGameState: $currentGameState)
//                .environmentObject(gameLogic)
//        
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
