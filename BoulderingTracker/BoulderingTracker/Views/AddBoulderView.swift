import SwiftUI

struct AddBoulderView: View {
    @ObservedObject var viewModel: BoulderViewModel
    @Binding var isPresented: Bool
    
    @State private var boulderName: String = ""
    @State private var selectedDifficulty: String = "4A"
    @State private var selectedDate: Date
    
    let difficulties = ["4A", "4B", "4C", "5A", "5B", "5C", "6A","6A+", "6B","6B+", "6C","6C+", "7A", "7B", "7C", "8A", "8A+", "8B", "8B+", "8C", "8C+", "9A"]
    
    init(viewModel: BoulderViewModel, isPresented: Binding<Bool>, preselectedDate: Date = Date()) {
        self.viewModel = viewModel
        self._isPresented = isPresented
        self._selectedDate = State(initialValue: preselectedDate)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Date")) {
                    DatePicker("Session Date", selection: $selectedDate, displayedComponents: [.date])
                }
                
                Section(header: Text("Boulder Details")) {
                    TextField("Boulder's Name", text: $boulderName)
                        .placeholder(when: boulderName.isEmpty) {
                            Text("e.g., The Crimper, Slopers #3").foregroundColor(.gray)
                        }
                    
                    Picker("Difficulty Level", selection: $selectedDifficulty) {
                        ForEach(difficulties, id: \.self) { difficulty in
                            Text(difficulty).tag(difficulty)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section {
                    Button(action: {
                        if !boulderName.trimmingCharacters(in: .whitespaces).isEmpty {
                            viewModel.addBoulder(name: boulderName, difficulty: selectedDifficulty, date: selectedDate)
                            isPresented = false
                        }
                    }) {
                        HStack {
                            Spacer()
                            Text("Add Boulder")
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        .foregroundColor(.white)
                    }
                    .listRowBackground(Color.orange)
                    .disabled(boulderName.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
            .navigationTitle("Add Boulder")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

extension View {
    func placeholder<Content: View>(when shouldShow: Bool, alignment: Alignment = .leading, @ViewBuilder placeholder: () -> Content) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

struct AddBoulderView_Previews: PreviewProvider {
    static var previews: some View {
        AddBoulderView(viewModel: BoulderViewModel(), isPresented: .constant(true))
    }
}
