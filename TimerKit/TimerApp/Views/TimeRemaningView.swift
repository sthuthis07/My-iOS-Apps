//
//  TimeRemaningView.swift
//  My-iOS-Apps
//
//  Created by Sthuthi S on 01/10/25.
//

import SwiftUI

struct TimeRemaningView: View {
    @ObservedObject var vm: TimerViewModel
    
    var body: some View {
        Text(vm.state.timeText)
            .font(.largeTitle)
    }
}

#Preview {
    TimeRemaningView(vm: TimerViewModel())
}
