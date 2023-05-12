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
        ZStack {
            Color.black.opacity(0.2).ignoresSafeArea()
            VStack {
                Spacer()
                Spacer()
                Spacer()
                
                VStack {
                    Text(UpVoteConfig.shared.confirmTitleModal)
                        .font(.DesignSystem.largeTitleBold)
                        .padding(.top, 24)
                        .padding(.bottom, 32)
                    
                    HStack {
                        Spacer()
                        VStack {
                            Text(title)
                                .multilineTextAlignment(.center)
                                .font(.DesignSystem.titleBold)
                                .padding(.bottom, 4)
                                .lineLimit(3)
                            Text(description)
                                .multilineTextAlignment(.center)
                                .font(.DesignSystem.normalRegular)
                                .lineLimit(3)
                        }
                        Spacer()
                    }
                    .padding(.vertical, 32)
                    .padding(.horizontal, 32)
                    .background(.black.opacity(0.04))
                    .cornerRadius(16)
                    
                    Spacer()
                    
                    HStack {
                        UVButton(title: UpVoteConfig.shared.cancelButtonLabel, iconSFSymbols: "", style: .secondary, action: {
                            isPresented = false
                        })
                        .padding(.trailing, 2)
                        
                        UVButton(title: UpVoteConfig.shared.confirmButtonLabel, iconSFSymbols: "", style: .primary, action: {
                            onConfirm()
                            isPresented = false
                        })
                    }
                }
                .padding(.all)
                .frame(height: UIScreen.main.bounds.height*0.5)
                .background(.white)
                .cornerRadius(16)
                .padding(.all)
            }
            .padding(.vertical)
        }
    }
}
