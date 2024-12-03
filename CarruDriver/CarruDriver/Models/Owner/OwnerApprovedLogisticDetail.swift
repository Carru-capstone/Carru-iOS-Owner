//
//  OwnerApprovedLogisticDetail.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/27/24.
//

import Foundation

struct OwnerApprovedLogisticDetail {
    let productName: String
    let warehouseName: String
    let warehouseLat: Int
    let warehouseLng: Int
    let destination: String
    let destinationLat: Int
    let destinationLng: Int
    let weight: Int
    let price: Int
    let operationDistance: Int
    let operationTime: Int
    let transporterName: String
    let transporterPhoneNumber: String
    
    
    var title: String {
        return "\(warehouseName) | \(destination)"
    }
    
    func toLogisticMapData() -> LogisticMapData {
        return .init(
            departureLocation: warehouseName,
            departureLatitude: Double(warehouseLat),
            departureLongitude: Double(warehouseLng),
            destinationLocation: destination,
            destinationLatitude: Double(destinationLat),
            destinationLongitude: Double(destinationLng)
        )
    }
}
