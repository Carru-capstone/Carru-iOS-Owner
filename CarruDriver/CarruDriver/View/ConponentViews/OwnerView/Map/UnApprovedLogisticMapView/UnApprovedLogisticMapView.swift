//
//  UnApprovedLogisticMapView.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/25/24.
//

import SwiftUI

struct UnApprovedLogisticMapView: View {
    @EnvironmentObject var mainViewManager: MainViewManager
    @Binding var path: [MainScreen]
    @Bindable var viewModel: UnApprovedLogisticMapViewModel
    
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
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading) {
                        Text("도착지: \(viewModel.logistic.destination)")
                            .font(.pretendard(size: 20, weight: .bold))
                        Text("물품명: \(viewModel.logistic.productName)")
                            .font(.pretendard(size: 20, weight: .bold))
                        Text("비용 \(viewModel.logistic.price)원")
                    }
                    .padding(.horizontal, 20)
                }
                
                HStack {
                    Button {
                        logger.printOnDebug("미승인 물류 삭제 시도")
                        viewModel.removeLogistic()
                        // 결과는 로그로 확인
                    } label: {
                        Text("삭제")
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
                        logger.printOnDebug("미승인 물류 수정 시도")
                    } label: {
                        Text("수정")
                            .font(.pretendardCaption)
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .foregroundStyle(.white)
                            .background(Color.appTypeColor)
                            .clipShape(.rect(cornerRadius: 10))
                    }
                }
                .padding(.bottom, 12)
            }
            .frame(alignment: .bottom)
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
