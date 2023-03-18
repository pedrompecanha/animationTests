//
//  ClimateModel.swift
//  AnimationTests
//
//  Created by Pedro Peçanha on 17/03/23.
//

import Foundation

struct ClimateModel {
    var id = UUID()
    let temperature: Int
    let place: String
    var climate: String {temperature > 25 ? "Hot" : "Not Hot"}
    
}
