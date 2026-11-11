import SwiftUI

struct HomeView: View {
    @Binding var showAddSheet: Bool
    @Binding var searchText: String

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                // الهيدر العلوي والكبسولة
                HStack {
                    Text("Journal")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    TopBarButtons(
                        onFilterTap: { print("فلترة") },
                        onAddTap: { showAddSheet = true }
                    )
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                
                Spacer()
                
                // الحالة الفارغة (Empty State)
                VStack(spacing: 16) {
                    Image("notebook")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 130, height: 130)
                    
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
                
                // شريط البحث السفلي
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
                .padding(.bottom, 20)
            }
        }
    }
}
