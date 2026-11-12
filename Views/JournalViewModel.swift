//
//  JournalViewModel.swift
//  MyApp
//
//  Created by HAWRA12 on 02/06/1448 AH.
//

import SwiftUI
import Combine

// كلاس إدارة بيانات اليوميات والعمليات عليها وفق نمط MVVM
class JournalViewModel: ObservableObject {
    // مصفوفة اليوميات التي يتم مراقبة تحديثاتها تلقائياً من قبل الواجهة
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
    
    // نص البحث الحالي
    @Published var searchText: String = ""
    // حالة إظهار شاشة الإضافة
    @Published var showAddSheet: Bool = false
    // خيار الفلترة والترتيب الحالي
    @Published var selectedSort: SortOption = .all
    
    // متغير اختياري (Optional) لتخزين اليومية المراد حذفها وعرض تنبيه التأكيد لها بأمان
    @Published var journalToDelete: JournalItem? = nil
    @Published var showDeleteAlert: Bool = false

    // دالة لإضافة يومية جديدة في قمة القائمة
    func addJournal(_ item: JournalItem) {
        journals.insert(item, at: 0)
    }

    // دالة آمنة لحذف يومية محددة
    func deleteJournal(_ item: JournalItem) {
        if let index = journals.firstIndex(where: { $0.id == item.id }) {
            journals.remove(at: index)
        }
    }

    // دالة تبديل حالة الحفظ (Bookmark) باستخدام Optional للتحقق من الفهارس
    func toggleBookmark(for item: JournalItem) {
        if let index = journals.firstIndex(where: { $0.id == item.id }) {
            journals[index].isBookmarked.toggle()
        }
    }

    // مصفوفة محسوبة (Computed Property) لتصفية وترتيب اليوميات حسب البحث والفلتر
    var filteredAndSortedJournals: [JournalItem] {
        var list = journals
        
        // تصفية النتائج بناءً على نص البحث (إذا لم يكن فارغاً)
        if !searchText.isEmpty {
            list = list.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.content.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        // تطبيق خيارات الفلترة المحددة
        switch selectedSort {
        case .bookmarked:
            return list.filter { $0.isBookmarked }
        case .date:
            return list.sorted { $0.createdDate > $1.createdDate }
        case .all:
            return list
        }
    }
}

// خيارات الفلترة والترتيب
enum SortOption {
    case all
    case bookmarked
    case date
}
