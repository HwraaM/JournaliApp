import SwiftUI

struct HomeView: View {
    @State private var searchText = ""
    @State private var showNewEntrySheet = false // تصحيح القيمة هنا لتكون صالحة برمجياً

    var body: some View {
        NavigationStack {
            ZStack {
                // خلفية سوداء خالصة تماماً بدون تدرج
                Color.black
                    .ignoresSafeArea()
                
                VStack {
                    // 1️⃣ الهيدر العلوي (Journal + أزرار القائمة والإضافة)
                    HStack {
                        Text("Journal")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        // الأزرار العلوية المتفاعلة
                        HStack(spacing: 16) {
                            Button(action: {
                                print("تم الضغط على زر القائمة")
                            }) {
                                Image(systemName: "line.3.horizontal")
                                    .foregroundColor(.white)
                            }
                            
                            // زر الإضافة (+) للتسجيل
                            Button(action: {
                                print("تم الضغط على زر الإضافة بنجاح")
                                showNewEntrySheet = true
                            }) {
                                Image(systemName: "plus")
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(20)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    
                    Spacer()
                    
                    // 2️⃣ المحتوى في المنتصف (أيقونة الدفتر والنصوص)
                    VStack(spacing: 16) {
                        Image("notebook")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 140, height: 140)
                        
                        Text("Begin Your Journal")
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundColor(Color(red: 0.7, green: 0.6, blue: 0.9))
                        
                        Text("Craft your personal diary, tap the plus icon to begin")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                    }
                    
                    Spacer()
                    
                    // 3️⃣ شريط البحث السفلي
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Search", text: $searchText)
                            .foregroundColor(.white)
                        
                        Image(systemName: "mic.fill")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color.white.opacity(0.08))
                    .cornerRadius(24)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
