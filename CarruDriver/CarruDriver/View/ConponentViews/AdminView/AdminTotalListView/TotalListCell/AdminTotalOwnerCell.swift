//
//  AdminTotalOwnerCell.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/26/24.
//

import SwiftUI

struct AdminTotalOwnerCell: View {
    var user: ApprovedUser
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                VStack(alignment: .leading) {
                    Text(user.name)
                        .font(.pretendard(size: 18, weight: .bold))
                    Text("전화번호: \(user.phoneNumber)")
                        .font(.pretendard(size: 16, weight: .regular))
                        .foregroundStyle(.crGray2)
                    Text("이메일: \(user.email)")
                        .font(.pretendard(size: 16, weight: .regular))
                        .foregroundStyle(.crGray2)
                    Text("차고지: \(user.location)")
                        .font(.pretendard(size: 16, weight: .regular))
                        .foregroundStyle(.crGray2)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.crGray2)
            }
            .padding(10)

        }
        .background(.crGray)
        .clipShape(.rect(cornerRadius: 10))
    }
}
