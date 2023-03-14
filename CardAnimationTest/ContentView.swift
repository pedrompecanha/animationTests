//
//  ContentView.swift
//  CardAnimationTest
//
//  Created by Pedro Peçanha on 03/03/23.
//

import SwiftUI

struct ContentView: View {
    
    @Namespace var namespace
    @State var isFinalPosition = false
    var body: some View {
        ZStack {
            if !isFinalPosition {
                ZStack{
                    cardGrid
                }
            }
            else {
                VStack {
                    cardLine
                    Spacer()
                }
                .padding(.top, 60)
            }
            
            VStack {
                Spacer()
                continueButton
            }
        }
        .animation(.easeInOut, value: isFinalPosition)
        
    }
    
    var continueButton: some View {
        Button(action: {
            isFinalPosition.toggle()
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.black)
                    .frame(width: 200, height: 50)
                Text("Continue")
                    .foregroundColor(.white)
            }
            .padding(.bottom, 50)
        })
    }
    
    var cardGrid: some View {
        VStack{
            HStack{
                cardTopLeft
                cardTopRight
            }
            HStack{
                cardBottomLeft
                cardBottomRight
                
            }
        }
    }
    
    var cardLine: some View {
        HStack(spacing: -30) {
            cardTopLeft
                .rotationEffect(Angle(degrees: -10))
            cardTopRight
                .rotationEffect(Angle(degrees: -5))
                .offset(y: -20)
            cardBottomLeft
                .rotationEffect(Angle(degrees: 5))
                .offset(y: -20)
            cardBottomRight
                .rotationEffect(Angle(degrees: 10))
        }
    }
    
    var cardTopLeft: some View {
        Image("card")
            .resizable()
            .matchedGeometryEffect(id: "cardTopLeft", in: namespace)
            .aspectRatio(contentMode: .fit)
            .frame(width: 80)
            .ignoresSafeArea(.all, edges: .all)
    }
    
    var cardBottomLeft: some View {
        Image("card")
            .resizable()
            .matchedGeometryEffect(id: "cardBottomLeft", in: namespace)
            .aspectRatio(contentMode: .fit)
            .frame(width: 80)
            .ignoresSafeArea(.all, edges: .all)
    }
    
    var cardTopRight: some View {
        Image("card")
            .resizable()
            .matchedGeometryEffect(id: "cardTopRight", in: namespace)
            .aspectRatio(contentMode: .fit)
            .frame(width: 80)
            .ignoresSafeArea(.all, edges: .all)
    }
    
    var cardBottomRight: some View {
        Image("card")
            .resizable()
            .matchedGeometryEffect(id: "cardBottomRight", in: namespace)
            .aspectRatio(contentMode: .fit)
            .frame(width: 80)
            .ignoresSafeArea(.all, edges: .all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
