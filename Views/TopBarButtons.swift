import SwiftUI

struct TopBarButtons: View {
    var onFilterTap: () -> Void
    var onAddTap: () -> Void

    var body: some View {
        HStack(spacing: 20) {
            Button(action: onFilterTap) {
                Image(systemName: "line.3.horizontal.decrease")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.primary)
            }
             
            Button(action: onAddTap) {
                Image(systemName: "plus")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.primary)
            }
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 10)
        .background(.ultraThinMaterial) // تطبيق Liquid Glass الأصلي
        .clipShape(Capsule())
    }
}


struct TopBarButtons_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            TopBarButtons(onFilterTap: {}, onAddTap: {})
        }
    }
}
