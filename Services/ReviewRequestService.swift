//
//  ReviewRequestService.swift
//  iOS-Test
//
//  Created by Oleksandr Karpenko on 15.08.2024.
//

import Foundation

final class ReviewRequestService {
    private let minimumUsageTime: TimeInterval = 60 * 10 // 10 minutes
    private let reviewRequestInterval: TimeInterval = 60 * 60 * 24 * 3 // 3 days
    private let lastReviewRequestKey = "lastReviewRequestDate"
    
    func canRequestReview(hasOpenedDummyScreen: Bool) -> Bool {
        guard
            hasOpenedDummyScreen,
            Services.sessionTracking.hasCompletedTwoSessions(),
            Services.sessionTracking.getTotalUsageTime() >= minimumUsageTime,
            canRequestReview()
        else { return false }
        
        saveLastReviewRequestDate()
        return true
    }
    
    private func canRequestReview() -> Bool {
        let now = Date()
        
        if let lastReviewRequestDate = getLastReviewRequestDate() {
            return now.timeIntervalSince(lastReviewRequestDate) >= reviewRequestInterval
        } else {
            return true
        }
    }
    
    private func saveLastReviewRequestDate() {
        UserDefaults.standard.set(Date(), forKey: lastReviewRequestKey)
    }
    
    private func getLastReviewRequestDate() -> Date? {
        UserDefaults.standard.object(forKey: lastReviewRequestKey) as? Date
    }
}
