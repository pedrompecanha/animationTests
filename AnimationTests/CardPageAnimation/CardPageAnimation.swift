//
//  CardPageAnimation.swift
//  AnimationTests
//
//  Created by Pedro Peçanha on 15/03/23.
//

import SwiftUI

struct CardPageAnimation: View {
    
    @Namespace var namespace
    @State var page: Int = 0
    
    var body: some View {
        ZStack {
            Color.black
            TabView(selection: $page) {
                Circle()
                    .foregroundColor(.red)
                    .tag(0)
                Rectangle()
                    .foregroundColor(.purple)
                    .tag(1)
                Circle()
                    .foregroundColor(.cyan)
                    .tag(2)
            }
            .tabViewStyle(.page)
            switch page {
                case 0:
                    cardStack
                case 1:
                    RoundedRectangle(cornerRadius: 20)
                        .matchedGeometryEffect(id: "card1", in: namespace)
                        .frame(width: 200, height: 50)
                        .foregroundColor(.green)
                default:
                    EmptyView()
            }
       
            
            
            
        }.animation(.easeInOut, value: page)
            .onChange(of: page, perform: { _ in
                print(page)
            })
    }
    
    
    
    var cardStack: some View {
        VStack(spacing: -220) {
            Card(material: .thin, rotationAngle: Angle(degrees: 30), namespace: namespace, geometryEffectID: "card3")
            Card(material: .regularMaterial, rotationAngle: Angle(degrees: 40), namespace: namespace, geometryEffectID: "card2")
            Card(material: .ultraThick, rotationAngle: Angle(degrees: 50), namespace: namespace, geometryEffectID: "card1")
        }
    }
    
    struct Card: View {
        let material: Material
        let rotationAngle: Angle
        let namespace: Namespace.ID
        let geometryEffectID: String
        
        var body: some View {
            RoundedRectangle(cornerRadius: 30)
                .matchedGeometryEffect(id: geometryEffectID, in: namespace)
                .frame(width: 150, height: 150, alignment: .center)
                .foregroundStyle(material)
                .rotation3DEffect(rotationAngle, axis: (x:10 ,y:0,z:0))
        }
    }
    
}


