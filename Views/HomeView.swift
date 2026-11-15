import SwiftUI

struct HomeView: View {
    // ربط كلاس الـ ViewModel لإدارة الحالة والبيانات مباشرة
    @ObservedObject var viewModel: JournalViewModel

    var body: some View {
        ZStack {
            // خلفية الشاشة السوداء الأساسية
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // ترويسة الصفحة العلوية
                HStack {
                    Text("Journal")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    // زر الإضافة في الحالة الفارغة
                    Button(action: {
                        viewModel.showAddSheet = true
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 18)
                    .padding(.vertical, 10)
                    .background(Color(red: 0.14, green: 0.14, blue: 0.15))
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
                        .foregroundColor(.white.opacity(0.85))
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                }
                
                Spacer()
                
                // شريط البحث السفلي الثابت (مع تفعيل زر المايكروفون)
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    
                    TextField("Search", text: $viewModel.searchText)
                        .foregroundColor(.white)
                    
                    // زر المايكروفون التفاعلي المتصل بالـ ViewModel
                    Button(action: {
                        viewModel.toggleVoiceSearch()
                    }) {
                        Image(systemName: viewModel.isRecording ? "mic.fill" : "mic")
                            .foregroundColor(viewModel.isRecording ? .red : .gray)
                    }
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


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: JournalViewModel())
    }
}
