//
//  LogisticsMatchingReservationDetail.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/27/24.
//

import Foundation

struct RouteMatchingReservationDetails {
    let listId: Int
    let status: String
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
    let startTime: Date
    let stopOverCount: Int
    let stopOverList: [StopOver]
    
    struct StopOver {
        let stopOverId: Int
        let stopOverLocation: String
        let stopOverLocationLatitude: Double
        let stopOverLocationLongitude: Double
        let stopOverDestination: String
        let stopOverDestinationLatitude: Double
        let stopOverDestinationLongitude: Double
        let productName: String
        let weight: Int
        let price: Int
    }
    
    init(
        listId: Int,
        status: String,
        departureLocation: String,
        departureLatitude: Double,
        departureLongitude: Double,
        destinationLocation: String,
        destinationLatitude: Double,
        destinationLongitude: Double,
        totalWeight: Int,
        totalPrice: Int,
        totalOperationDistance: Int,
        totalOperationTime: Int,
        startTime: Date,
        stopOverCount: Int,
        stopOverList: [StopOver]
    ) {
        self.listId = listId
        self.status = status
        self.departureLocation = departureLocation
        self.departureLatitude = departureLatitude
        self.departureLongitude = departureLongitude
        self.destinationLocation = destinationLocation
        self.destinationLatitude = destinationLatitude
        self.destinationLongitude = destinationLongitude
        self.totalWeight = totalWeight
        self.totalPrice = totalPrice
        self.totalOperationDistance = totalOperationDistance
        self.totalOperationTime = totalOperationTime
        self.startTime = startTime
        self.stopOverCount = stopOverCount
        self.stopOverList = stopOverList
    }

    init() {
        self.listId = 0
        self.status = ""
        self.departureLocation = ""
        self.departureLatitude = 0.0
        self.departureLongitude = 0.0
        self.destinationLocation = ""
        self.destinationLatitude = 0.0
        self.destinationLongitude = 0.0
        self.totalWeight = 0
        self.totalPrice = 0
        self.totalOperationDistance = 0
        self.totalOperationTime = 0
        self.startTime = Date()
        self.stopOverCount = 0
        self.stopOverList = []
    }
    
    func toLogisticMapData() -> LogisticMapData {
          return LogisticMapData(
              departureLocation: departureLocation,
              departureLatitude: departureLatitude,
              departureLongitude: departureLongitude,
              destinationLocation: destinationLocation,
              destinationLatitude: destinationLatitude,
              destinationLongitude: destinationLongitude
          )
      }
}



