//
//  TimerModel.swift
//  TimerApp-Index App
//
//  Created by Sthuthi S on 01/10/25.
//

import Foundation

enum TimerModels {
    enum Request {
        case start
        case pause
        case reset
        case stop
        case setPickers(hour: Int, minute: Int, second: Int)
    }
    
    struct Response {
        let remaningTime: Int
        let isRunning: Bool
        let showPicker: Bool
        let hour: Int
        let minute: Int
        let second: Int
    }
    
    struct ViewModel {
        let timeString: String
        let isRunning: Bool
        let showPicker: Bool
        let hour: Int
        let minute: Int
        let second: Int
    }
}
