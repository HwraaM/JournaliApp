import SwiftUI

enum SortOption {
    case all
    case bookmarked
    case date
}

struct JournalListView: View {
    @Binding var journals: [JournalItem]
    @Binding var searchText: String
    @Binding var showAddSheet: Bool
    @Binding var selectedSort: SortOption

    var filteredAndSortedJournals: [JournalItem] {
        var list = journals
        
        if !searchText.isEmpty {
            list = list.filter { $0.title.localizedCaseInsensitiveContains(searchText) || $0.content.localizedCaseInsensitiveContains(searchText) }
        }
        
        switch selectedSort {
        case .bookmarked:
            return list.filter { $0.isBookmarked }
        case .date:
            return list.sorted { $0.createdDate > $1.createdDate }
        case .all:
            return list
        }
    }

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // الهيدر العلوي
                HStack {
                    Text("Journal")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    HStack(spacing: 16) {
                        Menu {
                            Button("Show All") { selectedSort = .all }
                            Button("Bookmarked Only") { selectedSort = .bookmarked }
                            Button("Sort by Date") { selectedSort = .date }
                        } label: {
                            Image(systemName: "line.3.horizontal")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.white)
                        }
                        
                        Button(action: { showAddSheet = true }) {
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
                
                // قائمة اليوميات والبطاقات
                List {
                    ForEach(filteredAndSortedJournals) { journal in
                        if let index = journals.firstIndex(where: { $0.id == journal.id }) {
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    Text(journals[index].title)
                                        .font(.system(size: 22, weight: .semibold))
                                        .foregroundColor(Color(red: 0.7, green: 0.6, blue: 0.9))
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        journals[index].isBookmarked.toggle()
                                    }) {
                                        Image(systemName: journals[index].isBookmarked ? "bookmark.fill" : "bookmark")
                                            .foregroundColor(Color(red: 0.7, green: 0.6, blue: 0.9))
                                            .font(.system(size: 18))
                                    }
                                }
                                
                                Text(journals[index].date)
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                                
                                Text(journals[index].content)
                                    .font(.system(size: 15))
                                    .foregroundColor(.white.opacity(0.9))
                                    .lineLimit(4)
                            }
                            .padding(20)
                            .background(Color(red: 0.12, green: 0.12, blue: 0.14))
                            .cornerRadius(22)
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                        }
                    }
                    .onDelete { indexSet in
                        journals.remove(atOffsets: indexSet)
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
            
            // شريط البحث السفلي
            VStack {
                Spacer()
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    
                    TextField("Search", text: $searchText)
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
    }
}
