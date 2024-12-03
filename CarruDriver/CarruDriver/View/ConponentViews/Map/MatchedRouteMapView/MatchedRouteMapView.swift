//
//  MatchedRouteMapView.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/18/24.
//

import Combine
import SwiftUI

struct MatchedRouteMapView: View {
    @EnvironmentObject var mainViewManager: MainViewManager
    @Binding var path: [MainScreen]
    @Bindable var viewModel: MatchedRouteMapViewModel
    
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
                    Text(viewModel.title)
                    Text("총 소요시간: \(viewModel.operationTime)")
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
                    Text("물품명: \(viewModel.category)")
                        .font(.pretendard(size: 20, weight: .bold))
                    Text("비용 \(viewModel.price)원")
                }
                .padding(.horizontal, 20)
                
                Text("도착지: \(viewModel.destination)")
                    .font(.pretendard(size: 20, weight: .bold))
                    .padding(.horizontal, 20)
                
                VStack(alignment: .leading) {
                    Text("상세사항")
                        .font(.pretendard(size: 16, weight: .bold))
                    Text(viewModel.description)
                }
                .padding(.horizontal, 20)
                
                CarruButton {
                    mainViewManager.infoAlertViewModel = .init(
                        title: "알림",
                        description: "예약하시겠습니까?",
                        cancelAction: {
                            logger.printOnDebug("nothing")
                        },
                        confirmAction: {
                            logger.printOnDebug("예약 시도")
                            
                            viewModel.reservation()
                                .sink(
                                    receiveValue: { isSuccess in
                                        mainViewManager.infoAlertViewModel = .init(
                                            title: "알림",
                                            description: "예약 \(isSuccess ? "성공" : "실패")",
                                            cancelAction: nil,
                                            confirmAction: nil
                                        )
                                    }
                                )
                                .store(in: &cancellables)
                        }
                    )
                } label: {
                    Text("예약하기")
                }
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
