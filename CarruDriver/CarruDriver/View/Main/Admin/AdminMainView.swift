//
//  AdminMainView.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/24/24.
//

import SwiftUI

struct AdminMainView: View {
    @EnvironmentObject var mainViewManager: MainViewManager
    
    var body: some View {
        
        ZStack {
            
            if mainViewManager.isLoggedIn {
                AdminMainTabView()
            } else {
                SignInView(viewModel: .init())
            }
            
            // 커스텀 알림창 최상단 사용
            if let infoAlertViewModel = mainViewManager.infoAlertViewModel {
                InfoAlertView(viewModel: infoAlertViewModel) {
                    mainViewManager.infoAlertViewModel = nil
                }
            }
            
            // 커스텀 인풋 최상단 사용
            if let inputAlertViewModel = mainViewManager.inputAlertViewModel {
                InputAlertView(viewModel: inputAlertViewModel) {
                    mainViewManager.inputAlertViewModel = nil
                }
            }
        }
        .onAppear {
            guard let _ = try? Keychain.searchToken(kind: .accessToken) else { return }
            mainViewManager.isLoggedIn = true
        }
    }
}