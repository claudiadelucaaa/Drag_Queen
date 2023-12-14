//
//  Arcade_GameLogic.swift
//  Test2
//
//  Created by yatziri on 11/12/23.
//


import Foundation

class ArcadeGameLogic: ObservableObject {
    
    // Single instance of the class
    static let shared: ArcadeGameLogic = ArcadeGameLogic()
    
    // Function responsible to set up the game before it starts.
    func setUpGame() {
        self.currentScore = 0
        self.sessionDuration = 0
        self.liveScore = 3
        self.isGameOver = false
    }
    
    // Keeps track of the current score of the player
    @Published var currentScore: Int = 0
    
    // Increases the score by a certain amount of points
    func score(points: Int) {
        
        // TODO: Customize!
        
        self.currentScore = self.currentScore + points
    }
    
    
    
    
    // Keep tracks of the duration of the current session in number of seconds
    @Published var sessionDuration: TimeInterval = 0
    
    func increaseSessionTime(by timeIncrement: TimeInterval) {
        self.sessionDuration = self.sessionDuration + timeIncrement
    }
    
    func restart_Game() {
        
        // TODO: Customize!
        
        self.setUpGame()
    }
    
    
    
    // Game Over Conditions
    @Published var isGameOver: Bool = false
    
    func finishTheGame() {
        if self.isGameOver == false {
            self.isGameOver = true
        }
    }
    
    
    
    @Published var liveScore: Int = 3
    
    // Reduce the lives by a certain amount of points
    func lives(points: Int) {
        
        self.liveScore = self.liveScore - points
    }
    
}
