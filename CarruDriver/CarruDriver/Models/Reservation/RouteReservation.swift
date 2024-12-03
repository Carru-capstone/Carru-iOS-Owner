//
//  RouteReservation.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/20/24.
//

import Foundation

struct RouteReservation: Hashable {
    let listId: Int
    let startTime: String
    let departureLocation: String
    let departureLatitude: Double
    let departureLongitude: Double
    let destinationLocation: String
    let destinationLatitude: Double
    let destinationLongitude: Double
    let totalWeight: Int
    let totalPrice: Int
    let totalOperationDistance: Int
    let totalOperationTime: Int
    
    var title: String {
        return "출발지: \(departureLocation)\n도착지: \(destinationLocation)"
    }
    
    var description: String {
        return "총무게: \(totalWeight)톤, 총비용: \(totalPrice)원\n총운행거리: \(totalOperationDistance)km, 총운행시간: \(totalOperationTime)분"
    }
}
