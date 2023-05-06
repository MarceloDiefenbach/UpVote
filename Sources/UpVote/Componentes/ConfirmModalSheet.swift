//
//  File.swift
//  
//
//  Created by Marcelo Diefenbach on 03/05/23.
//

import SwiftUI

struct ConfirmModalSheet: View {
    
    @State var title: String
    @State var description: String
    @State var onConfirm: () -> Void
    
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            Text("Confirm your vote")
                .font(.DesignSystem.largeTitleBold)
                .padding(.top, 40)
                .padding(.bottom, 40)
            
            VStack {
                Text(title)
                    .font(.DesignSystem.titleBold)
                    .padding(.bottom, 4)
                Text(description)
                    .font(.DesignSystem.normalRegular)
            }
            .padding(.vertical, 32)
            .frame(width: UIScreen.main.bounds.width*0.9)
            .background(.black.opacity(0.04))
            .cornerRadius(16)
            
            Spacer()
            
            HStack {
                UVButton(title: "Cancel", iconSFSymbols: "", style: .secondary, action: {
                    isPresented = false
                })
                .padding(.trailing, 2)
                
                UVButton(title: "Confirm", iconSFSymbols: "", style: .primary, action: {
                    onConfirm()
                    isPresented = false
                })
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
    }
}
