//
//  TimerInteractor.swift
//  My-iOS-Apps
//
//  Created by Sthuthi S on 04/10/25.
//

import Foundation

protocol TimerInteractorProtocol {
    func handle(_ request: TimerModels.Request)
}

final class TimerInteractor: TimerInteractorProtocol {
    var presenter: TimerPresentationLogic?
    
    // Adding single source of truth for state management
    private struct State {
        var hour: Int = 0
        var minute: Int = 1
        var second: Int = 0
        var isRunning: Bool = false {
            didSet {
                if !isRunning {
                    timer?.invalidate()
                }
            }
        }
        var remainingTime: Int = 0
        var showPicker: Bool = true
        private var timer: Timer?
        
        init(
            hour: Int = 0,
            minute: Int = 1,
            second: Int = 0,
            isRunning: Bool = false,
            remainingTime: Int = 0,
            showPicker: Bool = true
        ) {
            self.hour = hour
            self.minute = minute
            self.second = second
            self.isRunning = isRunning
            self.remainingTime = remainingTime
            self.showPicker = showPicker
        }
        
        mutating func setTimerAction(action: @escaping (Timer) -> Void ) {
            timer?.invalidate()
            timer = Timer
                .scheduledTimer(
                    withTimeInterval: 1,
                    repeats: true,
                    block: action
                )
        }
        
    }
    
    private var state = State()
//    private var timer: Timer?
    
    func handle(_ request: TimerModels.Request) {
        switch request {
        case .setPickers(let hour, let minute, let second):
            let rem = hour * 3600 + minute * 60 + second
            state = State(
                hour: hour,
                minute: minute,
                second: second,
                isRunning: state.isRunning,
                remainingTime: rem,
                showPicker: true
            )
            presentState()
        case .start:
            startTimerIfNeeded()
            presentState()
        case .pause:
            pauseTimer()
            presentState()
        case .reset:
            resetTimer()
            presentState()
        case .stop:
            stopTimer()
            presentState()
        }
    }
    
    func startTimerIfNeeded() {
        debugPrint("Timer Started!")
        if state.remainingTime == 0 {
            state.remainingTime = state.hour * 3600 + state.minute * 60 + state.second
        }
        state.isRunning = true
        state.showPicker = false
        state.setTimerAction { [weak self] _ in
            guard let self = self else { return }
            if self.state.remainingTime > 0 {
                self.state.remainingTime -= 1
                self.presentState()
            } else {
                self.state.isRunning = false
                self.presentState()
            }
        }
    }
    func pauseTimer() {
        state.isRunning = false
    }
    func resetTimer() {
        state.isRunning = false
        state.remainingTime = state.hour * 3600 + state.minute * 60 + state.second
        state.showPicker = false
    }
    func stopTimer() {
        state.isRunning = false
        state.remainingTime = 0
        state.showPicker = true
    }
    func presentState() {
        debugPrint("Present state timer started")
        let response = TimerModels.Response(
            remaningTime: state.remainingTime,
            isRunning: state.isRunning,
            showPicker: state.showPicker,
            hour: state.hour,
            minute: state.minute,
            second: state.second
        )
        
        Task { [weak self] in
            guard let presenter = self?.presenter else { return }
            await presenter.present(response)
        }
    }
    deinit {
        state.isRunning = false
    }
}
