//
//  AdminApproveLogisticCell.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/26/24.
//

import SwiftUI

struct AdminApproveLogisticCell: View {
    var logistic: UnApprovedLogistics
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    HStack {
                        Text("출발: ")
                            .font(.pretendard(size: 18, weight: .bold))
                        Text("\(logistic.departure)")
                            .font(.pretendard(size: 18, weight: .semiBold))
                        Spacer()
                    }
                    
                    HStack {
                        Text("도착: ")
                            .font(.pretendard(size: 18, weight: .bold))
                        Text("\(logistic.destination)")
                            .font(.pretendard(size: 18, weight: .semiBold))
                        Spacer()
                    }
                    
                    Text(logistic.description)
                        .font(.pretendard(size: 16, weight: .regular))
                        .foregroundStyle(.crGray2)
                }
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.crGray2)
            }
            .padding(10)

        }
        .background(.crGray)
        .clipShape(.rect(cornerRadius: 10))
    }
}
