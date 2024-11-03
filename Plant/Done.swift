//
//  ContentView.swift
//  Plant
//
//  Created by Ahlam Majed on 20/10/2024.
//

import SwiftUI

struct Done: View {
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white] // Color text
        UINavigationBar.appearance().backgroundColor = .clear // Set background to clear
        UINavigationBar.appearance().isTranslucent = false // Ignore divider color
    }
    @State private var navigateToMyReminder = false
    @StateObject private var plantModel = PlantModel() 
    @State  var showReminderSheet = false
    //@State private var navigateToDetail = false
    
    var body: some View {
        NavigationStack {
            VStack {
                // Divider under the title
                Divider()
                    .background(Color.gray)
                    .padding(.top, 5) // Space between the line and title text
                
                Spacer()
                
                // Plant Image and the circle behind the image
                ZStack {
                    Image("picdone")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 219, height: 227)
                }
                .padding(.bottom, 20)
                
                // Text content
                Text("All Done! 🎉")
                    .font(.system(size: 25))
                    .bold()
                    .padding(.vertical, 5)
                    .foregroundColor(Color(UIColor(red: 234.0 / 255.0, green: 234.0 / 255.0, blue: 215.0 / 255.0, alpha: 1))) // Color from sketch
                
                Text("All Reminders Completed")
                    .font(.system(size: 16))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 20)
                
                Spacer()
                
                // New Reminder button at the left with plus icons
                HStack {
                    Button(action: {
                        // Action for adding a new reminder
                        showReminderSheet = true
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            //.frame(width: 24, height: 29)
                                .font(.system(size: 24))
                            Text("New Reminder")
                                .font(.system(size: 18))
                        }
                        .foregroundColor(Color(UIColor(red: 40.0 / 255.0, green: 224.0 / 255.0, blue: 168.0 / 255.0, alpha: 1)))
                    }
                    .padding(.leading, 20)
                    
                    Spacer() // Push the button to the left
                }
                .padding(.bottom, 40)
                .padding(.vertical,40)// Adjust the padding to move the button up if needed
                
               
            }
            .navigationTitle("My Plants 🌱")
            .sheet(isPresented: $showReminderSheet) {
                                ReminderView { newPlant in
                                    plantModel.plants.append(newPlant) // Append the new plant to the shared model
                                    showReminderSheet = false
                                    navigateToMyReminder = true
                                }
                            }
            
            NavigationLink(destination: Myreminder(plants: $plantModel.plants), isActive: $navigateToMyReminder) {
                               EmptyView()
                           }
            .navigationBarBackButtonHidden(true)// hide the button bar
                    }
                 }
            }
   //     }
  //  }

#Preview {
    Done()
        .preferredColorScheme(.dark)
}
