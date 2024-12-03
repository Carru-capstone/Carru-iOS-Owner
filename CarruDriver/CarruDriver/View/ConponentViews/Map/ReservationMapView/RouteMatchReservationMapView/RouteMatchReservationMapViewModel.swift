//
//  RouteMatchReservationMapViewModel.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/21/24.
//

import Foundation

@Observable
class RouteMatchReservationMapViewModel {
    var logistics: [Logistic]? = nil
    
    var logisticMapData: [LogisticMapData]? = nil
    var currentLocation: Location = LocationManager.shared.myLocation
    var showPoiType: KakaoMapView.ShowPoiType = .nothing
    var updateEvent: Bool = false
    
    var reservation: RouteReservation
    
    var dateDescription: String  {
        return "날짜?"
    }
    
    var routeDescription: String {
        return "출발: \(reservation.departureLocation) \n도착: \(reservation.destinationLocation) "
    }
    
    var totalTime: String {
//        return "운행시간: \(reservation.operatio                                     nTime)분"
        return ""
    }
    
    var description: String {
        return "무게: \(reservation.totalWeight)톤, 비용: \(reservation.totalPrice)원, 운행거리: \(reservation.totalOperationDistance)km, 운행시간: \(reservation.totalOperationTime)분"
    }
    
    init(reservation: RouteReservation) {
        self.reservation = reservation
        loadReservationDetail()
    }
    
    func loadReservationDetail() {
        
    }
    
    func showMap() {
        
    }
}
