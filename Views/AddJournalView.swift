import SwiftUI

struct AddJournalView: View {
    // دالة لإغلاق النافذة
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var journalDate: Date = Date()
    @State private var showDiscardAlert: Bool = false
    
    var onSave: (JournalItem) -> Void

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // شريط الأزرار العلوية (X وزر الصح الدائري البنفسجي)
                HStack {
                    Button(action: {
                        if !title.trimmingCharacters(in: .whitespaces).isEmpty ||
                           !content.trimmingCharacters(in: .whitespaces).isEmpty {
                            showDiscardAlert = true
                        } else {
                            dismiss()
                        }
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .background(Color(red: 0.18, green: 0.18, blue: 0.20))
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    
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
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                            .frame(width: 44, height: 44)
                            .background(Color(red: 0.7, green: 0.6, blue: 0.9))
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 15)
                
                // محتوى صفحة الإضافة
                ScrollView {
                    VStack(alignment: .leading, spacing: 15) {
                        // حقل إدخال العنوان مع Placeholder مخصص
                        ZStack(alignment: .leading) {
                            if title.isEmpty {
                                Text("Title")
                                    .font(.system(size: 32, weight: .bold))
                                    .foregroundColor(Color.gray.opacity(0.5))
                            }
                            TextField("", text: $title)
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .padding(.top, 10)
                        
                        // عرض التاريخ
                        Text(journalDate.formatted(date: .numeric, time: .omitted))
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                        
                        // حقل إدخال المحتوى مع Placeholder مخصص
                        ZStack(alignment: .topLeading) {
                            if content.isEmpty {
                                Text("Type your Journal...")
                                    .font(.system(size: 16))
                                    .foregroundColor(Color.gray.opacity(0.5))
                                    .padding(.top, 8)
                            }
                            TextEditor(text: $content)
                                .font(.system(size: 16))
                                .scrollContentBackground(.hidden)
                                .foregroundColor(.white)
                                .frame(minHeight: 300)
                        }
                    }
                    .padding(20)
                }
                .scrollDismissesKeyboard(.interactively)
            }
        }
        .alert("Discard Changes?", isPresented: $showDiscardAlert) {
            Button("Keep Editing", role: .cancel) { }
            Button("Discard", role: .destructive) {
                dismiss()
            }
        } message: {
            Text("Are you sure you want to discard this journal entry?")
        }
    }
}


struct AddJournalView_Previews: PreviewProvider {
    static var previews: some View {
        AddJournalView(onSave: { _ in })
    }
}
