//
//  TimerInteractor.swift
//  TimerApp-Index App
//
//  Created by Sthuthi S on 04/10/25.
//

import Foundation

protocol TimerInteractorProtocol {
    func handle(_ request: TimerModels.Request)
}

final class TimerInteractor: TimerInteractorProtocol {
    var presenter: TimerPresentationLogic?
    
    private var hour: Int = 0
    private var minute: Int = 1
    private var second: Int = 0
    private var isRunning: Bool = false
    private var remainingTime: Int = 0
    private var showPicker: Bool = true
    private var timer: Timer?
    
    func handle(_ request: TimerModels.Request) {
        switch request {
        case .setPickers(let hour, let minute, let second):
            self.hour = hour
            self.minute = minute
            self.second = second
            self.remainingTime = hour * 3600 + minute * 60 + second
            self.showPicker = true
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
        print("Timer Started!")
        if remainingTime == 0 {
            remainingTime = hour * 3600 + minute * 60 + second
        }
        isRunning = true
        showPicker = false
        
        timer?.invalidate() // Invalidate any existing timer
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.remainingTime > 0 {
                self.remainingTime -= 1
                self.presentState()
            } else {
                self.timer?.invalidate()
                self.isRunning = false
                self.presentState()
            }
        }
    }
    func pauseTimer() {
        isRunning = false
        timer?.invalidate()
    }
    func resetTimer() {
        isRunning = false
        remainingTime = hour * 3600 + minute * 60 + second
        showPicker = false
        timer?.invalidate()
    }
    func stopTimer() {
        isRunning = false
        timer?.invalidate()
        remainingTime = 0
        showPicker = true
    }
    func presentState() {
        print("Present state timer started")
        let response = TimerModels.Response(
            remaningTime: remainingTime,
            isRunning: isRunning,
            showPicker: showPicker,
            hour: hour,
            minute: minute,
            second: second
        )
        
        Task { [weak self] in
            guard let presenter = self?.presenter else { return }
            await presenter.present(response)
        }
    }
    
    deinit {
        timer?.invalidate()
    }
}
