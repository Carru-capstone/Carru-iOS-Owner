//
//  RouteMatchingListCell.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/21/24.
//

import SwiftUI

struct RouteMatchingListCell: View {
    var reservation: RouteReservation
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    // 출발 시간 표시
                    Text("출발시간: \(formattedStartTime(reservation.startTime))")
                        .font(.pretendard(size: 18, weight: .bold))
                    
                    // 출발지와 도착지 표시
                    Text(reservation.title)
                        .font(.pretendard(size: 18, weight: .bold))
                    
                    // 총 운송 정보 표시
                    Text(reservation.description)
                        .font(.pretendard(size: 16, weight: .regular))
                        .foregroundStyle(.crGray2)
                }
                
                // 우측 화살표 아이콘
                Image(systemName: "chevron.right")
                    .foregroundStyle(.crGray2)
            }
            .padding(10)
        }
        .background(.crGray)
        .clipShape(.rect(cornerRadius: 10))
    }
    
    /// 출발 시간을 포맷팅하는 함수
    private func formattedStartTime(_ iso8601String: String) -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate, .withTime, .withColonSeparatorInTime]
        if let date = formatter.date(from: iso8601String) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateFormat = "yyyy년 M월 d일 HH:mm"
            return displayFormatter.string(from: date)
        }
        return iso8601String // 포맷팅 실패 시 원본 반환
    }
}


//#Preview {
//    ScrollView {
//        VStack(spacing: 16) {
//            let sampleReservations = [
//                RouteReservation(
//                    startTime: "2024-11-20T07:29:43.346Z",
//                    departureLocation: "서울",
//                    departureLatitude: 37.5665,
//                    departureLongitude: 126.9780,
//                    destinationLocation: "부산",
//                    destinationLatitude: 35.1796,
//                    destinationLongitude: 129.0756,
//                    totalWeight: 15,
//                    totalPrice: 500000,
//                    totalOperationDistance: 400,
//                    totalOperationTime: 360
//                ),
//                RouteReservation(
//                    startTime: "2024-11-21T09:00:00.000Z",
//                    departureLocation: "인천",
//                    departureLatitude: 37.4563,
//                    departureLongitude: 126.7052,
//                    destinationLocation: "광주",
//                    destinationLatitude: 35.1595,
//                    destinationLongitude: 126.8526,
//                    totalWeight: 10,
//                    totalPrice: 300000,
//                    totalOperationDistance: 350,
//                    totalOperationTime: 300
//                )
//            ]
//            
//            ForEach(sampleReservations, id: \.self) { reservation in
//                RouteMatchingListCell(reservation: reservation)
//                    .frame(maxWidth: .infinity)
//                    .padding(.horizontal)
//            }
//        }
//        .padding(.vertical)
//        .background(Color.white)
//    }
//}
