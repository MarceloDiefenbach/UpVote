//
//  File.swift
//  
//
//  Created by Marcelo Diefenbach on 03/05/23.
//

import Foundation
import SwiftUI

struct UVButton: View {
    enum Style {
        case primary
        case secondary
        case disabled
    }
    
    let title: String
    let iconSFSymbols: String?
    let style: Style
    let action: () -> Void
    
    private var backgroundColor: Color {
        switch style {
        case .primary:
            return .black
        case .secondary:
            return .black.opacity(0.05)
        case .disabled:
            return .black.opacity(0.3)
        }
    }
    
    private var textColor: Color {
        switch style {
        case .primary:
            return .white
        case .secondary:
            return .black
        case .disabled:
            return .black.opacity(0.3)
        }
    }
    
    var body: some View {
            HStack {
                if let iconSFSymbols = iconSFSymbols, !iconSFSymbols.isEmpty, iconSFSymbols != "" {
                    Image(systemName: iconSFSymbols)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 8)
                        .foregroundColor(textColor)
                }
                
                Text(title)
                    .foregroundColor(textColor)
                    .font(.system(size: 18, weight: .semibold))
            }
            .padding(.vertical, 24)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(16)
            .opacity(style == .disabled ? 0.5 : 1)
            .onTapGesture {
                action()
            }

    }
}


struct UVButton_Previews: PreviewProvider {
    static var previews: some View {
        UVButton(title: "texto do botão", iconSFSymbols: "eraser.fill", style: .primary, action: {})
    }
}
