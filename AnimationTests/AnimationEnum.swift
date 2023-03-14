//
//  AnimationsEnum.swift
//  AnimationTests
//
//  Created by Pedro Peçanha on 13/03/23.
//

import Foundation

enum AnimationEnum: String, Identifiable {
    
    var id: Self {
        return self
       }
    
    case card
    case newTweet
}
