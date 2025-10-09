//
//  TimerViewModel.swift
//  TimerApp-Index App
//
//  Created by Sthuthi S on 04/10/25.
//

import Foundation

@MainActor
final class TimerViewModel: ObservableObject, TimerDisplayLogic {
    @Published var timeText: String = "00:01:00"
    @Published var isRunning: Bool = false
    @Published var showPicker: Bool = true
    @Published var hours: Int = 0
    @Published var minutes: Int = 1
    @Published var seconds: Int = 0
    
    var interactor: TimerInteractorProtocol?
    
    private var timer: Timer?
    
    private var totalSeconds: Int {
        get { hours * 3600 + minutes * 60 + seconds }
        set {
            let t = max(0, newValue)
            hours = t / 3600
            minutes = (t % 3600) / 60
            seconds = t % 60
            updateTimeText()
        }
    }
    
    init() {
        updateTimeText()
    }
    
    func startTapped() {
        guard let interactor else {
            print("Interactor is nil")
            return
        }
        print("Timer started - vm")
        interactor
            .handle(.setPickers(hour: hours, minute: minutes, second: seconds))
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
        guard let interactor else { return }
        self.hours = hour
        self.minutes = minute
        self.seconds = second
        interactor
            .handle(.setPickers(hour: hour, minute: minute, second: second))
    }
    
    func display(_ viewModel: TimerModels.ViewModel) {
        self.showPicker = viewModel.showPicker
        self.timeText = viewModel.timeString
        self.isRunning = viewModel.isRunning
        self.hours = viewModel.hour
        self.minutes = viewModel.minute
        self.seconds = viewModel.second
    }
    
    private func updateTimeText() {
        timeText = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
