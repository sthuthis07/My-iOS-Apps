//
//  ButtonsView.swift
//  My-iOS-Apps
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
            playPauseButton
            resetButton
            cancelButton
        }
    }
    
    // MARK: - Buttons
    /// Play/Pause Button
    private var playPauseButton: some View {
        Button {
            if !timerViewModel.state.isRunning {
                timerViewModel.startTapped()
            } else {
                timerViewModel.pauseTapped()
            }
        } label: {
            if timerViewModel.state.isRunning {
                Image(systemName: "pause.fill")
                    .frame(width: 20, height: 20)
            } else {
                Image(systemName: "play.fill")
                    .frame(width: 20, height: 20)
            }
        }
        .buttonStyle(.borderedProminent)
        .tint((timerViewModel.state.isRunning) ? .yellow : .green)
        .opacity(0.75)
    }
    
    /// Reset Button
    private var resetButton: some View {
        Button {
            timerViewModel.resetTapped()
        } label: {
            Image(systemName: "arrow.counterclockwise")
                .frame(width: 20, height: 20)
        }
        .buttonStyle(.borderedProminent)
        .opacity(0.75)
    }
    
    /// Cancel Button
    private var cancelButton: some View {
        Button {
            timerViewModel.stopTapped()
        } label: {
            Image(systemName: "xmark")
                .frame(width: 20, height: 20)
        }
        .buttonStyle(.borderedProminent)
        .tint(.red)
        .opacity(0.75)
    }
}

#Preview {
    ButtonsView(vm: TimerViewModel())
}
