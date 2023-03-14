//
//  NewTweetButtonAnimation.swift
//  AnimationTests
//
//  Created by Pedro Peçanha on 13/03/23.
//

import SwiftUI

let buttonSize:CGFloat = 80

struct NewTweetButtonAnimation: View {
    
    @State var isShowingAddView = true
    @State var rotationController = false
    @Namespace var namespace

    var gradient: LinearGradient { LinearGradient(colors: [firstColor, secondColor], startPoint: .bottomLeading, endPoint: .topTrailing)}
    
    @State var firstColor: Color =  .cyan
    @State var secondColor: Color = .cyan


    
    var body: some View {
        ZStack {
            if isShowingAddView {
                addTweetView
                    .transition(.opacity)

            }
            
            else {
                addSpacesView
                    .transition(.opacity)

            }
        }
        .animation(.easeInOut, value: isShowingAddView)
        .animation(.easeInOut, value: rotationController)
        
    }
    
    
    var addTweetView: some View {
        Button(action: {
            rotationController.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                isShowingAddView.toggle()
            }
            firstColor = .pink
            secondColor = .purple
        }, label: {
            tweetButtonView
        })
        .buttonStyle(PlainButton())

    }
    
    var addSpacesView: some View {
        Button(action: {
            rotationController.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                isShowingAddView.toggle()
            }
            firstColor = .cyan
            secondColor = .cyan
        }, label: {
            spacesButtonView
        })
        .buttonStyle(PlainButton())

    }
    
    var tweetButtonView: some View {
        ZStack {
            Circle()
                .fill(gradient)
                .frame(width: buttonSize)
            Image(systemName: "plus")
                .resizable()
                .foregroundColor(.white)
                .matchedGeometryEffect(id: "button", in: namespace)
                .frame(width: buttonSize/2, height: buttonSize/2)
        }
        .rotationEffect(rotationController ? Angle(degrees: 0) : Angle(degrees: 30))
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.rotationController.toggle()
            }
        })
    }
    
    var spacesButtonView: some View {
        ZStack {
            Circle()
                .fill(gradient)
                .foregroundColor(.purple)
                .frame(width: buttonSize)
            Image(systemName: "mic")
                .resizable()
                .scaledToFit()
                .foregroundColor(.white)
                .matchedGeometryEffect(id: "button", in: namespace)
                .frame(width: buttonSize/2, height: buttonSize/2)
                .transition(.opacity)
        }
        .rotationEffect(rotationController ? Angle(degrees: 0) : Angle(degrees: -30))
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.rotationController.toggle()
            }
        
        })

    }
    
    
}

struct NewTweetButtonAnimation_Previews: PreviewProvider {
    static var previews: some View {
        NewTweetButtonAnimation()
    }
}


struct PlainButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
            configuration.label
            .padding()
            .frame(maxWidth: .infinity)
    }
}
