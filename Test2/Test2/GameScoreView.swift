//
//  GameScoreView.swift
//  Test2
//
//  Created by yatziri on 12/12/23.
//
import SwiftUI

struct GameScoreView: View {
    @Binding var score: Int
    
    var body: some View {
        
        HStack {
            Image(systemName: "target")
                .font(.headline)
            Spacer()
            Text("\(score)")
                .font(.headline)
        }
        .frame(minWidth: 100)
        .padding(24)
        .foregroundColor(.black)
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10)
    }
}

#Preview {
    GameScoreView(score: .constant(100))
        .previewLayout(.fixed(width: 300, height: 100))
}
