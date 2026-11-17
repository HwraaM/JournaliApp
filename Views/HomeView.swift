import SwiftUI

struct HomeView: View {
    // ربط كلاس الـ ViewModel لإدارة الحالة والبيانات مباشرة
    @ObservedObject var viewModel: JournalViewModel

    var body: some View {
        ZStack {
            // اعتماد الدارك مود العام وعدم تكرار لون الخلفية يدوياً
            VStack(spacing: 0) {
                // ترويسة الصفحة العلوية (بمظهر Liquid Glass)
                HStack {
                    Text("Journal")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.primary)
                     
                    Spacer()
                     
                    // زر الإضافة في الحالة الفارغة
                    Button(action: {
                        viewModel.showAddSheet = true
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.primary)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(.ultraThinMaterial) // تطبيق Liquid Glass
                    .clipShape(Capsule())
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                 
                Spacer()
                 
                // عناصر الحالة الفارغة (أيقونة الدفتر والنصوص التوجيهية)
                VStack(spacing: 16) {
                    Image(systemName: "book.closed.fill")
                        .font(.system(size: 70))
                        .foregroundColor(Color(red: 0.7, green: 0.6, blue: 0.9))
                     
                    Text("Begin Your Journal")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(Color(red: 0.7, green: 0.6, blue: 0.9))
                     
                    Text("Craft your personal diary, tap the\nplus icon to begin")
                        .font(.system(size: 16))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                }
                 
                Spacer()
                 
                // شريط البحث السفلي الثابت (مع أيقونة المايك الشكل الثابت وبدون كود تشغيل)
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.secondary)
                     
                    TextField("Search", text: $viewModel.searchText)
                        .foregroundColor(.primary)
                    
                    // أيقونة المايك كشكل فقط بدون تفاعل أو تفعيل برمجي
                    Button(action: {}) {
                        Image(systemName: "mic.fill")
                            .foregroundColor(.secondary.opacity(0.6))
                    }
                }
                .padding()
                .background(.ultraThinMaterial) // تطبيق Liquid Glass الأصلي
                .clipShape(Capsule())
                .padding(.horizontal, 20)
                .padding(.bottom, 15)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: JournalViewModel())
    }
}
