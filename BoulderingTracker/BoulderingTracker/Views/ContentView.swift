import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = BoulderViewModel()

    var body: some View {
        TabView {
            CalendarView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Calendar")
                }
            
            ListView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("All Climbs")
                }
        }
    }
}

struct ListView: View {
    @ObservedObject var viewModel: BoulderViewModel
    @State private var showingAddBoulderView = false

    var body: some View {
        NavigationView {
            VStack {
                // Statistics Section
                if !viewModel.boulders.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Total Climbs")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Text("\(viewModel.getTotalClimbs())")
                                    .font(.title2)
                                    .fontWeight(.bold)
                            }
                            Spacer()
                            VStack(alignment: .leading) {
                                Text("Highest Grade")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Text(viewModel.getHighestDifficulty() ?? "—")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.orange)
                            }
                            Spacer()
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    }
                    .padding()
                }
                
                // Boulder List
                if viewModel.boulders.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "mountain.2")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                        Text("No Boulders Yet")
                            .font(.headline)
                        Text("Add your first boulder climb!")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(.systemBackground))
                } else {
                    List {
                        ForEach(viewModel.getBoulders()) { boulder in
                            HStack(spacing: 12) {
                                VStack(alignment: .leading, spacing: 4) {
                                    HStack {
                                        Text(boulder.name)
                                            .fontWeight(.semibold)
                                        Spacer()
                                        Text(boulder.difficulty)
                                            .font(.headline)
                                            .foregroundColor(.orange)
                                    }
                                    Text(formattedDate(boulder.date))
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                
                                if let photoData = boulder.photoData, let uiImage = UIImage(data: photoData) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 60, height: 60)
                                        .clipped()
                                        .cornerRadius(4)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                        .onDelete { indexSet in
                            indexSet.forEach { index in
                                viewModel.removeBoulder(at: index)
                            }
                        }
                    }
                }
            }
            .navigationTitle("All Climbs")
            .navigationBarItems(trailing: Button(action: {
                showingAddBoulderView = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showingAddBoulderView) {
                AddBoulderView(viewModel: viewModel, isPresented: $showingAddBoulderView)
            }
        }
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
