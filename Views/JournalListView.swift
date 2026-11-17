import SwiftUI

struct JournalListView: View {
    @ObservedObject var viewModel: JournalViewModel

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
             
            VStack(spacing: 0) {
                // ترويسة التطبيق (مع تطبيق Liquid Glass)
                HStack {
                    Text("Journal")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.white)
                     
                    Spacer()
                     
                    HStack(spacing: 16) {
                        Menu {
                            Button("Sort by Entry Date") { viewModel.selectedSort = .entryDate }
                            Button("Sort by Bookmark") { viewModel.selectedSort = .bookmark }
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.white)
                        }
                         
                        Button(action: { viewModel.showAddSheet = true }) {
                            Image(systemName: "plus")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal, 18)
                    .padding(.vertical, 10)
                    .background(.ultraThinMaterial) // تطبيق Liquid Glass
                    .clipShape(Capsule())
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                 
                // قائمة العرض
                List {
                    ForEach(viewModel.filteredAndSortedJournals) { journal in
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text(journal.title)
                                    .font(.system(size: 22, weight: .semibold))
                                    .foregroundColor(journal.isBookmarked ? Color(red: 0.85, green: 0.75, blue: 1.0) : Color(red: 0.7, green: 0.6, blue: 0.9))
                                 
                                Spacer()
                                 
                                Button(action: {
                                    viewModel.toggleBookmark(for: journal)
                                }) {
                                    Image(systemName: journal.isBookmarked ? "bookmark.fill" : "bookmark")
                                        .foregroundColor(Color(red: 0.7, green: 0.6, blue: 0.9))
                                        .font(.system(size: 18))
                                }
                                .buttonStyle(.plain)
                            }
                           
                            Text(journal.date)
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                           
                            Text(journal.content)
                                .font(.system(size: 15))
                                .foregroundColor(.white.opacity(0.9))
                                .lineLimit(4)
                                .multilineTextAlignment(.leading)
                        }
                        .padding(20)
                        .background(Color(red: 0.12, green: 0.12, blue: 0.14))
                        .cornerRadius(22)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                viewModel.journalToDelete = journal
                                viewModel.showDeleteAlert = true
                            } label: {
                                Image(systemName: "trash")
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .scrollDismissesKeyboard(.interactively)
                .safeAreaInset(edge: .bottom) {
                    Color.clear.frame(height: 80)
                }
            }
             
            // شريط البحث السفلي (مع Liquid Glass وأيقونة المايك الشكل الثابت)
            VStack {
                Spacer()
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                     
                    TextField("Search", text: $viewModel.searchText)
                        .foregroundColor(.white)
                    
                    Button(action: {}) {
                        Image(systemName: "mic.fill")
                            .foregroundColor(.gray.opacity(0.6))
                    }
                }
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(Capsule())
                .padding(.horizontal, 20)
                .padding(.bottom, 15)
            }
        }
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

struct JournalListView_Previews: PreviewProvider {
    static var previews: some View {
        JournalListView(viewModel: JournalViewModel())
    }
}
