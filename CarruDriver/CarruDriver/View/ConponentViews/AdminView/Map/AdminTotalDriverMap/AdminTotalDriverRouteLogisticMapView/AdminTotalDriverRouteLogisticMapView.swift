//
//  d.swift
//  CarruDriver
//
//  Created by 이주훈 on 12/1/24.
//

import Combine
import SwiftUI

struct AdminTotalDriverRouteLogisticMapView: View {
    @EnvironmentObject var mainViewManager: MainViewManager
    @Binding var path: [MainScreen]
    @Bindable var viewModel: AdminTotalDriverRouteLogisticMapViewModel
    
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
                    Text("총 소요시간: \(viewModel.logistic.totalOperationTime)")
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
            
            VStack(alignment: .leading) {
                List(viewModel.logistic.stopOverList, id: \.self){ stopOver in
                    VStack(alignment: .leading, spacing: 8) {
                        VStack(alignment: .leading) {
                            Text("출발: \(stopOver.stopOverLocation)")
                            Text("물품명: \(stopOver.productName)")
                        }
                        
                        Text("비용 \(stopOver.price)원, 무게 \(stopOver.weight)kg")
                    }
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                
                VStack(alignment: .leading) {
                    Text("상세사항")
                        .font(.pretendard(size: 16, weight: .bold))
                    Text(viewModel.logistic.description)
                }
                .padding(.horizontal,20)
            }
//            .frame(maxHeight: 350, alignment: .bottom)
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
