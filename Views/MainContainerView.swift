import SwiftUI

struct MainContainerView: View {
    // حالة شاشة السبلاش (Splash Screen)
    @State private var showSplash = true
    
    // إنشاء كلاس الـ ViewModel الأساسي للتطبيق بنمط MVVM
    @StateObject private var viewModel = JournalViewModel()

    var body: some View {
        ZStack {
            if showSplash {
                SplashView()
                    .transition(.opacity)
                    .onAppear {
                        // مؤقت زمني لمدَّة عرض شاشة السبلاش (ثانيتان)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            withAnimation {
                                showSplash = false
                            }
                        }
                    }
            } else {
                NavigationStack {
                    Group {
                        // التنقل الذكي بناءً على وجود بيانات أو فراغها
                        if viewModel.journals.isEmpty {
                            HomeView(viewModel: viewModel)
                        } else {
                            JournalListView(viewModel: viewModel)
                        }
                    }
                    // نافذة الإضافة (Sheet)
                    .sheet(isPresented: $viewModel.showAddSheet) {
                        AddJournalView { newJournal in
                            viewModel.addJournal(newJournal)
                        }
                    }
                }
            }
        }
    }
}

struct MainContainerView_Previews: PreviewProvider {
    static var previews: some View {
        MainContainerView()
    }
}
