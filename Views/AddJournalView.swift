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
            // الخلفية السوداء الأساسية للصفحة
            Color.black
                .ignoresSafeArea()
            
            // المحتوى الأساسي للصفحة
            VStack(spacing: 0) {
                // شريط الأزرار العلوية
                HStack {
                    Button(action: {
                        if !title.trimmingCharacters(in: .whitespaces).isEmpty ||
                            !content.trimmingCharacters(in: .whitespaces).isEmpty {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                showDiscardAlert = true
                            }
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
                        ZStack(alignment: .leading) {
                            if title.isEmpty {
                                Text("Title")
                                    .font(.system(size: 32, weight: .bold))
                                    .foregroundColor(.secondary.opacity(0.6))
                            }
                            TextField("", text: $title)
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .padding(.top, 10)
                        
                        Text(journalDate.formatted(date: .numeric, time: .omitted))
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                        
                        ZStack(alignment: .topLeading) {
                            if content.isEmpty {
                                Text("Type your Journal...")
                                    .font(.system(size: 16))
                                    .foregroundColor(.secondary.opacity(0.6))
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
            .blur(radius: showDiscardAlert ? 1.5 : 0)
            .disabled(showDiscardAlert)

            // النافذة المنبثقة بالستايل الزجاجي المطابق للصورة تماماً وفي زاوية الشاشة اليسارية
            if showDiscardAlert {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.spring()) {
                            showDiscardAlert = false
                        }
                    }

                VStack {
                    HStack {
                        VStack(alignment: .center, spacing: 14) {
                            // النص التوضيحي في الأعلى
                            Text("Are you sure you want to discard changes on this journal?")
                                .font(.system(size: 13, weight: .regular))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 4)

                            // الزر الأول: Discard Changes بخلفية زجاجية وكتابة حمراء
                            Button(action: {
                                showDiscardAlert = false
                                dismiss()
                            }) {
                                Text("Discard Changes")
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundColor(.red)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 12)
                                    .background(.ultraThinMaterial)
                                    .cornerRadius(14)
                            }

                            // الزر الثاني: Keep Editing تحته بخلفية زجاجية وكتابة بيضاء
                            Button(action: {
                                withAnimation(.spring()) {
                                    showDiscardAlert = false
                                }
                            }) {
                                Text("Keep Editing")
                                    .font(.system(size: 15, weight: .regular))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 12)
                                    .background(.ultraThinMaterial)
                                    .cornerRadius(14)
                            }
                        }
                        .padding(16)
                        .frame(width: 280)
                        // خلفية الحاوية العامة بالشفافية والزجاج (Liquid Glass)
                        .background(.ultraThinMaterial)
                        .cornerRadius(24)
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(Color.white.opacity(0.15), lineWidth: 0.5)
                        )
                        .shadow(color: Color.black.opacity(0.5), radius: 20, x: 0, y: 10)
                        .padding(.leading, 15)
                        .padding(.top, 60) //توضع بقرب الزاوية اليسارية العلوية

                        Spacer()
                    }
                    Spacer()
                }
                .transition(.scale(scale: 0.9, anchor: .topLeading).combined(with: .opacity))
            }
        }
    }
}

struct AddJournalView_Previews: PreviewProvider {
    static var previews: some View {
        AddJournalView(onSave: { _ in })
    }
}
