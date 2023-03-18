//
//  CardExpansionAnimation.swift
//  AnimationTests
//
//  Created by Pedro Peçanha on 16/03/23.
//

import SwiftUI

struct CardExpansionAnimation: View {
    let viewDataArray = [("New York", 27), ("London", 18), ("Paris", 22), ("Tokyo", 30), ("Sydney", 16), ("Beijing", 21), ("Moscow", 25), ("Rio de Janeiro", 28), ("Cairo", 20), ("Dubai", 32)].map { ClimateModel(temperature: $0.1, place: $0.0) }
    @Namespace var namespace
    @State var isExpanded = false
    @State var rectangleID: Int = 0
    @State var placeTextID: String = ""
    @State var temperatureTextID: String = ""
    @State var viewOpenedData: ClimateModel = ClimateModel(temperature: 15, place: "brazil")
    
    var body: some View {
        
        GeometryReader {geo in
        ZStack {
                if isExpanded {
                    DetailedCard(viewData: viewOpenedData, isExpanded: $isExpanded, globalRectangleID: $rectangleID, globalPlaceID: $placeTextID, globalTemperatureID: $temperatureTextID, namespace: namespace, matchedGeometryID: rectangleID)
                }
                
                else {
                    ScrollView {
                        VStack(){
                            ForEach(Array(viewDataArray.enumerated()), id: \.element.id) { count, viewData in
                                CollapsedCardView(viewData: viewData, isExpanded: $isExpanded, globalRectangleID: $rectangleID, globalPlaceID: $placeTextID, globalTemperatureID: $temperatureTextID, globalViewData: $viewOpenedData, namespace: namespace, matchedGeometryID: count)
                            }
                            
                        }
                    }
                    .padding(.top, 50)
                    .padding(.bottom, 20)
                }
            }
        .ignoresSafeArea()
        .animation(.easeInOut(duration: 0.5), value: isExpanded)
        .frame(width: geo.size.width, height: geo.size.height)
        .background(LinearGradient(colors: [.blue, .cyan], startPoint: .bottomLeading, endPoint: .topTrailing))
            
            
        }
       
    }
    
   
    
}

extension Int {
    static let string: (Int) -> String = { value in
        return String(value)
    }
    
    var string: String {
        return Int.string(self)
    }
}

