//
//  MatchedRouteListViewModel.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/5/24.
//

import Foundation
import Combine

@Observable
class MatchedRouteListViewModel {
    let logisticMatchingRepository = LogisticMatchingRepository()
    private var cancellables = Set<AnyCancellable>()
    
//    var sortPriceButtonTitle: String = "가격"
//    var filterRegionButtonTitle: String = "지역"
//    var sortOperationDistanceButtonTitle: String = "운행거리"
    
    var logistics: [Logistic]
    var maxWeight: Int
    var minWeight: Int
    var sortPrice: Int
    var sortOperationDistance: Int
    var warehouseKeyword: String
    
    init(
        logistics: [Logistic] = [],
        maxWeight: Int,
        minWeight: Int,
        sortPrice: Int = 0,
        sortOperationDistance: Int = 0,
        warehouseKeyword: String = ""
    ) {
        self.logistics = logistics
        self.maxWeight = maxWeight
        self.minWeight = minWeight
        self.sortPrice = sortPrice
        self.sortOperationDistance = sortOperationDistance
        self.warehouseKeyword = warehouseKeyword
        
        loadLogistics()
    }
    
    func loadLogistics() {
        logisticMatchingRepository
            .getLogisticMatching(
                matchConstraints: .init(
                    maxWeight: maxWeight,
                    minWeight: minWeight,
                    sortPrice: sortPrice,
                    sortOperationDistance: sortOperationDistance,
                    warehouseKeyword: warehouseKeyword
                )
            )
            .sink(receiveCompletion: {
                logger.checkComplition(message: "물류 리스트 받기", complition: $0)
            }, receiveValue: { logistics in
                self.logistics = logistics
            })
            .store(in: &cancellables)
    }
}
