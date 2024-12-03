//
//  Date+Format.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/18/24.
//

import Foundation

extension Date {
    func toString() -> String {
        let formatter = DateFormatter()

        formatter.dateFormat = "yyyy/MM/dd HH:mm" // 원하는 포맷 설정
        formatter.locale = Locale(identifier: "en_US_POSIX") // 일관된 결과를 위해 설정
        formatter.timeZone = TimeZone.current // 현지 시간대 설정

        let formattedDate = formatter.string(from: self)
        
        return formattedDate
    }
    
    func diffFromNow() -> String {
            let now = Date()
            let difference = abs(self.timeIntervalSince(now))
            
            let hours = Int(difference) / 3600
            let minutes = (Int(difference) % 3600) / 60
            let seconds = Int(difference) % 60
            
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }
}
