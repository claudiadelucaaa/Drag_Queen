//
//  StartView.swift
//  Test2
//
//  Created by Claudia De Luca on 14/12/23.
//

import SwiftUI

struct StartView: View {
    @State private var textOffset: CGFloat = -1000
    @Binding var currentGameState: GameState
    
    private var screenWidth: CGFloat { UIScreen.main.bounds.size.width }
    private var screenHeight: CGFloat { UIScreen.main.bounds.size.height }
    
    var body: some View {
            VStack {
                Spacer()
                Text("DragQueen \n vs \n Human")
                    .offset(x: 0, y: textOffset)
                    .animation(.spring())
                    .multilineTextAlignment(.center)
                    .font(.custom("Atlantis Headline",
                                  size: 40, relativeTo: .headline))
                    .foregroundStyle(Color.white)
                
                Spacer()
                
                Button(action: {
                    currentGameState = .chooseChar
                }, label: {
                    Text("Start")
                        .font(.custom("Atlantis Headline",
                                      size: 30, relativeTo: .headline))
                        .padding(.all, 7.0)
                        .foregroundStyle(Color.white)
                        .background(Color.pink)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    
                })
                Spacer()
            }
            .background(Image("BG_BL")
                .resizable()
                .ignoresSafeArea()
                .aspectRatio(contentMode: .fit)
                .frame(width: 1170, height: 2532))
            .onAppear {
                withAnimation {
                    textOffset = 0
                }
            }
    }
}

#Preview {
    StartView(currentGameState: .constant(.firstTime))
}
