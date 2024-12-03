//
//  SignUpDTO.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/15/24.
//

import Foundation

struct SignUpRequestDTO: Codable {
    let name: String
    let email: String
    let password: String
    let phoneNumber: String
    let location: String
}
