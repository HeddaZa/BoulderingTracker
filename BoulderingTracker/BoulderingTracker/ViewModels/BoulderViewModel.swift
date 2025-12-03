import Foundation
import Combine

class BoulderViewModel: ObservableObject {
    @Published var boulders: [Boulder] = []
    
    private let saveKey = "SavedBoulders"
    
    init() {
        loadBoulders()
    }
    
    // MARK: - CRUD Operations
    func addBoulder(name: String, difficulty: String, date: Date = Date(), photoData: Data? = nil) {
        let newBoulder = Boulder(name: name, difficulty: difficulty, date: date, photoData: photoData)
        boulders.append(newBoulder)
        saveBoulders()
    }
    
    func removeBoulder(at index: Int) {
        guard index >= 0 && index < boulders.count else { return }
        boulders.remove(at: index)
        saveBoulders()
    }
    
    func removeBoulder(_ boulder: Boulder) {
        boulders.removeAll { $0.id == boulder.id }
        saveBoulders()
    }
    
    func getBoulders() -> [Boulder] {
        return boulders.sorted { $0.date > $1.date }
    }
    
    func getBoulders(for date: Date) -> [Boulder] {
        let calendar = Calendar.current
        return boulders.filter { boulder in
            calendar.isDate(boulder.date, inSameDayAs: date)
        }.sorted { $0.date > $1.date }
    }
    
    // MARK: - Persistence
    private func saveBoulders() {
        if let encoded = try? JSONEncoder().encode(boulders) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    private func loadBoulders() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let decoded = try? JSONDecoder().decode([Boulder].self, from: data) {
            self.boulders = decoded
        }
    }
    
    // MARK: - Statistics
    func getHighestDifficulty() -> String? {
        let difficultyOrder = ["4A", "4B", "4C", "5A", "5B", "5C", "6A","6A+", "6B","6B+", "6C","6C+", "7A", "7B", "7C", "8A", "8A+", "8B", "8B+", "8C", "8C+", "9A"]
        let difficulties = Set(boulders.map { $0.difficulty })
        return difficulties.max { a, b in
            let indexA = difficultyOrder.firstIndex(of: a) ?? -1
            let indexB = difficultyOrder.firstIndex(of: b) ?? -1
            return indexA < indexB
        }
    }
    
    func getTotalClimbs() -> Int {
        return boulders.count
    }
    
    func getClimbsPerDifficulty() -> [String: Int] {
        var counts: [String: Int] = [:]
        for boulder in boulders {
            counts[boulder.difficulty, default: 0] += 1
        }
        return counts
    }
}
