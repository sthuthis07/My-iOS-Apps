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

struct HourPickerView : View {
    @Binding var hour: Int

    var body: some View {
        Picker("Hour", selection: $hour) {
            ForEach(0..<24) { Text("\($0)") }
        }
        .frame(width: 50)
    }
}

struct MinutePickerView : View {
    @Binding var minute: Int
    
    var body: some View {
        Picker("Minute", selection: $minute) {
            ForEach(0..<60) { Text("\($0)") }
        }
        .frame(width: 50)
    }
}

struct SecondPickerView : View {
    @Binding var second: Int
    
    var body: some View {
        Picker("Second", selection: $second) {
            ForEach(0..<60) { Text("\($0)") }
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
            HourPickerView(hour: $hour)
            separatorTextView
            MinutePickerView(minute: $minute)
            separatorTextView
            SecondPickerView(second: $second)
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
