//
//  JournalViewModel.swift
//  MyApp
//
//  Created by HAWRA12 on 02/06/1448 AH.
//

import SwiftUI
import Combine

class JournalViewModel: ObservableObject {
    @Published var journals: [JournalItem] = [
        JournalItem(
            title: "My Birthday",
            date: "02/09/2024",
            content: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros. Nullam malesuada erat ut turpis.",
            isBookmarked: true,
            createdDate: Date()
        ),
        JournalItem(
            title: "Today's Journal",
            date: "02/09/2024",
            content: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio. Quisque volutpat mattis eros.",
            isBookmarked: false,
            createdDate: Date().addingTimeInterval(-86400)
        ),
        JournalItem(
            title: "Great Day",
            date: "02/09/2024",
            content: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec odio.",
            isBookmarked: false,
            createdDate: Date().addingTimeInterval(-172800)
        )
    ]
    
    @Published var searchText: String = ""
    @Published var showAddSheet: Bool = false
    @Published var selectedSort: SortOption = .entryDate
    
    @Published var journalToDelete: JournalItem? = nil
    @Published var showDeleteAlert: Bool = false

    // ==========================================
    // الدوال الأساسية للـ ViewModel
    // ==========================================
    func addJournal(_ item: JournalItem) {
        journals.insert(item, at: 0)
    }

    func deleteJournal(_ item: JournalItem) {
        if let index = journals.firstIndex(where: { $0.id == item.id }) {
            journals.remove(at: index)
        }
    }

    func toggleBookmark(for item: JournalItem) {
        if let index = journals.firstIndex(where: { $0.id == item.id }) {
            journals[index].isBookmarked.toggle()
        }
    }

    // منطق الفلترة والترتيب بالخيارين الجديدين
    var filteredAndSortedJournals: [JournalItem] {
        var list = journals
         
        if !searchText.isEmpty {
            list = list.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.content.localizedCaseInsensitiveContains(searchText)
            }
        }
         
        switch selectedSort {
        case .entryDate:
            // الترتيب حسب تاريخ الإدخال والأحدث أولاً
            return list.sorted { $0.createdDate > $1.createdDate }
        case .bookmark:
            // إظهار المحفوظة فقط
            return list.filter { $0.isBookmarked }
        }
    }
}

// خيارات الفلتر والترتيب المطلوبة
enum SortOption {
    case entryDate
    case bookmark
}
