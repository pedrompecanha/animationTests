//
//  CardPageAnimation.swift
//  AnimationTests
//
//  Created by Pedro Peçanha on 15/03/23.
//

import SwiftUI

let animationDuration: CGFloat = 0.6

struct CardPageAnimation: View {
    
    @Namespace var namespace
    @State var page: Int = 0
    @State var correctEdges = false
    var body: some View {
        ZStack {
            
//            Color.green
            
            if page == 0 {
               
                ZStack {
                    cardStack
                }
            }
            
            else {
                VStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.purple)
                        .rotation3DEffect(correctEdges ? Angle(degrees: 50) : Angle(degrees: 50), axis: (x:10 ,y:0,z:0))
                        .matchedGeometryEffect(id: "card1", in: namespace)
                        .frame(width: 200, height: 50)
                        .padding(.top, 100)
                    Spacer()
                }.onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration , execute: {
                        withAnimation {
                            correctEdges = true
                        }
                    })
                }
                
            }
       
            TabView(selection: $page) {
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .opacity(0)
                    .contentShape(Rectangle())
                    .tag(0)
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .opacity(0)
                    .contentShape(Rectangle())
                    .tag(1)
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .opacity(0)
                    .contentShape(Rectangle())
                    .tag(2)
            }
            .tabViewStyle(.page)


            
        }.animation(.easeInOut(duration: animationDuration), value: page)
            .onChange(of: page, perform: {_ in
                if page == 0 {
                    correctEdges = false
                }
            })
        .background(.black)
           
    }
    
    
    
    var cardStack: some View {
        VStack(spacing: -220) {
            Card(material: .thin, rotationAngle: Angle(degrees: 30), namespace: namespace, geometryEffectID: "card3")
            Card(material: .regularMaterial, rotationAngle: Angle(degrees: 40), namespace: namespace, geometryEffectID: "card2")
            Card(material: .regular, rotationAngle: Angle(degrees: 50), namespace: namespace, geometryEffectID: "card1")
        }
    }
    
    struct Card: View {
        
        let material: Material
        let rotationAngle: Angle
        let namespace: Namespace.ID
        let geometryEffectID: String
        
        var body: some View {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.white)
                .rotation3DEffect(rotationAngle, axis: (x:10 ,y:0,z:0))
                .matchedGeometryEffect(id: geometryEffectID, in: namespace)
                .frame(width: 150, height: 150, alignment: .center)
        }
    }
    
}


