//
//  Logger.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/4/24.
//

import Foundation
import Combine

typealias logger = Logger

final class Logger {
    // JSON raw데이터 확인할 때만 true로 바꿔서 사용
    static var isJSONPrintOnNetworking: Bool = false
    
    static func printOnDebug(
        _ text: String,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
#if DEBUG
        var result = ""
        
        let fileName = file.components(separatedBy: "/").last
        
        result += "\(fileName ?? "Some file")".padding(toLength: 30, withPad: " ", startingAt: 0)
        result += " | line:\(line)".padding(toLength: 15, withPad: " ", startingAt: 0)
        result += " | \(function)".padding(toLength: 50, withPad: " ", startingAt: 0)
        result += " | \(text)"
        
        print(result)
#endif
    }
    
    static func checkComplition(message: String, complition:  Subscribers.Completion<any Error>) {
        switch complition {
        case .finished:
            logger.printOnDebug("\(message) 성공")
        case .failure(let error):
            logger.printOnDebug("\(message) 실패 \(error.localizedDescription)")
        }
    }
    
    static func printDataToJson(_ data: Data) {
        guard isJSONPrintOnNetworking else { return }
        
        
        if let jsonObject = try? JSONSerialization.jsonObject(
            with: data,
            options: []
        ) as? [String: Any] {
            logger.printOnDebug("JSON RAW 데이터:\n\(jsonObject)")
        } else {
            logger.printOnDebug("성공 JSON 디코딩 실패 ")
        }
    }
}
