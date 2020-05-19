//
//  Clock.swift
//  StopWatch
//
//  Created by Sreehari M Nambiar on 17/05/20.
//  Copyright © 2020 Sreehari M Nambiar. All rights reserved.
//

import Foundation
import Combine

enum State {
    case notRunning
    case running
}

final class Clock {
    private let timeInterval: TimeInterval
    private var cancellableTimer: AnyCancellable!

    @Published var timeElapsed = 0
    
    required init(timerInterval: TimeInterval) {
        self.timeInterval = timerInterval
    }
    
    
    func start() {
        
        cancellableTimer = Timer.publish(every: timeInterval, on: RunLoop.main, in: .default)
        .autoconnect()
        .sink(receiveValue: { (_) in
            self.timeElapsed += 1
        })
    }
    
    func stop() {
        timeElapsed = 0
        cancellableTimer?.cancel()
    }
}

