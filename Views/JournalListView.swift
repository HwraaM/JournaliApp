import SwiftUI

struct JournalListView: View {
    // ربط كلاس الـ ViewModel للحصول على البيانات وتحديثها
    @ObservedObject var viewModel: JournalViewModel

    var body: some View {
        ZStack {
            // خلفية سوداء للشاشة
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // ترويسة التطبيق (العنوان، قائمة الفلتر، وزر الإضافة)
                HStack {
                    Text("Journal")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    HStack(spacing: 16) {
                        // قائمة منسدلة للفلترة بأيقونة أبل القياسية المتدرجة
                        Menu {
                            Button("Show All") { viewModel.selectedSort = .all }
                            Button("Bookmarked Only") { viewModel.selectedSort = .bookmarked }
                            Button("Sort by Date") { viewModel.selectedSort = .date }
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.white)
                        }
                        
                        // زر إضافة يومية جديدة
                        Button(action: { viewModel.showAddSheet = true }) {
                            Image(systemName: "plus")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal, 18)
                    .padding(.vertical, 10)
                    .background(Color(red: 0.14, green: 0.14, blue: 0.15))
                    .clipShape(Capsule())
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                
                // قائمة عرض البطاقات المصفاة
                List {
                    ForEach(viewModel.filteredAndSortedJournals) { journal in
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                // عنوان اليومية
                                Text(journal.title)
                                    .font(.system(size: 22, weight: .semibold))
                                    .foregroundColor(Color(red: 0.7, green: 0.6, blue: 0.9))
                                
                                Spacer()
                                
                                // زر حفظ البطاقة (Bookmark)
                                Button(action: {
                                    viewModel.toggleBookmark(for: journal)
                                }) {
                                    Image(systemName: journal.isBookmarked ? "bookmark.fill" : "bookmark")
                                        .foregroundColor(Color(red: 0.7, green: 0.6, blue: 0.9))
                                        .font(.system(size: 18))
                                }
                                .buttonStyle(.plain)
                            }
                            
                            // تاريخ اليومية
                            Text(journal.date)
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                            
                            // محتوى اليومية
                            Text(journal.content)
                                .font(.system(size: 15))
                                .foregroundColor(.white.opacity(0.9))
                                .lineLimit(4)
                        }
                        .padding(20)
                        .background(Color(red: 0.12, green: 0.12, blue: 0.14))
                        .cornerRadius(22)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        // خاصية السحب للحذف وإظهار أيقونة سلة المهملات
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                viewModel.journalToDelete = journal
                                viewModel.showDeleteAlert = true
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .safeAreaInset(edge: .bottom) {
                    Color.clear.frame(height: 80)
                }
            }
            
            // شريط البحث السفلي الثابت
            VStack {
                Spacer()
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    
                    TextField("Search", text: $viewModel.searchText)
                        .foregroundColor(.white)
                    
                    Image(systemName: "mic.fill")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color(red: 0.14, green: 0.14, blue: 0.15))
                .clipShape(Capsule())
                .padding(.horizontal, 20)
                .padding(.bottom, 15)
            }
        }
        // نافذة التنبيه (Alert) لتأكيد الحذف باستخدام Optional بأمان
        .alert("Delete Journal?", isPresented: $viewModel.showDeleteAlert) {
            Button("Cancel", role: .cancel) {
                viewModel.journalToDelete = nil
            }
            Button("Delete", role: .destructive) {
                if let itemToDelete = viewModel.journalToDelete {
                    viewModel.deleteJournal(itemToDelete)
                }
                viewModel.journalToDelete = nil
            }
        } message: {
            Text("Are you sure you want to delete this journal?")
        }
    }
}

