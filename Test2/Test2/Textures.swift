//
//  Textures.swift
//  Test2
//
//  Created by Claudia De Luca on 11/12/23.
//

//  Texture.swift
//  DragGame
//
//  Created by Ferdinando Liccardi on 07/12/23.
//

import Foundation
import SpriteKit

class Textures {
    
    let bg : [SKTexture] = [SKTexture(imageNamed: "background")]
    
    let biancaWalking : [SKTexture] = [SKTexture(imageNamed: "Bianca1"),
                                   SKTexture(imageNamed: "Bianca2"),
                                   SKTexture(imageNamed: "Bianca3"),
                                   SKTexture(imageNamed: "Bianca4"),
                                   SKTexture(imageNamed: "Bianca5")
    ]
    
    let laganjaWalking : [SKTexture] = [SKTexture(imageNamed: "Laganja1"),
                                        SKTexture(imageNamed: "Laganja2"),
                                        SKTexture(imageNamed: "Laganja3"),
                                        SKTexture(imageNamed: "Laganja1"),
                                        SKTexture(imageNamed: "Laganja2")
         ]
    
    let heroRunTextureArray : [SKTexture] = [SKTexture(imageNamed: "Warrior_Run_1"),
                                             SKTexture(imageNamed: "Warrior_Run_2"),
                                             SKTexture(imageNamed: "Warrior_Run_3"),
                                             SKTexture(imageNamed: "Warrior_Run_4"),
                                             SKTexture(imageNamed: "Warrior_Run_5"),
                                             SKTexture(imageNamed: "Warrior_Run_6"),
                                             SKTexture(imageNamed: "Warrior_Run_7"),
                                             SKTexture(imageNamed: "Warrior_Run_8"),
    ]
    
    let heroJumpTextureArray : [SKTexture] = [SKTexture(imageNamed: "Warrior_Jump_1"),
                                             SKTexture(imageNamed: "Warrior_Jump_2"),
                                             SKTexture(imageNamed: "Warrior_Jump_3"),
                                             SKTexture(imageNamed: "Warrior_UptoFall_1"),
                                             SKTexture(imageNamed: "Warrior_UptoFall_2"),
                                             SKTexture(imageNamed: "Warrior_Fall_1"),
    ]

    let bgLayerTextures : [(SKTexture, CGFloat)]  = [(SKTexture(imageNamed: "Layer_0000_9"), 3),
                                                     (SKTexture(imageNamed: "Layer_0001_8"), 3),
                                                     (SKTexture(imageNamed: "Layer_0002_7"), 3),
                                                     (SKTexture(imageNamed: "Layer_0003_6"), 3),
                                                     (SKTexture(imageNamed: "Layer_0004_Lights"), 2.5),
                                                     (SKTexture(imageNamed: "Layer_0005_5"), 4),
                                                     (SKTexture(imageNamed: "Layer_0006_4"), 4),
                                                     (SKTexture(imageNamed: "Layer_0007_Lights"), 3.5),
                                                     (SKTexture(imageNamed: "Layer_0008_3"), 5),
                                                     (SKTexture(imageNamed: "Layer_0009_2"), 5),
                                                     (SKTexture(imageNamed: "Layer_0010_1"), 5)
    ]
    
    let deathTextureArray: [SKTexture] = [SKTexture(imageNamed: "Warrior_Death_1"),
                                          SKTexture(imageNamed: "Warrior_Death_2"),
                                          SKTexture(imageNamed: "Warrior_Death_3"),
                                          SKTexture(imageNamed: "Warrior_Death_4"),
                                          SKTexture(imageNamed: "Warrior_Death_5"),
                                          SKTexture(imageNamed: "Warrior_Death_6"),
                                          SKTexture(imageNamed: "Warrior_Death_7"),
                                          SKTexture(imageNamed: "Warrior_Death_8"),
                                          SKTexture(imageNamed: "Warrior_Death_9"),
                                          SKTexture(imageNamed: "Warrior_Death_10"),
                                          SKTexture(imageNamed: "Warrior_Death_11"),
    ]
    
    let enemyTexture: [SKTexture] = [SKTexture(imageNamed: "fly01"),
                                     SKTexture(imageNamed: "fly02"),
                                     SKTexture(imageNamed: "fly03"),
                                     SKTexture(imageNamed: "fly04"),
                                     SKTexture(imageNamed: "fly05"),
                                     SKTexture(imageNamed: "fly06"),
                                     SKTexture(imageNamed: "fly07")
    ]
    let biancaAttack: [SKTexture] = [SKTexture(imageNamed: "BiancaAttack1"),
                                     SKTexture(imageNamed: "BiancaAttack2"),
                                     SKTexture(imageNamed: "BiancaAttack3"),
                                     SKTexture(imageNamed: "BiancaAttack4"),
                                     SKTexture(imageNamed: "BiancaAttack5"),
                                   SKTexture(imageNamed: "BiancaAttack6")
    ]
}

struct drag {
    var id: UUID = UUID()
    var name: String
    var image: String
    var superPower: String
}

struct dragGif {
    var image: String
}

class Drags {
    let dragS =         [drag(name: "Bianca", image: "Bianca1", superPower: "Twist"),
                         drag(name: "Laganja", image: "Laganja1", superPower: "Lacca"),
                         drag(name: "Bianca3", image: "Bianca3", superPower: "Wings"),
                         drag(name: "Bianca4", image: "Bianca4", superPower: "No one")
    ]
    
    let biancaGif = [dragGif(image: "Bianca1"),
                     dragGif(image: "Bianca2"),
                     dragGif(image: "Bianca3"),
                     dragGif(image: "Bianca4"),
                     dragGif(image: "Bianca5")]
}
