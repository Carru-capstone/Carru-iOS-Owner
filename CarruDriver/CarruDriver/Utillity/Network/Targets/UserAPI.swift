//
//  SignAPI.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/15/24.
//

import Foundation
import Moya

enum UserAPI {
    // 회원가입
    case signUp(userStatus: Int, signUpRequest: SignUpRequestDTO)
    // 로그인
    case signIn(userStatus: Int, signInRequest: SignInRequestDTO)
    // 프로필
    case profile
    
    // 29. 사용자 - 차고지/물류 창고 조회
    case userWarehouseList
    
    // 30. 화물기사 - 차고지 변경
    case changeWareshouse(request: ChangeWarehouseRequestDTO)
}


extension UserAPI: TargetType {
    var baseURL: URL {
        return InfoManager.carruServerBaseURL
    }
    
    var path: String {
        switch self {
        case .signUp:
            return "/v1/user/sign-up"
        case .signIn:
            return "/v1/user/login"
        case .profile:
            return "/v1/user/profile"
        case .userWarehouseList:
            return "/v1/user/location"
        case .changeWareshouse:
            return "/v1/driver/location"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signUp, .signIn:
            return .post
        case .profile:
            return .get
        case .userWarehouseList:
            return .get
        case .changeWareshouse:
            return .patch
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .signUp(let userStatus, let signUpRequest):
            return .requestCompositeParameters(
                bodyParameters: signUpRequest.toDictionary() ?? [:],
                bodyEncoding: JSONEncoding.default,
                urlParameters: ["userStatus": userStatus]
            )
        case .signIn(let userStatus, let signInRequest):
            return .requestCompositeParameters(
                bodyParameters: signInRequest.toDictionary() ?? [:],
                bodyEncoding: JSONEncoding.default,
                urlParameters: ["userStatus": userStatus]
            )
        case .profile:
            return .requestPlain
        case .userWarehouseList:
            return .requestPlain
        case .changeWareshouse(let request):
            return .requestJSONEncodable(request)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .signUp, .signIn:
            return ["Content-Type": "application/json"]
        case .profile, .userWarehouseList, .changeWareshouse:
            do {
                return [
                    "Content-Type": "application/json",
                    "X-AUTH-TOKEN": try Keychain.searchToken(kind: .accessToken)
                ]
            } catch {
                logger.printOnDebug(error.localizedDescription)
            }
            return [:]
        }
    }
}
