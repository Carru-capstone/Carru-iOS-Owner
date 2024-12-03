//
//  SignUpViewModel.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/4/24.
//

import Foundation
import Combine

@Observable
class SignUpViewModel {
    var email: String = ""
    var phone: String = ""
    var password: String = ""
    var passwordCheck: String = ""
    var name: String = ""
    var address: String = ""
    
    let userRepo = UserRepository()
    var cancellables = Set<AnyCancellable>()
    
    var isAddressSelectPresent: Bool = false
    
    func signUp() -> Future<Bool, Error> {
        Future { promise in
            logger.printOnDebug("회원가입 시도")
            
            self.userRepo
                .signUp(
                    userStatus: appType.userStatus,
                    signUpDTO: .init(
                        name: self.name,
                        email: self.email,
                        password: self.password,
                        phoneNumber: self.phone,
                        location: self.address
                    )
                )
                .sink { result in
                    switch result {
                    case .finished:
                        promise(.success(true))
                    case .failure(let error):
                        promise(.failure(error))
                    }
                } receiveValue: { _ in}
                .store(in: &self.cancellables)
        }
    }
}
