//
//  TimerViewModel.swift
//  My-iOS-Apps
//
//  Created by Sthuthi S on 04/10/25.
//

import Foundation
import Combine

struct TimerViewState {
    var timeText: String = "00:01:00"
    var isRunning: Bool = false
    var showPicker: Bool = true
    var hours: Int = 0
    var minutes: Int = 1
    var seconds: Int = 0

    func updated(
        timeText: String? = nil,
        isRunning: Bool? = nil,
        showPicker: Bool? = nil,
        hours: Int? = nil,
        minutes: Int? = nil,
        seconds: Int? = nil
    ) -> TimerViewState {
        var s = self
        if let isRunning = isRunning { s.isRunning = isRunning }
        if let showPicker = showPicker { s.showPicker = showPicker }
        if let hours = hours { s.hours = hours }
        if let minutes = minutes { s.minutes = minutes }
        if let seconds = seconds { s.seconds = seconds }
        let computed = String(format: "%02d:%02d:%02d", s.hours, s.minutes, s.seconds)
        s.timeText = timeText ?? computed
        return s
    }

    func withHours(_ hours: Int) -> TimerViewState { updated(hours: hours) }
    func withMinutes(_ minutes: Int) -> TimerViewState { updated(minutes: minutes) }
    func withSeconds(_ seconds: Int) -> TimerViewState { updated(seconds: seconds) }
}

@MainActor
final class TimerViewModel: ObservableObject, TimerDisplayLogic {
    @Published var state = TimerViewState()

    var interactor: TimerInteractorProtocol?
    
    private var timer: Timer?
    
    private var totalSeconds: Int {
        get { state.hours * 3600 + state.minutes * 60 + state.seconds }
        set {
            let t = max(0, newValue)
            var s = state
            s.hours = t / 3600
            s.minutes = (t % 3600) / 60
            s.seconds = t % 60
            s.timeText = String(format: "%02d:%02d:%02d", s.hours, s.minutes, s.seconds)
            state = s
        }
    }
    
    init() {
        state.timeText = String(format: "%02d:%02d:%02d", state.hours, state.minutes, state.seconds)
    }
    
    func startTapped() {
        guard let interactor else {
            debugPrint("Interactor is nil")
            return
        }
        debugPrint("Timer started - vm")
        interactor.handle(.setPickers(hour: state.hours, minute: state.minutes, second: state.seconds))
        interactor.handle(.start)
    }
    
    func pauseTapped() {
        guard let interactor else { return }
        interactor.handle(.pause)
    }
    
    func resetTapped() {
        guard let interactor else { return }
        interactor.handle(.reset)
    }
    
    func stopTapped() {
        guard let interactor else { return }
        interactor.handle(.stop)
    }
    
    func setPickers(hour: Int, minute: Int, second: Int) {
        state = state.updated(hours: hour, minutes: minute, seconds: second)
        interactor?.handle(.setPickers(hour: hour, minute: minute, second: second))
    }
    
    func display(_ viewModel: TimerModels.ViewModel) {
        state = state.updated(
            timeText: viewModel.timeString,
            isRunning: viewModel.isRunning,
            showPicker: viewModel.showPicker,
            hours: viewModel.hour,
            minutes: viewModel.minute,
            seconds: viewModel.second
        )
    }
}
