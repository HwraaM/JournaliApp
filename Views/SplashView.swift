import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            // الخلفية بتدرج الألوان الجديد والدقيق
            LinearGradient(
                colors: [.black, Color(red: 0.08, green: 0.08, blue: 0.09)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 24) {
                // أيقونة الدفتر الخاصة بكِ
                Image("SplashLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                
                // اسم التطبيق
                Text("Journali")
                    .font(.system(size: 44, weight: .bold))
                    .foregroundColor(.white)
                
                // السلوغن
                Text("Your thoughts, your story")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.gray)
            }
        }
    }
}

#Preview {
    SplashView()
}
