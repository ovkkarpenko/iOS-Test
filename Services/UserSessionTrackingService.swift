//
//  UserSessionTrackingService.swift
//  iOS-Test
//
//  Created by Oleksandr Karpenko on 15.08.2024.
//

import UIKit
import Foundation

final class UserSessionTrackingService {
    private let sessionDurationThreshold: TimeInterval = 60 * 60 // 1 hour
    private let foregroundNotification = UIApplication.willEnterForegroundNotification
    private let backgroundNotification = UIApplication.didEnterBackgroundNotification
    private let sessionCountKey = "sessionCount"
    
    private var totalUsageTime: TimeInterval = 0
    private var sessionStartTime: Date?
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterForeground), name: foregroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appDidEnterBackground), name: backgroundNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - App Lifecycle Handling
    
    @objc private func appWillEnterForeground() {
        if let startTime = sessionStartTime {
            if Date().timeIntervalSince(startTime) > sessionDurationThreshold {
                sessionStartTime = Date()
                
                var sessionCount = UserDefaults.standard.integer(forKey: sessionCountKey)
                sessionCount += 1
                UserDefaults.standard.set(sessionCount, forKey: sessionCountKey)
            }
        } else {
            sessionStartTime = Date()
        }
    }
    
    @objc private func appDidEnterBackground() {
        if let startTime = sessionStartTime {
            totalUsageTime += Date().timeIntervalSince(startTime)
            sessionStartTime = nil
        }
    }
    
    // MARK: - Public Methods
    
    func getTotalUsageTime() -> TimeInterval {
        totalUsageTime
    }
    
    func hasCompletedTwoSessions() -> Bool {
        UserDefaults.standard.integer(forKey: sessionCountKey) >= 2
    }
}
