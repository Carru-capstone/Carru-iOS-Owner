//
//  UserRegisterApproveCell.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/26/24.
//

import SwiftUI

struct UserRegisterApproveCell: View {
    var user: UnApprovedUser
    
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
                    Text("회원가입 요청일: \(user.createdAt)")
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
