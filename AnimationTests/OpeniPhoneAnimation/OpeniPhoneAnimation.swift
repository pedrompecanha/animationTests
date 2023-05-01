//
//  OpeniPhoneAnimation.swift
//  AnimationTests
//
//  Created by Pedro Peçanha on 01/05/23.
//

import Foundation
import SwiftUI



struct OpeniPhoneAnimation: View {
    @State var isExpanded = false
    var body: some View {
        VStack(spacing: 60) {
            restartButton
            appRow
            appRow
            appRow
            appRow
        }
        .frame(maxHeight: .infinity)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                withAnimation (.spring()) {
                    isExpanded.toggle()
                }
            }
            
        }
    }
    
    var appRow: some View {
        HStack(spacing: 15) {
            SquareApp(isExpanded: $isExpanded)
            SquareApp(isExpanded: $isExpanded)
            SquareApp(isExpanded: $isExpanded)
            SquareApp(isExpanded: $isExpanded)
        }
        .frame(maxWidth: .infinity)
    }
    
    var restartButton: some View {
        Button {
            isExpanded = false
            withAnimation (.spring()) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
                    withAnimation (.spring()) {
                        isExpanded.toggle()
                    }
                }
            }
        } label: {
                Text("Restart")
            }
            .buttonStyle(BorderedProeminentPadded())
        }
        
    }
    
    
    struct SquareApp: View {
        var id: UUID = UUID()
        @Namespace var sizeIncreaser
        var colors: [Color] = [.red, .blue, .green, .orange, .yellow, .cyan]
        @Binding var isExpanded: Bool
        
        var body: some View {
            VStack {
                if isExpanded {
                    RoundedRectangle(cornerRadius: 10)
                        .matchedGeometryEffect(id: id, in: sizeIncreaser)
                        .frame(width: 65, height: 65)
                        .foregroundColor(colors.randomElement())
                }
                else {
                    RoundedRectangle(cornerRadius: 10)                .matchedGeometryEffect(id: id, in: sizeIncreaser)
                        .frame(width: 550, height: 550)
                        .foregroundColor(colors.randomElement())
                }
            }
            
        }
        
    }

struct BorderedProeminentPadded: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
            configuration.label
            .font(.body.bold())
            .padding(.horizontal, 25)
            .padding(.vertical, 15)
            .foregroundColor(.white)
            .background(.blue)
            .cornerRadius(12)
    }
}
