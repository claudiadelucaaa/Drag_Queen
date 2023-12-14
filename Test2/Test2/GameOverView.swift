//
//  GameOverView.swift
//  Test2
//
//  Created by yatziri on 13/12/23.
//


import SwiftUI

/**
 * # GameOverView
 *   This view is responsible for showing the game over state of the game.
 *  Currently it only present buttons to take the player back to the main screen or restart the game.
 *
 *  You can also present score of the player, present any kind of achievements or rewards the player
 *  might have accomplished during the game session, etc...
 **/




struct GameOverView: View {
    
    @Binding var currentGameState: GameState
    
    var body: some View {
        ZStack {
            
            Image("BG_BL")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
                .frame(width: 1170)
            ZStack{
                VStack(alignment: .center) {
                    Spacer()
                    
                    Button {
                        withAnimation { self.backToMainScreen() }
                    } label: {
                        Image(systemName: "arrow.backward")
                            .foregroundColor(.black)
                            .font(.title)
                    }
                    .background(Circle().foregroundColor(Color(uiColor: UIColor.systemGray6)).frame(width: 100, height: 100, alignment: .center))
                    
                    Spacer()
                    
                    Button {
                        withAnimation { self.restartGame() }
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(.black)
                            .font(.title)
                    }
                    .background(Circle().foregroundColor(Color(uiColor: UIColor.systemGray6)).frame(width: 100, height: 100, alignment: .center))
                    
                    Spacer()
                }
            }
//            .background(.white)
//            .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
            
            
        }
        .statusBar(hidden: true)
    }
    
    private func backToMainScreen() {
        self.currentGameState = .chooseChar
    }
    
    private func restartGame() {
        self.currentGameState = .playing
    }
}


//
//struct GameOverView: View {
//    
//    @Binding var currentGameState: GameState
//    
//    var body: some View {
//        ZStack {
//            Color.white
//                .ignoresSafeArea()
//            
//            VStack(alignment: .center) {
//                Spacer()
//                
//                Button {
//                    withAnimation { self.backToMainScreen() }
//                } label: {
//                    Image(systemName: "arrow.backward")
//                        .foregroundColor(.black)
//                        .font(.title)
//                }
//                .background(Circle().foregroundColor(Color(uiColor: UIColor.systemGray6)).frame(width: 100, height: 100, alignment: .center))
//                
//                Spacer()
//                
//                Button {
//                    withAnimation { self.restartGame() }
//                } label: {
//                    Image(systemName: "arrow.clockwise")
//                        .foregroundColor(.black)
//                        .font(.title)
//                }
//                .background(Circle().foregroundColor(Color(uiColor: UIColor.systemGray6)).frame(width: 100, height: 100, alignment: .center))
//                
//                Spacer()
//            }
//        }
//        .statusBar(hidden: true)
//    }
//    
//    private func backToMainScreen() {
//        self.currentGameState = .chooseChar
//    }
//    
//    private func restartGame() {
//        self.currentGameState = .playing
//    }
//}

#Preview {
    GameOverView(currentGameState: .constant(GameState.gameOver))
}
