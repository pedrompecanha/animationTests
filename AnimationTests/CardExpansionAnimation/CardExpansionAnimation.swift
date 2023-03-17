//
//  CardExpansionAnimation.swift
//  AnimationTests
//
//  Created by Pedro Peçanha on 16/03/23.
//

import SwiftUI

struct CardExpansionAnimation: View {
    let viewDataArray = [("New York", 27), ("London", 18), ("Paris", 22), ("Tokyo", 30), ("Sydney", 16), ("Beijing", 21), ("Moscow", 25), ("Rio de Janeiro", 28), ("Cairo", 20), ("Dubai", 32)].map { ViewData(temperature: $0.1, place: $0.0) }
    @Namespace var namespace
    @State var isExpanded = false
    @State var rectangleID: Int = 0
    @State var placeTextID: String = ""
    @State var temperatureTextID: String = ""
    @State var viewOpenedData: ViewData = ViewData(temperature: 15, place: "brazil")
    
    var body: some View {
        
        GeometryReader {geo in
        ZStack {
                if isExpanded {
                    expandedRectangle(viewData: viewOpenedData, isExpanded: $isExpanded, globalRectangleID: $rectangleID, globalPlaceID: $placeTextID, globalTemperatureID: $temperatureTextID, namespace: namespace, matchedGeometryID: rectangleID)
                }
                
                else {
                    ScrollView {
                        VStack(){
                            ForEach(Array(viewDataArray.enumerated()), id: \.element.id) { count, viewData in
                                smallRectangle(viewData: viewData, isExpanded: $isExpanded, globalRectangleID: $rectangleID, globalPlaceID: $placeTextID, globalTemperatureID: $temperatureTextID, globalViewData: $viewOpenedData, namespace: namespace, matchedGeometryID: count)
                            }
                            
                        }
                    }
                    .padding(.top, 50)
                    .padding(.bottom, 20)
                }
            }
        .ignoresSafeArea()
        .animation(.easeInOut, value: isExpanded)
        .frame(width: geo.size.width, height: geo.size.height)
        .background(LinearGradient(colors: [.blue, .cyan], startPoint: .bottomLeading, endPoint: .topTrailing))
            
            
        }
       
    }
    
   
    
}

struct CardExpansionAnimation_Previews: PreviewProvider {
    static var previews: some View {
        CardExpansionAnimation()
    }
}

struct ViewData {
    var id = UUID()
    let temperature: Int
    let place: String
    var climate: String {temperature > 25 ? "Hot" : "Not Hot"}
    
}

struct expandedRectangle: View {
    var viewData: ViewData
    @Binding var isExpanded: Bool
    @Binding var globalRectangleID: Int
    @Binding var globalPlaceID: String
    @Binding var globalTemperatureID: String
    @State var fontSize: CGFloat = 30
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
                    Text (viewData.place)
                        .matchedGeometryEffect(id: globalPlaceID, in: namespace)
                        .font(.system(size: fontSize).weight(.bold))
                        .contentTransition(.interpolate)
                        .foregroundColor(.white)
                        .padding(.top, 70)
                    Text (viewData.temperature.string)
                        .matchedGeometryEffect(id: globalTemperatureID, in: namespace)
                        .font(.title.weight(.bold))
                        .foregroundColor(.white)
                    Button(action: {
                        isExpanded.toggle()
                        withAnimation {
                            fontSize = 30
                        }
                    }, label: {
                        Text ("go back")
                    })
                    .buttonStyle(.borderedProminent)
                    
                }
                
                
            }
            .onAppear {
                withAnimation {
                    fontSize = 70
                }
            }
            
        }
      
    }

}

struct smallRectangle: View {
    var viewData: ViewData
    @Binding var isExpanded: Bool
    @Binding var globalRectangleID: Int
    @Binding var globalPlaceID: String
    @Binding var globalTemperatureID: String
    @Binding var globalViewData: ViewData
    var namespace: Namespace.ID
    var matchedGeometryID: Int
    var placeTextID: String {String("place" + String(matchedGeometryID))}
    var temperatureTextID: String {"temperature" + String(matchedGeometryID)}
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 20)
                .matchedGeometryEffect(id: matchedGeometryID, in: namespace)
                .frame(width: 250, height: UIScreen.main.bounds.height/6)
                .foregroundStyle(.regularMaterial)
            HStack {
                Text (viewData.place)
                    .matchedGeometryEffect(id: placeTextID, in: namespace)
                    .font(.system(size: 30).weight(.bold))
                    .contentTransition(.interpolate)
                Text (viewData.temperature.string)
                    .font(.title.weight(.bold))
                    .matchedGeometryEffect(id: temperatureTextID, in: namespace)

            }
        }
        .onTapGesture {
            globalRectangleID = matchedGeometryID
            globalPlaceID = placeTextID
            globalTemperatureID = temperatureTextID
            globalViewData = ViewData(temperature: viewData.temperature, place: viewData.place)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                isExpanded.toggle()
            }
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

