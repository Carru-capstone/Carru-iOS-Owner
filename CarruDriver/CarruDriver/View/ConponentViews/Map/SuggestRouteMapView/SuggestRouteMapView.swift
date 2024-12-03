//
//  SuggestRouteMapView.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/6/24.
//

import SwiftUI

struct SuggestRouteMapView: View {
    @EnvironmentObject var mainViewManager: MainViewManager
    @Binding var path: [MainScreen]
    @Bindable var viewModel: SuggestRouteMapViewModel
    @State var draw: Bool = true
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "chevron.left")
                    .padding(.trailing, 12)
                    .onTapGesture {
                        path.removeLast()
                    }
                VStack(alignment: .leading) {
                    Text(viewModel.title)
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
                List(viewModel.logistics, id: \.self) { logistic in
                    VStack(alignment: .leading, spacing: 8) {
                        VStack(alignment: .leading) {
                            Text("출발: \(logistic.locationName)\n도착: \(logistic.destinationName)")
                            Text("물품명: \(logistic.productName)")
                        }
                        
                        Text("비용 \(logistic.price)원, 무게 \(logistic.weight)kg")
                    }
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                
                VStack(alignment: .leading) {
                    Text("상세사항")
                        .font(.pretendard(size: 16, weight: .bold))
                    Text("\(viewModel.route.description)")
                }
                .padding(.horizontal,20)
                
                CarruButton {
                    mainViewManager.infoAlertViewModel = .init(
                        title: "알림",
                        description: "예약하시겠습니까?",
                        cancelAction: {
                            logger.printOnDebug("nothing")
                        },
                        confirmAction: {
                            logger.printOnDebug("예약 시도")
                        }
                    )
                } label: {
                    Text("예약하기")
                }
            }
            .frame(maxHeight: 350, alignment: .bottom)
            
            Text("\(viewModel.updateEvent)")
                .hidden()
        }
        .onAppear {
            draw = true
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                viewModel.showMap()
            }
        }
        .onDisappear {
            draw = false
        }
    }
}
