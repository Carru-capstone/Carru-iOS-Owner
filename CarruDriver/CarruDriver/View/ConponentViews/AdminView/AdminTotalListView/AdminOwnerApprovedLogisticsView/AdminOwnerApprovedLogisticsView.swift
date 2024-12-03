//
//  AdminUserLogisticsView.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/26/24.
//

import SwiftUI

struct AdminOwnerApprovedLogisticsView: View {
    @Binding var path: [MainScreen]
    @Bindable var viewModel: AdminOwnerApprovedLogisticsViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(ViewTitle.reservations)
                .font(.pretendardTitle)
                .padding(.top, 12)
                .padding(.leading, 20)
            
            List(viewModel.logistics, id: \.self) { logistic in
                AdminOwnerApprovedLogisticsCell(logistic: logistic)
                    .listRowSeparator(.hidden)
                    .listRowInsets(.init(top: 10, leading: 15, bottom: 0, trailing: 15))
                    .onTapGesture {
                        logger.printOnDebug("화주의 물류 선택")
                        path.append(.adminTotalLogisticAndOwnerMapView(logisticId: logistic.logisticsId))
                    }
            }
            .listStyle(.plain)
            
        }
    }
}
