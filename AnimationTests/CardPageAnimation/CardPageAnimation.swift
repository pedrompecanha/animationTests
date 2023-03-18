//
//  CardPageAnimation.swift
//  AnimationTests
//
//  Created by Pedro Peçanha on 15/03/23.
//

import SwiftUI

let animationDuration: CGFloat = 0.6

private let rectangleHeight: CGFloat = 60
private let rectangleWidth: CGFloat = 200

struct CardPageAnimation: View {
    
    @Namespace var namespace
    @State var page: Int = 0
    @State var correctEdges = false
    @State var pageController = 0
    
    var body: some View {
        ZStack {
                        
            if pageController == 0 {
                    cardStack
            }
            
            else if pageController == 1 {
                threeRectangleView
            }
            
            else {
              threeCircleView
            }
            TabView(selection: $page) {
                tabViewEmptyRectangle
                    .tag(0)
                tabViewEmptyRectangle
                    .tag(1)
                tabViewEmptyRectangle
                    .tag(2)
            }
            .tabViewStyle(.page)


            
        }.animation(.easeInOut(duration: animationDuration), value: pageController)
            .onChange(of: page, perform: {_ in
                
                
                 if page == 0 {
                     withAnimation (.easeInOut(duration: 0.1)) {
                         correctEdges = false
                     }
                 }
                    pageController = page
                
                
               
                
            })
        .background(.primary)
           
    }
    
    var tabViewEmptyRectangle: some View {
        Rectangle()
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .opacity(0)
            .contentShape(Rectangle())
    }
    
    var threeRectangleView: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.purple)
                .rotation3DEffect(correctEdges ? Angle(degrees: 0) : Angle(degrees: 50), axis: (x:10 ,y:0,z:0))
                .matchedGeometryEffect(id: "card1", in: namespace)
                .frame(width: rectangleWidth, height: rectangleHeight)
            HStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.green)
                    .rotation3DEffect(correctEdges ? Angle(degrees: 0) : Angle(degrees: 50), axis: (x:10 ,y:0,z:0))
                    .matchedGeometryEffect(id: "card2", in: namespace)
                    .frame(width: rectangleWidth/1.2, height: rectangleHeight)
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.blue)
                    .rotation3DEffect(correctEdges ? Angle(degrees: 0) : Angle(degrees: 50), axis: (x:10 ,y:0,z:0))
                    .matchedGeometryEffect(id: "card3", in: namespace)
                    .frame(width: rectangleWidth/1.2, height: rectangleHeight)
            }
            .padding(.top, 20)
        }.onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3 , execute: {
                withAnimation {
                    correctEdges = true
                }
            })
        }
    }
    
    var threeCircleView: some View {
        VStack {
            RoundedRectangle(cornerRadius: rectangleHeight/2)
                .foregroundColor(.purple)
                .matchedGeometryEffect(id: "card1", in: namespace)
                .frame(width: rectangleHeight, height: rectangleHeight)
            HStack {
                RoundedRectangle(cornerRadius: rectangleHeight/2)
                    .foregroundColor(.green)
                    .matchedGeometryEffect(id: "card2", in: namespace)
                    .frame(width: rectangleHeight, height: rectangleHeight)
                    .padding(.trailing, 20)
                RoundedRectangle(cornerRadius: rectangleHeight/2)
                    .foregroundColor(.blue)
                    .matchedGeometryEffect(id: "card3", in: namespace)
                    .frame(width: rectangleHeight, height: rectangleHeight)
                    .padding(.leading, 20)

            }
            .padding(.top, 20)
        }
    }
    
    
    var cardStack: some View {
        VStack(spacing: -220) {
            Card(material: .thin, rotationAngle: Angle(degrees: 30), namespace: namespace, geometryEffectID: "card3")
            Card(material: .regularMaterial, rotationAngle: Angle(degrees: 40), namespace: namespace, geometryEffectID: "card2")
            Card(material: .regular, rotationAngle: Angle(degrees: 50), namespace: namespace, geometryEffectID: "card1")
        }
       
    }
    
    
    
}


