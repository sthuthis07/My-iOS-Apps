//
//  CustomTimePicker.swift
//  TimerApp-Index App
//
//  Created by Sthuthi S on 01/10/25.
//

import SwiftUI

struct CustomTimePicker: View {
    @Binding var hour: Int
    @Binding var minute: Int
    @Binding var second: Int

    init(hour: Binding<Int>, minute: Binding<Int>, second: Binding<Int>) {
        self._hour = hour
        self._minute = minute
        self._second = second
    }

    var body: some View {
        HStack {
            Picker("Hour", selection: $hour) {
                ForEach(0..<24) { Text("\($0)") }
            }
            .frame(width: 50)

            Text(":")

            Picker("Minute", selection: $minute) {
                ForEach(0..<60) { Text("\($0)") }
            }
            .frame(width: 50)

            Text(":")

            Picker("Second", selection: $second) {
                ForEach(0..<60) { Text("\($0)") }
            }
            .frame(width: 50)
        }
        .pickerStyle(.wheel)
        .labelsHidden()
    }
}

#Preview {
    CustomTimePicker(
        hour: .constant(0),
        minute: .constant(1),
        second: .constant(0)
    )
}
