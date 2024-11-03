//
//
//  Created by Ahlam Majed on 20/10/2024.
//

import SwiftUI

struct ReminderView: View {
    
    @Environment(\.presentationMode) var presentationMode
    var onSave: (Plant) -> Void
    
    // Variables to hold form data
    @State var plantname = ""
    @State var selRoom = "Bedroom"
    @State var selLight: LightCondition = LightCondition(name: "Full sun", image: "sun.max")
    @State var selWateringDays = "Every day"
    @State var water = "20-50 ml"
        
    var body: some View {
        NavigationStack {
            //is a view instance
            PlantForm(
                plantname: $plantname,
                selRoom: $selRoom,
                selLight: $selLight,
                selWateringDays: $selWateringDays,
                water: $water,
                showDeleteButton: false // Don't show the delete button
            )
            .navigationBarTitle("Set Reminder", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                        .foregroundColor(Color(UIColor(red: 41.0 / 255.0, green: 223.0 / 255.0, blue: 168.0 / 255.0, alpha: 1)))
                },
                trailing: Button(action: {
                    savePlant()// call function
                }) {
                    Text("Save")
                        .foregroundColor(Color(UIColor(red: 41.0 / 255.0, green: 223.0 / 255.0, blue: 168.0 / 255.0, alpha: 1)))
                }
            )
          
        }
    }

    //save function
    func savePlant() {
        let newPlant = Plant(name: plantname, room: selRoom, light: selLight, water: water)
        onSave(newPlant) // add new plant back to Myreminder
        presentationMode.wrappedValue.dismiss() // Close  sheet after saving
       
    }
}


