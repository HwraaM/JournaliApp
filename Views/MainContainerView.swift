import SwiftUI

struct MainContainerView: View {
    @State private var showSplash = true
    @State private var journals: [JournalItem] = [
        JournalItem(title: "My Birthday", date: "02/09/2024", content: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio.", isBookmarked: true, createdDate: Date()),
        JournalItem(title: "Today's Journal", date: "02/09/2024", content: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit.", isBookmarked: false, createdDate: Date().addingTimeInterval(-86400)),
        JournalItem(title: "Great Day", date: "02/09/2024", content: "Lorem ipsum dolor sit amet, consectetuer.", isBookmarked: false, createdDate: Date().addingTimeInterval(-172800))
    ]
    @State private var searchText = ""
    @State private var showAddSheet = false
    @State private var selectedSort: SortOption = .all

    var body: some View {
        ZStack {
            if showSplash {
                SplashView()
                    .transition(.opacity)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            withAnimation {
                                showSplash = false
                            }
                        }
                    }
            } else {
                NavigationStack {
                    JournalListView(
                        journals: $journals,
                        searchText: $searchText,
                        showAddSheet: $showAddSheet,
                        selectedSort: $selectedSort
                    )
                    .sheet(isPresented: $showAddSheet) {
                        AddJournalView { newJournal in
                            journals.insert(newJournal, at: 0)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    MainContainerView()
}
