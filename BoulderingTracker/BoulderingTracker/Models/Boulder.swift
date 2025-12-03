import Foundation

struct Boulder: Identifiable, Codable {
    let id: UUID
    var name: String
    var difficulty: String
    var date: Date
    
    init(name: String, difficulty: String, date: Date = Date()) {
        self.id = UUID()
        self.name = name
        self.difficulty = difficulty
        self.date = date
    }
}
