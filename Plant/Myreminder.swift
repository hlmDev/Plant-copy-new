import SwiftUI

struct Myreminder: View {
    @Binding var plants: [Plant]
    @State private var showReminderSheet = false
    @State private var navigateToDone = false
    @State private var plantToDeleteID: UUID? // Deletion flag
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Today")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.top, 10)
                    .padding(.horizontal)
                
                if plants.allSatisfy({ $0.isChecked }) {
                    NavigationLink(destination: Done(), isActive: $navigateToDone) {
                        EmptyView()
                    }
                    .hidden()
                    .onAppear {
                        navigateToDone = true
                    }
                }
                
                List {
                    ForEach($plants, id: \.id) { $plant in
                        PlantRow(
                            plant: $plant,
                            isChecked: $plant.isChecked,
                            onCheckedChange: { isChecked in
                                plant.isChecked = isChecked
                            },
                            onDelete: {
                                plantToDeleteID = plant.id
                            }
                        )
                        .listRowBackground(Color.black)
                        .listRowInsets(EdgeInsets())
                    }
                    .onDelete(perform: deletePlant)
                }
                .frame(maxWidth: .infinity)
                .scrollContentBackground(.hidden)
                .background(Color.black)
                .listStyle(PlainListStyle())
                .onChange(of: plantToDeleteID) { id in
                    if let id = id {
                        if let index = plants.firstIndex(where: { $0.id == id }) {
                            plants.remove(at: index)
                        }
                        plantToDeleteID = nil
                    }
                }
                
                // Button for adding a new reminder
                HStack {
                    Button(action: {
                        showReminderSheet = true
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 24))
                            Text("New Reminder")
                                .font(.system(size: 18))
                        }
                        .foregroundColor(Color(UIColor(red: 40.0 / 255.0, green: 224.0 / 255.0, blue: 168.0 / 255.0, alpha: 1)))
                    }
                    .padding(.leading, 20)
                    .padding(.vertical, 40)
                    
                    Spacer()
                }
                .padding()
                .navigationTitle("My Plants 🌱")
                .sheet(isPresented: $showReminderSheet) {
                    ReminderView { newPlant in
                        plants.append(newPlant)
                        showReminderSheet = false
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
    
    
    private func deletePlant(at offsets: IndexSet) {
        plants.remove(atOffsets: offsets)
    }
    
    
}
