//
//  CustomTimePicker.swift
//  My-iOS-Apps
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
        CustomTimePickerWheelView(hour: $hour, minute: $minute, second: $second)
    }
}

struct TimePickerView : View {
    @Binding var time: Int

    var body: some View {
        Picker("", selection: $time) {
            ForEach(0..<24) { Text("\($0)") }
        }
        .frame(width: 50)
    }
}

private var separatorTextView : some View {
    Text(":")
}

struct CustomTimePickerWheelView : View {
    
    @Binding var hour: Int
    @Binding var minute: Int
    @Binding var second: Int
    
    var body: some View {
        HStack {
            TimePickerView(time: $hour)
            separatorTextView
            TimePickerView(time: $minute)
            separatorTextView
            TimePickerView(time: $second)
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
