//
//  RangeSlider.swift
//  DateDay
//
//  Created by Quentin Derouard on 14/05/2024.
//

import SwiftUI

struct RangeSlider: View {
    @Binding var range: ClosedRange<Double>
    var inRange: ClosedRange<Double>
    var step: Double
    var label: () -> Text
    
    var body: some View {
        VStack {
            label()
            Slider(value: Binding(get: {
                range.lowerBound
            }, set: { newValue in
                range = newValue...range.upperBound
            }), in: inRange.lowerBound...range.upperBound, step: step)
            Slider(value: Binding(get: {
                range.upperBound
            }, set: { newValue in
                range = range.lowerBound...newValue
            }), in: range.lowerBound...inRange.upperBound, step: step)
        }
    }
}
