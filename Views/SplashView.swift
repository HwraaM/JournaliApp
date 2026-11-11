import SwiftUI

struct SplashView: View {
    var appName: String? = "Journali"
    var tagline: String? = "Your thoughts, your story"

    var body: some View {
        if let currentName = appName, let currentTagline = tagline {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                
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
