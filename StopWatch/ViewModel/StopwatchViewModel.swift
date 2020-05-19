//
//  StopwatchViewModel.swift
//  StopWatch
//
//  Created by Sreehari M Nambiar on 17/05/20.
//  Copyright © 2020 Sreehari M Nambiar. All rights reserved.
//

import Foundation
import Combine

final class StopwatchViewModel: ObservableObject {
    
    @Published private(set) var elapsedTime: String = ""
    @Published private(set) var laps: [String] = []
    @Published private(set) var buttonText: String = "Start"
    @Published private(set) var isLapButtonDisabled = true
    private var cancellable: AnyCancellable!
    private var clock = Clock(timerInterval: 1)

    private var state: State  = .notRunning {
        didSet {
            switch state {
            case .running:
                updateToRunningState()
            case .notRunning:
                updateToNotRunningState()
            }
        }
    }
    
    deinit {
        clock.stop()
        cancellable.cancel()
    }
    
    init() {
        cancellable = clock.$timeElapsed
            .map({ $0.description })
            .assign(to: \StopwatchViewModel.elapsedTime, on: self)
    }
    
    private func updateToRunningState() {
        clock.start()
        buttonText = "Stop"
        isLapButtonDisabled = false
    }
    
    private func updateToNotRunningState() {
        clock.stop()
        buttonText = "Start"
        isLapButtonDisabled = true
    }

    func buttonTapped() {
        state = (state == .running) ? .notRunning : .running
    
    }
    
    func lap() {
        laps.append(elapsedTime)
    }
}
