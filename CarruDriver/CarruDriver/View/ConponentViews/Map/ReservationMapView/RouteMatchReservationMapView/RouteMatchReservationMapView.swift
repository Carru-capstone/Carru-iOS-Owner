//
//  RouteMatchReservationMapView.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/21/24.
//

import SwiftUI

struct RouteMatchReservationMapView: View {
    @EnvironmentObject var mainViewManager: MainViewManager
    @Binding var path: [MainScreen]
    @Bindable var viewModel: RouteMatchReservationMapViewModel
    var mapType: ReservationsViewModel.ProcessSegment
    
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
                    Text(viewModel.dateDescription)
                    Text(viewModel.routeDescription)
                    Text(viewModel.totalTime)
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
                List(viewModel.logistics ?? [], id: \.self) { logistic in
                    VStack(alignment: .leading, spacing: 8) {
                        VStack(alignment: .leading) {
                            Text("경유지: \(logistic.departureLocation)")
                            Text("물품명: \(logistic.productName ?? "없음")")
                        }
                        
                        Text(logistic.description)
                    }
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                
                VStack(alignment: .leading) {
                    Text("상세사항")
                        .font(.pretendard(size: 16, weight: .bold))
                    Text(viewModel.description)
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)
                
                HStack {
                    switch mapType {
                    case .todo:
                        CarruButton {
                            mainViewManager.infoAlertViewModel = .init(
                                title: "알림",
                                description: "운송을 시작하시겠습니까?",
                                cancelAction: {
                                    logger.printOnDebug("nothing")
                                },
                                confirmAction: {
                                    logger.printOnDebug("운송 시작 로직")
                                }
                            )
                        } label: {
                            Text("운송시작")
                        }
                    case .inProgress:
                        HStack {
                            Button {
                                
                            } label: {
                                Text("TODO로 변경")
                                    .font(.pretendardCaption)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 40)
                                    .clipShape(.rect(cornerRadius: 10))
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.appTypeColor, lineWidth: 1.8)
                                    )
                            }
                            
                            Button {
                                
                            } label: {
                                Text("운송 종료")
                                    .font(.pretendardCaption)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 40)
                                    .foregroundStyle(.white)
                                    .background(Color.appTypeColor)
                                    .clipShape(.rect(cornerRadius: 10))
                            }
                        }
                        .padding(.bottom, 12)
                        
                    case .finished:
                        Text("운송 상태")
                            .font(.pretendard(size: 16, weight: .bold))
                        Text("FINISHED")
                            .font(.pretendard(size: 12, weight: .bold))
                            .frame(maxWidth: .infinity)
                            .frame(width: 70, height: 30)
                            .foregroundStyle(.white)
                            .background(Color.appTypeColor)
                            .clipShape(.rect(cornerRadius: 10))
                    }
                }
            }
            .frame(maxHeight: 350, alignment: .bottom)
//            .frame(alignment: .bottom)
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
