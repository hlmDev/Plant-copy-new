//
//  ContentView.swift
//  Plant
//
//  Created by Ahlam Majed on 20/10/2024.
//

import SwiftUI

struct Mainpage: View {
    
    
    @State private var showReminderSheet = false // Tracks the sheet is displayed.
    @State private var navigateToMyReminder = false
    @StateObject private var plantModel = PlantModel() // plants is array and [Plant] is object
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]// color text
        UINavigationBar.appearance().backgroundColor = .clear// ignore the background maybe you can add clear or black
        UINavigationBar.appearance().isTranslucent = false //ignore the divider color
    }
    
    
    var body: some View {
        NavigationStack{
            VStack {
                //the line under
                Divider()
                    .background(Color.gray)
                    .padding(.top,5)// space between the line and title text
                Spacer()
                
                // Plant Image and the pic behind the image
                ZStack {
                    
                    Image("cyc")  //  image (cyc)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 219, height: 227)
                    
                    Image("plant")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 164, height: 200)
                }
                .padding(.bottom, 20)
                
                // contain
                Text("Start your plant journey!")
                    .font(.system(size: 25))
                    .bold()
                    .padding(.vertical, 5)
                    .foregroundColor(Color(UIColor(red: 234.0 / 255.0, green: 234.0 / 255.0, blue: 215.0 / 255.0, alpha: 1))) // color from sketch
                
                
                Text("Now all your plants will be in one place and we will help you take care of them :) 🪴")
                    .font(.system(size: 16))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 20)
                    .padding()
                //Spacer()
                
                //  List {
                //     ForEach(plants) { plant in
                //  PlantRow(plant: plant)
                //   .listRowBackground(Color.black)
                //                  }
                //        }
                
                // .frame(maxWidth: .infinity)
                // .scrollContentBackground(.hidden) // Hide default background
                // .background(Color.black) // Set custom background color
                //   .listStyle(PlainListStyle())
                
                
                // Button
                Button(action: {
                    showReminderSheet = true
                })
                {
                    Text("Set Plant Reminder")
                        .font(.system(size: 16))
                        .bold()
                        .foregroundColor(Color(UIColor(red: 28.0 / 255.0, green: 28.0 / 255.0, blue: 30.0 / 255.0, alpha: 1)))//text
                        .frame(width: 280, height: 40)
                        .background(Color(UIColor(red: 40.0 / 255.0, green: 224.0 / 255.0, blue: 168.0 / 255.0, alpha: 1))) // button
                        .cornerRadius(10) // Rounded corners
                        .padding(.horizontal, 40) // Padding from left and right
                    
                }
                .sheet(isPresented: $showReminderSheet) {
                                    ReminderView { newPlant in
                                        plantModel.plants.append(newPlant) // Append the new plant to the shared model
                                        showReminderSheet = false
                                        navigateToMyReminder = true
                                    }
                                }
                
                // NavigationLink to Myreminder.
                //NavigationLink(destination: Myreminder(plants: plants), isActive: $navigateToMyReminder) {
                  //  EmptyView()
                    
               // }
                //NavigationLink(destination: Myreminder(plants: plants), isActive: .constant(!plants.isEmpty) ) {
                                   // EmptyView()
                              //  }
                NavigationLink(destination: Myreminder(plants: $plantModel.plants), isActive: $navigateToMyReminder) {
                                   EmptyView()
                               }
                
                Spacer()
                Spacer()
            }
            
            // .background(Color.black) // Set the background color to black
            //  .edgesIgnoringSafeArea(.all)
            .navigationTitle("My Plants 🌱")
            
        }
        
    }
    
}
    
    #Preview {
        Mainpage()
            .preferredColorScheme(.dark)
    }
