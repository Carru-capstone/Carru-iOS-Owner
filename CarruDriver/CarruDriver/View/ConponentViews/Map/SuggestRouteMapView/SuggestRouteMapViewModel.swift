//
//  SuggestRouteMapViewModel.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/6/24.
//

import Foundation
import Combine


struct RouteItem: Hashable {
    let locationName: String
    let productName: String
    let price: Int
    let weight: Int
    let destinationName: String // 도착지 이름 추가
}


@Observable
class SuggestRouteMapViewModel {
    var title: String = "Suggest Route"
    var description: String = "Suggest Route description"
    
    var route: RoutePredict
    var logistics: [RouteItem] = []
    var logisticMapData: [LogisticMapData]? = []
    var currentLocation: Location = LocationManager.shared.myLocation
    var showPoiType: KakaoMapView.ShowPoiType = .nothing
    var updateEvent: Bool = false
    
    private let reservationRepository = ReservationRepository()
    private var cancellables = Set<AnyCancellable>()
    
    init(routePredict: RoutePredict) {
        self.route = routePredict
        setRouteData()
    }
    
    private func setRouteData() {
        logistics = route.toRouteItemList()
    }
    
    func showMap() {
        self.logisticMapData = route.toLogisticMapData()
        showPoiType = .showLogisticsPointsAndMyLocation
    }
}
