//
//  DetailedCardView.swift
//  AnimationTests
//
//  Created by Pedro Peçanha on 17/03/23.
//

import Foundation
import SwiftUI

struct DetailedCard: View {
    var viewData: ClimateModel
    @Binding var isExpanded: Bool
    @Binding var globalRectangleID: Int
    @Binding var globalPlaceID: String
    @Binding var globalTemperatureID: String
    @State var placeFontSize: CGFloat = MagicNumbers.collapsedPlaceSize
    @State var temperatureFontSize: CGFloat = MagicNumbers.collapsedTemperatureSize
    @State var climateOpacity: CGFloat = 0
    var namespace: Namespace.ID
    var matchedGeometryID: Int
    var placeTextID: String {String("place" + String(matchedGeometryID))}
    var temperatureTextID: String {"temperature" + String(matchedGeometryID)}
    
    var body: some View {
        GeometryReader {geo in
            ZStack {
                Rectangle()
                    .matchedGeometryEffect(id: globalRectangleID , in: namespace)
                    .frame(width: geo.size.width, height: geo.size.height)
                    .foregroundColor(.white)
                    .opacity(0.2)
                
                VStack() {
                    Group {
                        Text (viewData.place)
                            .matchedGeometryEffect(id: globalPlaceID, in: namespace)
                            .animatableFont(weight: .bold, size: placeFontSize)
                            .foregroundColor(.white)
                            .padding(.top, 70)
                        Text (viewData.temperature.string + "º")
                            .matchedGeometryEffect(id: globalTemperatureID, in: namespace)
                            .animatableFont(weight: .bold, size: temperatureFontSize)
                            .foregroundColor(.white)
                        Text (viewData.climate)
                            .transition(.scale)
                            .foregroundColor(.white)
                            .font(.system(size: MagicNumbers.expandedTemperatureSize/2).weight(.bold))
                            .opacity(climateOpacity)
                    }
                    Spacer()
                    
                    Button(action: {
                        isExpanded.toggle()
                        withAnimation {
                            placeFontSize = MagicNumbers.collapsedPlaceSize
                            temperatureFontSize = MagicNumbers.collapsedTemperatureSize
                        }
                    }, label: {
                        Text ("Return to Menu")
                    })
                    .padding(.bottom, 30)
                    .buttonStyle(.borderedProminent)
                    
                }
                
                
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation {
                        placeFontSize = MagicNumbers.expandedPlaceSize
                        temperatureFontSize = MagicNumbers.expandedTemperatureSize
                        climateOpacity = 1.0
                    }
                }
                
            }
            
        }
      
    }

}
