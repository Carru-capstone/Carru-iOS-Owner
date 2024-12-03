//
//  String+Date_ISO_8601.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/15/24.
//

import Foundation

extension String {
    func timeDiffFromISO8601() -> String {
        guard let targetDate = toDateFromISO8601() else { return "00:00:00" }
        
        let currentDate = Date()
        let timeInterval = targetDate.timeIntervalSince(currentDate)
        
        if timeInterval <= 0 {
            return "00:00:00" // 이미 지난 시간
        }
        
        // 시간, 분, 초 계산
        let hours = Int(timeInterval) / 3600
        let minutes = (Int(timeInterval) % 3600) / 60
        let seconds = Int(timeInterval) % 60
        
        // 형식화된 문자열 반환
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    /// ISO 8601 스타일 String을 Date로 변환
    func toDateFromISO8601() -> Date? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter.date(from: self)
    }
}
