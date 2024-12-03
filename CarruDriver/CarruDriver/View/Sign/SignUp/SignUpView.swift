//
//  SignUpView.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/4/24.
//

import SwiftUI
import Combine

struct SignUpView: View {
    @EnvironmentObject var mainViewManager: MainViewManager
    @Binding var path: [SignScreen]
    @Bindable var signUpViewModel: SignUpViewModel
    @State private var cancellables = Set<AnyCancellable>()
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("이메일주소")
                    .font(.pretendardCaption)
                    .padding(.horizontal, 20)
                CarruTextField(text: $signUpViewModel.email, placeholder: "example@email.com")
            }
            
            VStack(alignment: .leading) {
                Text("전화번호")
                    .font(.pretendardCaption)
                    .padding(.horizontal, 20)
                CarruTextField(
                    text: $signUpViewModel.phone,
                    placeholder: "010-1234-5678",
                    keyboardType: .numberPad
                )
            }
            
            VStack(alignment: .leading) {
                Text("비밀번호")
                    .font(.pretendardCaption)
                    .padding(.horizontal, 20)
                CarruTextField(
                    text: $signUpViewModel.password,
                    placeholder: "비밀번호",
                    isSecure: true
                )
                CarruTextField(
                    text: $signUpViewModel.passwordCheck,
                    placeholder: "비밀번호 확인",
                    isSecure: true
                )
            }
            
            VStack(alignment: .leading) {
                Text("이름")
                    .font(.pretendardCaption)
                    .padding(.horizontal, 20)
                CarruTextField(text: $signUpViewModel.name, placeholder: "이름")
            }
            
            VStack(alignment: .leading) {
                Text("차고지 주소")
                    .font(.pretendardCaption)
                    .padding(.horizontal, 20)
                CarruTextView(text: $signUpViewModel.address, placeholder: "주소", icon: "magnifyingglass")
                    .onTapGesture {
                        signUpViewModel.isAddressSelectPresent.toggle()
                    }
            }
            
            CarruButton {
                signUpViewModel.signUp()
                    .sink(receiveCompletion: {
                        logger.checkComplition(message: "회원가입", complition: $0)
                    }, receiveValue: { isSigned in
                        logger.printOnDebug("\(isSigned)")
                        path.removeAll()
                    })
                    .store(in: &cancellables)
            } label: {
                Text("회원가입")
                    .font(.pretendard(size: 16, weight: .bold))
            }
            
            Spacer()
        }
        .navigationTitle("회원가입")
        .sheet(isPresented: $signUpViewModel.isAddressSelectPresent) {
            AddressView(
                title: "차고지 선택",
                viewModel: .init()) { newAddress in
                    signUpViewModel.address = newAddress
                    signUpViewModel.isAddressSelectPresent.toggle()
                }
        }
    }
}


#Preview {
    @Previewable @State var path: [SignScreen] = []
    
    SignUpView(path: $path, signUpViewModel: SignUpViewModel())
}
