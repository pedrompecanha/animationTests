//
//  MenuView.swift
//  AnimationTests
//
//  Created by Pedro Peçanha on 13/03/23.
//

import Foundation
import SwiftUI

struct MenuView: View {
    
    @State var animationCase: AnimationEnum = .newTweet
    @State var caseSelected = false
    var body: some View {
        
        if !caseSelected {
            ForEach(AnimationEnum.allCases, content: { enumCase in
                Button(action: {
                    withAnimation {
                        animationCase = enumCase
                        caseSelected.toggle()
                    }
                }, label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 200, height: 50)
                        Text (enumCase.rawValue)
                            .foregroundColor(.white)
                    }
                })
            })
        }
        
        else {
            GeometryReader { geo in
                ZStack {
                    switch animationCase {
                        case .card:
                            CardAnimation()
                        case .newTweet:
                            NewTweetButtonAnimation()
                        case .cardPage:
                            CardPageAnimation()
                        case .cardExpansion:
                            CardExpansionAnimation()
                    }
                    backButton
                }.frame(width: geo.size.width, height: geo.size.height)
            }
        }
        
        
        
    }
    
    
    var cardAnimation: some View {
        CardAnimation()
    }
    
    var newTweetButtonAnimation: some View {
        NewTweetButtonAnimation()
    }
    
    var backButton: some View {
        
        VStack{
            HStack{
                Button(action: {
                    withAnimation {
                        caseSelected.toggle()
                    }
                }) {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.green)
                        .frame(width: 22, height: 22)
                        .contentShape(Rectangle())
                        .padding(.leading, 20)
                        .padding(.top, 20)
                }
                
                Spacer()
            }
            
            Spacer()
        }
    }
}

