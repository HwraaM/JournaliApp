import SwiftUI

struct SplashView: View {
    var appName: String? = "Journali"
    var tagline: String? = "Your thoughts, your story"

    var body: some View {
        if let currentName = appName, let currentTagline = tagline {
            ZStack {
                // 1. الخلفية الأساسية سوداء بالكامل
                Color.black
                    .ignoresSafeArea()
                
                // 2. التدرج الرمادي المائل للأبيض في أسفل الصفحة فقط (تقريباً الربع الأخير)
                VStack {
                    Spacer()
                    LinearGradient(
                        colors: [Color.white.opacity(0.0), Color.gray.opacity(0.25)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: 200) // يتحكم بارتفاع التدرج في أسفل الصفحة
                    .ignoresSafeArea(edges: .bottom)
                }
                
                // 3. المحتوى والنصوص كما هي تماماً
                VStack(spacing: 16) {
                    Image("SplashLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                    
                    Text(currentName)
                        .font(.system(size: 42, weight: .bold))
                        .foregroundColor(.white)
                    
                    Text(currentTagline)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.gray)
                }
            }
        } else {
            Color.black
                .ignoresSafeArea()
        }
    }
}

#Preview {
    SplashView()
}
