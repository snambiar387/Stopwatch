//
//  ContentView.swift
//  StopWatch
//
//  Created by Sreehari M Nambiar on 13/05/20.
//  Copyright © 2020 Sreehari M Nambiar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = StopwatchViewModel()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 40, content: {
                Text(viewModel.elapsedTime)
                    .font(.system(size: 44, weight: .heavy, design: .default))
                    .multilineTextAlignment(.center)
                HStack(alignment: .center, spacing: 20) {
                    Button(viewModel.buttonText) {
                        self.viewModel.buttonTapped()
                    }
                    Button("Lap") {
                        self.viewModel.lap()
                    }
                    .disabled(viewModel.isLapButtonDisabled)
                }
                List(viewModel.laps, id: \.self) { time in
                    Text(time)
                }
            })
                .navigationBarTitle("Stopwatch")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

