//
//  Extensions.swift
//  AnimationTests
//
//  Created by Pedro Peçanha on 17/03/23.
//

import SwiftUI

// A modifier that animates a font through various sizes.
struct AnimatableCustomFontModifier: ViewModifier, Animatable {
    var weight: Font.Weight
    var size: Double

    var animatableData: Double {
        get { size }
        set { size = newValue }
    }

    func body(content: Content) -> some View {
        content
            .font(.system(size: size).weight(weight))
    }
}

// To make that easier to use, I recommend wrapping
// it in a `View` extension, like this:
extension View {
    func animatableFont(weight: Font.Weight, size: Double) -> some View {
        self.modifier(AnimatableCustomFontModifier(weight: weight, size: size))
    }
}
