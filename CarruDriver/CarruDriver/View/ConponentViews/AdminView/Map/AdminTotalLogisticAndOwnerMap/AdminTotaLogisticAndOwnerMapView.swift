//
//  AdminTotalListMapView.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/26/24.
//

import Combine
import SwiftUI

struct AdminTotalLogisticAndOwnerMapView: View {
    @EnvironmentObject var mainViewManager: MainViewManager
    @Binding var path: [MainScreen]
    @Bindable var viewModel: AdminTotalLogisticAndOwnerMapViewModel
    
    @State var draw: Bool = true
    @State private var cancellables = Set<AnyCancellable>()
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "chevron.left")
                    .padding(.trailing, 12)
                    .onTapGesture {
                        path.removeLast()
                    }
                VStack(alignment: .leading) {
                    Text(viewModel.logistic.title)
                    Text("총 소요시간: \(viewModel.logistic.operationTime)")
                }
                Spacer()
            }
            .padding(.leading, 16)
            .background(.white)
            
            KakaoMapView(
                draw: $draw,
                logistics: $viewModel.logisticMapData,
                currentLocation: $viewModel.currentLocation,
                showPoiType: $viewModel.showPoiType,
                updateUIEvent: $viewModel.updateEvent
            )
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity
            )
            
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading) {
                    Text("도착지: \(viewModel.logistic.destinationLocation)")
                        .font(.pretendard(size: 20, weight: .bold))
                    Text("물품명: \(viewModel.logistic.productName)")
                        .font(.pretendard(size: 20, weight: .bold))
                    Text("비용 \(viewModel.logistic.price)원")
                }
                .padding(.horizontal, 20)
                
                
                VStack(alignment: .leading) {
                    Text("운송자")
                    Text(viewModel.logistic.driverName)
                    Text(viewModel.logistic.driverPhoneNumber)
                }
                .padding(.horizontal, 20)
                
                HStack(alignment: .center) {
                    Text("운송 상태")
                    Text(viewModel.logistic.status)
                        .font(.pretendard(size: 13, weight: .bold))
                        .frame(maxWidth: .infinity)
                        .frame(height: 30)
                        .foregroundStyle(.white)
                        .background(Color.appTypeColor)
                        .clipShape(.rect(cornerRadius: 10))
                }
                .padding(.horizontal, 20)
            }
            .frame(alignment: .bottom)
        }
        .onAppear {
            draw = true
        }
        .onDisappear {
            draw = false
        }
    }
}
