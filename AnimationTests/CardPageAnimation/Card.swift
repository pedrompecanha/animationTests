//
//  Card.swift
//  AnimationTests
//
//  Created by Pedro Peçanha on 18/03/23.
//

import SwiftUI

struct Card: View {
    
    let material: Material
    let rotationAngle: Angle
    let namespace: Namespace.ID
    let geometryEffectID: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(material)
                .rotation3DEffect(rotationAngle, axis: (x:10 ,y:0,z:0))
                .matchedGeometryEffect(id: geometryEffectID, in: namespace)
                .frame(width: 150, height: 150, alignment: .center)
      
        }
    }
}
