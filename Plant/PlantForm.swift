//
//  PlantForm.swift
//  Plant
//
//  Created by Ahlam Majed on 27/10/2024.
//


// this class is for collect various attributes related to a plant
import SwiftUI


struct PlantForm: View {
    // Bindings to pass data between views
    //if use binding that mean we can change it  it's not local as @state
    // can access and modify the values
    @Binding var plantname: String
    @Binding var selRoom: String
    @Binding var selLight: LightCondition // selLight is an object of the LightCondition type
    @Binding var selWateringDays: String
    @Binding var water: String
    
    // Control delete button
        var showDeleteButton: Bool
        var onDelete: (() -> Void)?
    
    
    // Arrays for Picker
    let rooms = ["Bedroom", "Living Room", "Kitchen", "Balcony", "Bathroom"]
    // for images with in var seLight that contain LightCondition
    let lightConditions = [
        LightCondition(name: "Full sun", image: "sun.max"),
        LightCondition(name: "Partial Sun", image: "cloud.sun.fill"),
        LightCondition(name: "Low Light", image: "cloud.fill")
    ] // lightConditionsit's array of object "lightCondition what's in other class"
    let wateringDays = ["Every day", "Every 2 days", "Every 3 days", "Once a week", "Every 10 days", "Every 2 weeks"]
    let waterAmounts = ["20-50 ml", "50-100 ml", "100-200 ml", "200-300 ml"]

    var body: some View {
           Form {
               // Plant Name Section
               Section {
                   HStack {
                       Text("Plant name")
                       TextField("Pothos", text: $plantname)
                   }
               }
               
               // Room and Light Section
               // $ use this when we use the @binding and also when we want to change the var we use it in picker
               Section {
                   HStack {
                       Image(systemName: "location")
                       Picker("Room", selection: $selRoom) {
                           ForEach(rooms, id: \.self) { room in
                               Text(room) // hee room show the text what user pick "Closure"
                           }
                       }
                   }
                   
                   HStack {
                       Image(systemName: selLight.image)
                       Text("Light")
                       Spacer()
                       
                       Picker("", selection: $selLight) {
                           ForEach(lightConditions, id: \.self) { condition in
                               HStack {
                                   Image(systemName: condition.image)
                                   Text(condition.name)
                               }
                           }
                       }
                   }
               }
               
               // Watering Days and Water Section
               Section {
                   HStack {
                       Image(systemName: "drop")
                       Picker("Watering Days", selection: $selWateringDays) {
                           ForEach(wateringDays, id: \.self) { day in
                               Text(day)
                           }
                       }
                   }
                   
                   HStack {
                       Image(systemName: "drop")
                       Picker("Water", selection: $water) {
                           ForEach(waterAmounts, id: \.self) { amount in
                               Text(amount)
                           }
                       }
                   }
               }
               
               //  show Delete Button Section
               if showDeleteButton {
                   Section {
                       Button(action: {
                           onDelete?()
                       }) {
                           Text("Delete Reminder")
                               .foregroundColor(.red)
                               .font(.system(size: 16, weight: .bold))
                               .frame(maxWidth: .infinity, alignment: .center)
                               .padding(.vertical, 10)
                       }
                   }
               }
           }
       }
   }
