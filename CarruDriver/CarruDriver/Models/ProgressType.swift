//
//  File.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/26/24.
//

import Foundation

enum ProgressType: String, CaseIterable, Identifiable {
    case todo = "TODO"
    case inProgress = "IN PROGRESS"
    case finished = "FINISHED"
    
    var statusID: Int {
        switch self {
        case .todo: return 0 
        case .inProgress: return 1
        case .finished: return 3
        }
    }
    
    // Identifiable
    var id: Int {
        return statusID
    }
}
