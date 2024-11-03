//
//  Plant.swift
//  Plant
//
//  Created by Ahlam Majed on 21/10/2024.
//

// this is data modling

import Foundation // need cuz we use UUID
import SwiftUI
import Combine
// is class
class PlantModel: ObservableObject {
    @Published var plants: [Plant] = []
    // @published automatically allow to update
}
// is struct
struct LightCondition: Hashable { // why Hashable sisnce this is group the best solution is this cuz
    //will save in collections like set
   // Properties
    var name: String
    var image: String  
}

struct Plant: Identifiable { // protocol i want to identify beteen the plant so i can add the id for each
    
    //Properties
    var id = UUID()
    var name: String
    var room: String
    var light: LightCondition
    var water: String
    var isChecked: Bool = false
  
    
   
}



