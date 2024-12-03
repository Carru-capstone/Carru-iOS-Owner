//
//  ReservationListCellView.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/13/24.
//

import SwiftUI

struct logisticMatchingListCell: View {
    var reservation: LogisticReservation
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text("출발: \(reservation.departureLocation)\n도착: \(reservation.destinationLocation)")
                        .font(.pretendard(size: 18, weight: .bold))
                    Text(reservation.description)
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
