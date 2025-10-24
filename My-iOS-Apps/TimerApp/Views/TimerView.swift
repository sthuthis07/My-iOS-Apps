//
//  TimerView.swift
//  My-iOS-Apps
//
//  Created by Sthuthi S on 01/10/25.
//

import SwiftUI

struct TimerView: View {
    @StateObject var viewModel: TimerViewModel
    
    init() {
        let vm = TimerViewModel()
        let interactor = TimerInteractor()
        let presenter = TimerPresenter()
        
        interactor.presenter = presenter
        presenter.view = vm
        vm.interactor = interactor
        
        _viewModel = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            TimerPickerView(viewModel: viewModel)
            ButtonsView(vm: viewModel)
        }
    }
}

struct TimerPickerView: View {
    
    @StateObject var viewModel: TimerViewModel
    
    var body: some View {
        if viewModel.showPicker {
            CustomTimePicker(
                hour: $viewModel.hours,
                minute: $viewModel.minutes,
                second: $viewModel.seconds
            )
        } else {
            TimeRemaningView(vm: viewModel)
        }
    }
}

#Preview {
    TimerView()
}
