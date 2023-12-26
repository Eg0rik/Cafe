//
//  Modifiers.swift
//  Cafe
//
//  Created by MAC on 2/1/24.
//

import Foundation
import SwiftUI

struct CustomBorder: ViewModifier {
    
    var color:Color
    
    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: 10) // Радиус скругления углов
                    .stroke(color, lineWidth: 2) // Цвет и ширина линии
            )
    }
}

extension View {
    func customBorder(_ color:Color) -> some View {
        self.modifier(CustomBorder(color:color))
    }
}
