//
//  TimeRemaningView.swift
//  TimerApp-Index App
//
//  Created by Sthuthi S on 01/10/25.
//

import SwiftUI

struct TimeRemaningView: View {
    @ObservedObject var vm: TimerViewModel
    
    var body: some View {
        Text(vm.timeText)
            .font(.largeTitle)
    }
}

#Preview {
    TimeRemaningView(vm: TimerViewModel())
}
