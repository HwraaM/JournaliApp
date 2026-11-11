import Foundation

struct JournalItem: Identifiable {
    let id = UUID()
    var title: String
    var date: String
    var content: String
    var isBookmarked: Bool = false
    var createdDate: Date = Date()
}
