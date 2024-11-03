
//
//
//  Created by Ahlam Majed on 23/10/2024.
//

// this UI  for desing

import SwiftUI

struct PlantRow: View {
    @Binding var plant: Plant
    @State private var showReminderDel = false // Controls when to show PlantForm
    @Binding var isChecked: Bool
    var onCheckedChange: (Bool) -> Void
    var onDelete: (() -> Void)?
    
    let customColor = Color(UIColor(red: 40.0 / 255.0, green: 224.0 / 255.0, blue: 168.0 / 255.0, alpha: 1.0)) // Custom color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top) {
                
                // Check icon Button - Toggle checked state
                Button(action: {
                    isChecked.toggle()
                    onCheckedChange(isChecked)
                }) {
                    Image(systemName: isChecked ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(isChecked ? customColor : .gray)
                        .font(.system(size: 25))
                        .frame(width: 30, height: 30) // Keeps the button constrained to a circle shape
                }
                .buttonStyle(PlainButtonStyle())
                
                VStack(alignment: .leading, spacing: 4) {
                    // Room and Location
                    HStack {
                        Image(systemName: "location")
                            .font(.system(size: 15))
                            .foregroundColor(.gray)
                        
                        Text("in \(plant.room)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    // Plant Name (tap to show PlantForm)
                    Text(plant.name)
                        .font(.title2)
                        .bold()
                        .foregroundColor(isChecked ? .gray : .white)
                        .onTapGesture {
                            showReminderDel.toggle() // Show sheet when tapped
                        }
                    
                    // Light and Water Requirements
                    HStack(spacing: 10) {
                        // Light Condition
                        HStack {
                            Image(systemName: plant.light.image)
                                .foregroundColor(Color(UIColor(red: 204.0 / 255.0, green: 199.0 / 255.0, blue: 133.0 / 255.0, alpha: 1)))
                            
                            Text(plant.light.name)
                                .font(.subheadline)
                                .foregroundColor(Color(UIColor(red: 204.0 / 255.0, green: 199.0 / 255.0, blue: 133.0 / 255.0, alpha: 1)))
                        }
                        .padding(5)
                        .background(Color(UIColor(red: 24.0 / 255.0, green: 24.0 / 255.0, blue: 29.0 / 255.0, alpha: 1)))
                        .cornerRadius(5)
                        
                        // Water Requirement
                        HStack {
                            Image(systemName: "drop")
                                .foregroundColor(Color(UIColor(red: 202.0 / 255.0, green: 243.0 / 255.0, blue: 251.0 / 255.0, alpha: 1)))
                            
                            Text(plant.water)
                                .font(.subheadline)
                                .foregroundColor(Color(UIColor(red: 202.0 / 255.0, green: 243.0 / 255.0, blue: 251.0 / 255.0, alpha: 1)))
                        }
                        .padding(5)
                        .background(Color(UIColor(red: 24.0 / 255.0, green: 24.0 / 255.0, blue: 29.0 / 255.0, alpha: 1)))
                        .cornerRadius(5)
                    }
                }
                
                Spacer()
            }
        }
        .padding(.vertical, 8)
        .sheet(isPresented: $showReminderDel) {
            NavigationView{
                PlantForm(
                    plantname: $plant.name,
                    selRoom: $plant.room,
                    selLight: $plant.light,
                    selWateringDays: .constant("Every day"),
                    water: .constant("50-100 ml"),
                    showDeleteButton: true,
                    onDelete: {
                        onDelete?()
                        showReminderDel = false
                    }
                )
                .navigationBarTitle("Set Reminder", displayMode: .inline)
                .navigationBarItems(
                    leading: Button(action: {
                        showReminderDel = false
                    }) {
                        Text("Cancel")
                            .foregroundColor(customColor)
                    },
                    trailing: Button(action: {
                        // Save any changes if needed
                        showReminderDel = false
                    }) {
                        Text("Save")
                            .foregroundColor(customColor)
                    }
                )
            }
        }
    }
}
