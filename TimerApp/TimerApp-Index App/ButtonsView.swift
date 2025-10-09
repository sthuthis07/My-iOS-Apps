//
//  ButtonsView.swift
//  TimerApp-Index App
//
//  Created by Sthuthi S on 01/10/25.
//

import SwiftUI

struct ButtonsView: View {
    @ObservedObject private var timerViewModel: TimerViewModel
    
    init(vm: TimerViewModel) {
        self.timerViewModel = vm
    }
    
    var body: some View {
        HStack(spacing: 20) {
            Button {
                if !timerViewModel.isRunning {
                    timerViewModel.startTapped()
                } else {
                    timerViewModel.pauseTapped()
                }
            } label: {
                if timerViewModel.isRunning {
//                    Text("Pause")
                    Image(systemName: "pause.fill")
                        .frame(width: 20, height: 20)
                } else {
//                    Text("Start")
                    Image(systemName: "play.fill")
                        .frame(width: 20, height: 20)
                }
            }
            .buttonStyle(.borderedProminent)
            .tint((timerViewModel.isRunning) ? .yellow : .green)
            .opacity(0.75)
            Button {
                timerViewModel.resetTapped()
            } label: {
//                Text("Reset")
                Image(systemName: "arrow.counterclockwise")
                    .frame(width: 20, height: 20)
            }
            .buttonStyle(.borderedProminent)
            .opacity(0.75)
            Button {
                timerViewModel.stopTapped()
            } label: {
//                Text("Cancel")
                Image(systemName: "xmark")
                    .frame(width: 20, height: 20)
            }
            .buttonStyle(.borderedProminent)
            .tint(.red)
            .opacity(0.75)
        }
    }
}

#Preview {
    ButtonsView(vm: TimerViewModel())
}
