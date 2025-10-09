//
//  TimerPresenter.swift
//  TimerApp-Index App
//
//  Created by Sthuthi S on 02/10/25.
//

import Foundation

@MainActor
protocol TimerPresentationLogic: AnyObject {
    func present(_ response: TimerModels.Response)
}

@MainActor
protocol TimerDisplayLogic: AnyObject {
    func display(_ viewModel: TimerModels.ViewModel)
}

@MainActor
final class TimerPresenter: TimerPresentationLogic {
    weak var view: TimerDisplayLogic?
    
    private func timeString(from seconds: Int) -> String {
        let h = seconds / 3600
        let m = (seconds % 3600) / 60
        let s = seconds % 60
        return String(format: "%02d:%02d:%02d", h, m, s)
    }
    
    func present(_ response: TimerModels.Response) {
        let total = response.remaningTime
        let h = total / 3600
        let m = (total % 3600) / 60
        let s = total % 60
        let vm = TimerModels.ViewModel(
            timeString: timeString(from: total),
            isRunning: response.isRunning,
            showPicker: response.showPicker,
            hour: h,
            minute: m,
            second: s
        )
        
        view?.display(vm)
    }
}
