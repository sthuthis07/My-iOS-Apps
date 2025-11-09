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
        if viewModel.state
            .showPicker {
            CustomTimePicker(
                hour: Binding<Int>(
                    get: { viewModel.state.hours },
                    set: { viewModel.setPickers(hour: $0, minute: viewModel.state.minutes, second: viewModel.state.seconds) }
                ),
                minute: Binding<Int>(
                    get: { viewModel.state.minutes },
                    set: { viewModel.setPickers(hour: viewModel.state.hours, minute: $0, second: viewModel.state.seconds) }
                ),
                second: Binding<Int>(
                    get: { viewModel.state.seconds },
                    set: { viewModel.setPickers(hour: viewModel.state.hours, minute: viewModel.state.minutes, second: $0) }
                )
            )
        } else {
            TimeRemaningView(vm: viewModel)
        }
    }
}

#Preview {
    TimerView()
}
