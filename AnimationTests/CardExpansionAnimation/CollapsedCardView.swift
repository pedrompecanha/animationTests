//
//  CollapsedCardView.swift
//  AnimationTests
//
//  Created by Pedro Peçanha on 17/03/23.
//

import SwiftUI

struct CollapsedCardView: View {
    var viewData: ClimateModel
    @Binding var isExpanded: Bool
    @Binding var globalRectangleID: Int
    @Binding var globalPlaceID: String
    @Binding var globalTemperatureID: String
    @Binding var globalViewData: ClimateModel
    var namespace: Namespace.ID
    var matchedGeometryID: Int
    var placeTextID: String {String("place" + String(matchedGeometryID))}
    var temperatureTextID: String {"temperature" + String(matchedGeometryID)}
    
    var body: some View {
       
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .matchedGeometryEffect(id: matchedGeometryID, in: namespace)
                    .frame(width: UIScreen.main.bounds.width - 90, height: UIScreen.main.bounds.height/6)
                    .foregroundStyle(.regularMaterial)
                HStack {
                    placeTextContainer
                        .padding([.top, .leading], 10)

                    Spacer()
                    Text (viewData.temperature.string + "º")
                        .animatableFont(weight: .bold, size: MagicNumbers.collapsedTemperatureSize)
                        .matchedGeometryEffect(id: temperatureTextID, in: namespace)
                        .padding(.trailing, 10)
                    
                }
            }
            .frame(width: UIScreen.main.bounds.width - 90)
            .onTapGesture {
                setGlobals()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    isExpanded.toggle()
                }
            }
        
    }
    
    var placeTextContainer: some View {
        VStack {
            Text (viewData.place)
                .animatableFont(weight: .bold, size: MagicNumbers.collapsedPlaceSize)
                .matchedGeometryEffect(id: placeTextID, in: namespace)
            Spacer()
        }
    }
    
    private func setGlobals() {
        globalRectangleID = matchedGeometryID
        globalPlaceID = placeTextID
        globalTemperatureID = temperatureTextID
        globalViewData = ClimateModel(temperature: viewData.temperature, place: viewData.place)
    }
}


