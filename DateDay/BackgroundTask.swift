//
//  BackgroundTask.swift
//  DateDay
//
//  Created by Quentin Derouard on 14/05/2024.
//

import Foundation
import Combine

class BackgroundTask: ObservableObject {
    private var cancellable: AnyCancellable?
    
    init() {
        startDailyUpdate(task: { /* task to perform */ })
    }
    
    func startDailyUpdate(task: @escaping () -> Void) {
        let now = Date()
        let calendar = Calendar.current
        var nextUpdate = calendar.nextDate(after: now, matching: DateComponents(hour: 8), matchingPolicy: .nextTime)!
        
        if now >= nextUpdate {
            nextUpdate = calendar.date(byAdding: .day, value: 1, to: nextUpdate)!
        }
        
        let interval = nextUpdate.timeIntervalSince(now)
        cancellable = Timer.publish(every: interval, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                task()
                self.startDailyUpdate(task: task)
            }
    }
}

