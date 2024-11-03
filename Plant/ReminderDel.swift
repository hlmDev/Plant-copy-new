import SwiftUI

struct ReminderDel: View {
    @Binding var plant: Plant
    @Environment(\.presentationMode) var presentationMode
    
    // Variables for form data
    @State var plantname = ""
    @State var selRoom = "Bedroom"
    @State var selLight = LightCondition(name: "Full sun", image: "sun.max")
    @State var selWateringDays = "Every day"
    @State var water = "20-50 ml"
    
    // Closure for handling deletion
    var onDelete: (() -> Void)?

    var body: some View {
        NavigationView {
            VStack {
                // PlantForm handles the form display and delete action
                PlantForm(
                    plantname: $plantname,
                    selRoom: $selRoom,
                    selLight: $selLight,
                    selWateringDays: $selWateringDays,
                    water: $water,
                    showDeleteButton: true,
                    onDelete: {
                        onDelete?() // Execute delete action
                        presentationMode.wrappedValue.dismiss() // Dismiss ReminderDel after deletion
                    }
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
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Save")
                            .foregroundColor(Color(UIColor(red: 41.0 / 255.0, green: 223.0 / 255.0, blue: 168.0 / 255.0, alpha: 1)))
                    }
                )
            }
        }
    }
}

    

//#Preview {
  //  ReminderDel()
      //  .preferredColorScheme(.dark)  // Switch to dark mode if you want to keep the dark theme
//}
