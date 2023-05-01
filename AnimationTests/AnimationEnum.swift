//
//  AnimationsEnum.swift
//  AnimationTests
//
//  Created by Pedro Peçanha on 13/03/23.
//

import Foundation

enum AnimationEnum: String, Identifiable, CaseIterable {
    
    var id: Self {
        return self
       }
    
    case card
    case newTweet
    case cardPage
    case cardExpansion
    case openiPhone
}


