//
//  StandardEthogram.swift
//  YoungAnimalDetectives
//
//  Created by Li Jia'En, Nicholette on 18/4/15.
//  Copyright (c) 2015 Li Jia'En, Nicholette. All rights reserved.
//

import Foundation

/// This class creates a standard ethogram.
class StandardEthogram {
    
    class func getEthogram() -> Ethogram {
        let movingBS = BehaviourState(name: "Moving", information:
                            "Moving in a specific direction with an aim")
        let groomingBS = BehaviourState(name: "Grooming", information:
                            "Animal cleaning, licking or stroking itself")
        let ingestingBS = BehaviourState(name: "Eating/Drinking", information:
                            "Animal ingesting objects or liquids")
        let restingBS = BehaviourState(name: "Resting", information:
                            "Animal lying or sitting, eyes opened or closed")
        let notVisibleBS = BehaviourState(name: "Not Visible", information:
                            "Animal in a visually inaccessible location")
        
        var ethogram = Ethogram(name: "Animal")
        ethogram.addBehaviourState(movingBS)
        ethogram.addBehaviourState(groomingBS)
        ethogram.addBehaviourState(ingestingBS)
        ethogram.addBehaviourState(restingBS)
        ethogram.addBehaviourState(notVisibleBS)
        
        return ethogram
    }
    
}