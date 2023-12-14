//
//  StartView.swift
//  Test2
//
//  Created by Claudia De Luca on 13/12/23.
//
//
//  StartView.swift
//  Test2
//
//  Created by Claudia De Luca on 13/12/23.
//

import SwiftUI
import SpriteKit

struct ChooseChar: View {
    @Binding var currentGameState: GameState
    
    var drags = Drags()
    
    private var screenWidth: CGFloat { UIScreen.main.bounds.size.width }
    private var screenHeight: CGFloat { UIScreen.main.bounds.size.height }
    
    @StateObject var gameLogic: ArcadeGameLogic = ArcadeGameLogic()
    
    @State var isSelected = false
    
    @State private var dragSelected: String = ""
    
    var body: some View {
        HStack {
            Spacer(minLength: 60)
            ZStack {
                LazyVGrid(columns: Array(repeating: GridItem(), count: 2), spacing: 10){
                    ForEach(drags.dragS, id: \.id){ drg in
                        Button(action: {
                            isSelected.toggle()
                            if isSelected {
                                dragSelected = drg.image
                            }
                        }, label: {
                            VStack {
                                Image(drg.pic)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 180.0, height: 120.0)
                                
                                Text(drg.name).foregroundStyle(Color.black)
                            }.frame(width: 180.0, height: 180.0)
                        })
                    }
                }
                .frame(width: 360.0, height: 360.0)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                    .opacity(0.5)
                    .foregroundStyle(Color.white))
                
            }.padding(.top)
            .frame(width: 350, height: screenHeight)
            
            ZStack {
                //SpotlightView()
                Image(dragSelected)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 380.0, height: 380.0)
                
                Button(action: {
                    currentGameState = .playing
                }, label: {
                    Text("Fight")
                        .font(.custom("Atlantis Headline",
                                      size: 30,
                                      relativeTo: .headline))
                        .padding(.all, 7.0)
                        .foregroundStyle(Color.white)
                        .background(Color.pink)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }) .padding(.top, screenHeight - 80)
            }.frame(width: screenWidth / 2, height: screenHeight)
        }
        
        .background(Image("BG_BL")
            .resizable()
            .ignoresSafeArea()
            .aspectRatio(contentMode: .fit)
            .frame(width: 1170, height: 2532))
    }
}

#Preview {
    ChooseChar(currentGameState: .constant(GameState.chooseChar))
}
