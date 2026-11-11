import SwiftUI

struct AddJournalView: View {
    @Environment(\.dismiss) var dismiss
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var journalDate: Date = Date()
    
    var onSave: (JournalItem) -> Void

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 20) {
                    TextField("Journal Title", text: $title)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.top, 10)
                    
                    Text(journalDate.formatted(date: .numeric, time: .omitted))
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    
                    TextEditor(text: $content)
                        .font(.system(size: 16))
                        .scrollContentBackground(.hidden)
                        .foregroundColor(.white)
                        .background(Color.clear)
                    
                    Spacer()
                }
                .padding(20)
            }
            .navigationTitle("New Journal")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                        .foregroundColor(.gray)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                        let formatter = DateFormatter()
                        formatter.dateFormat = "dd/MM/yyyy"
                        let dateString = formatter.string(from: journalDate)
                        
                        let newEntry = JournalItem(
                            title: title.isEmpty ? "Untitled" : title,
                            date: dateString,
                            content: content,
                            isBookmarked: false
                        )
                        onSave(newEntry)
                        dismiss()
                    }) {
                        Image(systemName: "checkmark")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(Color(red: 0.7, green: 0.6, blue: 0.9))
                    }
                }
            }
        }
    }
}
