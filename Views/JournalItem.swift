import Foundation

// نموذج البيانات الخاص باليومية باستخدام Struct
struct JournalItem: Identifiable {
    // معرف فريد لكل يومية
    let id = UUID()
    // عنوان اليومية
    var title: String
    // تاريخ اليومية كنص
    var date: String
    // محتوى اليومية
    var content: String
    // حالة حفظ اليومية (هل هي مميزة بنجمة/بوكمارك أم لا)
    var isBookmarked: Bool = false
    // التاريخ الحقيقي للإنشاء لغرض الترتيب
    var createdDate: Date = Date()
}
