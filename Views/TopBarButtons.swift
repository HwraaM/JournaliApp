//
//  TopBarButtons.swift
//  MyApp
//
//  Created by HAWRA12 on 01/06/1448 AH.
//

import Foundation
import SwiftUI

struct TopBarButtons: View {
    var onFilterTap: () -> Void
    var onAddTap: () -> Void

    var body: some View {
        HStack(spacing: 20) {
            Button(action: onFilterTap) {
                Image(systemName: "line.3.horizontal")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white)
            }
            
            Button(action: onAddTap) {
                Image(systemName: "plus")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 10)
        .background(Color(red: 0.14, green: 0.14, blue: 0.15))
        .clipShape(Capsule())
    }
}
