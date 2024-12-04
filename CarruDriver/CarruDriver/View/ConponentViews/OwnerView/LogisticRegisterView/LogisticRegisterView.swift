//
//  LogisticRegisterView.swift
//  CarruDriver
//
//  Created by 이주훈 on 11/18/24.
//

import SwiftUI
import Combine

struct LogisticRegisterView: View {
    @EnvironmentObject var mainViewManager: MainViewManager
    @Binding var path: [MainScreen]
    @Bindable var viewModel: LogisticRegisterViewModel
    @FocusState var focusedField: Field?
    
    @State var cancellables: [AnyCancellable] = []
    
    enum AddressFindType {
        case departure
        case destination
    }
    
    enum Field: Hashable {
        case weight
        case category
        case price
    }
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text(ViewTitle.findRoute)
                        .font(.pretendardTitle)
                        .padding(.top, 12)
                        .padding(.leading, 20)
                    
                    VStack(alignment: .leading) {
                        Text("무게")
                            .font(.pretendardBody)
                            .padding(.horizontal, 20)
                        CarruTextField(
                            text: $viewModel.weight,
                            placeholder: "단위 톤",
                            keyboardType: .numberPad
                        )
                        .focused($focusedField, equals: .weight)
                        .id(Field.weight)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("품목")
                            .font(.pretendardBody)
                            .padding(.horizontal, 20)
                        CarruTextField(
                            text: $viewModel.category,
                            placeholder: "",
                            keyboardType: .default
                        )
                        .focused($focusedField, equals: .category)
                        .id(Field.category)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("비용")
                            .font(.pretendardBody)
                            .padding(.horizontal, 20)
                        CarruTextField(
                            text: $viewModel.price,
                            placeholder: "",
                            keyboardType: .numberPad
                        )
                        .focused($focusedField, equals: .price)
                        .id(Field.price)
                    }
                    
                    
                    VStack(alignment: .leading) {
                        Text("도착지")
                            .font(.pretendardBody)
                            .padding(.horizontal, 20)
                        CarruTextView(
                            text: $viewModel.destination,
                            placeholder: "도착지 선택"
                        )
                        .onTapGesture {
                            viewModel.isFindAddressPresent.toggle()
                            focusedField = nil
                        }
                    }
                    
                    HStack() {
                        Text("도착기한")
                            .font(.pretendardBody)
                            .padding(.horizontal, 20)
                        
                        CarruDatePickerView(targetDate: $viewModel.deadline)
                        .onTapGesture {
                            viewModel.isFindAddressPresent.toggle()
                            focusedField = nil
                        }
                    }
                    
                    CarruButton {
                        if viewModel.state == .register {
                            viewModel.registerLogistic()
                        } else if viewModel.state == .edit {
                            viewModel.editLogistic()
                        }
                    } label: {
                        Text(viewModel.buttonTitle)
                    }
                    
                    Spacer()
                }
                .sheet(isPresented: $viewModel.isFindAddressPresent) {
                    AddressView(
                        title: "도착지 선택",
                        viewModel: .init(type: .warehouseSearch),
                        confirmAction2:  { warehouse in
                            logger.printOnDebug("선택된 주소: \(warehouse.location)")
                            viewModel.selectedWarehouse = warehouse
                            viewModel.destination = warehouse.location
                        })
                }
                .onChange(of: focusedField) { _, newValue in
                    if let field = newValue {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.22) {
                            withAnimation {
                                proxy.scrollTo(field, anchor: .center)
                            }
                        }
                    }
                }
            }
            .onTapGesture {
                focusedField = nil
            }
        }
    }
}
