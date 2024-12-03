//
//  LogisticApprovedMapView.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/25/24.
//

import Combine
import SwiftUI

struct ApprovedLogisticMapView: View {
    @EnvironmentObject var mainViewManager: MainViewManager
    @Binding var path: [MainScreen]
    @Bindable var viewModel: ApprovedLogisticMapViewModel
    
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
                    Text(viewModel.logistic?.title ?? "")
                    Text("총 소요시간: \(viewModel.logistic?.operationTime ?? 0)")
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
                    Text("도착지: \(viewModel.logistic?.destination ?? "")")
                        .font(.pretendard(size: 20, weight: .bold))
                    Text("물품명: \(viewModel.logistic?.productName ?? "")")
                        .font(.pretendard(size: 20, weight: .bold))
                    Text("비용 \(viewModel.logistic?.price ?? 0)원")
                }
                .padding(.horizontal, 20)
                
                
                if viewModel.progressType != .todo {
                    VStack(alignment: .leading) {
                        Text("운송자")
                        Text(viewModel.logistic?.transporterName ?? "")
                        Text(viewModel.logistic?.transporterPhoneNumber ?? "")
                    }
                    .padding(.horizontal, 20)
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
