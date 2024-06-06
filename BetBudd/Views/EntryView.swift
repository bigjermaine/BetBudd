//
//  EntryView.swift
//  BetBudd
//
//  Created by MacBook AIR on 27/10/2023.
//

import SwiftUI
import Combine
struct EntryView: View {
    @State var inputMerchant:String = ""
    @State var inputAmount:String = ""
    @State var inputDate: Date = Date()
    @State var animmate:Bool = false
    @State private var dataSavedPresented = false
    @FocusState private var nameIsFocused: Bool
    @State private var dataSavedPresented2 = false
    @EnvironmentObject var bettingViewModel:BettingSaveManager
    @State private var isKeyboardVisible = false
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
             Text("Tap right Side of the text field to dismiss the keyboard 😁")
                          .foregroundColor(.red)
                          .padding(8)
                          .cornerRadius(8)
                          .padding(16)
                          .opacity(isKeyboardVisible ? 1 : 0)
             Spacer()
            ZStack{
                VStack{
                
                    
                    HStack {
                        Image(systemName: "gamecontroller.fill")
                            .font(.system(size: 25))
                            .padding()
                        //Money  Entry
                        TextField("Merchant", text: $inputMerchant)
                            .padding()
                        
                    }
                    .modifier(TextfieldModifier())
                    
                    HStack{
                        Image(systemName: "dollarsign.square.fill")
                            .font(.system(size: 29))
                            .padding()
                        TextField("Amount", text: $inputAmount).keyboardType(.phonePad)
                            .padding(.leading,10)
                            .padding()
                        
                    }
                    .modifier(TextfieldModifier())
                    .onReceive(Publishers.keyboardHeight) { keyboardHeight in
                        self.isKeyboardVisible = keyboardHeight > 0
                    }
                   
                    
                    HStack {
                        DatePicker(selection: $inputDate, label: { /*@START_MENU_TOKEN@*/Text("Date")/*@END_MENU_TOKEN@*/ }).labelsHidden()
                            .onChange(of: true) { _ in
                                HapticManager.shared.vibrateForSelection()
                            }
                        
                    }
                    .padding(.horizontal,30)
                    .padding()
                    Button {
                        withAnimation(.easeInOut) {
                            if inputMerchant.isEmpty == false && inputAmount.isEmpty == false {
                                let userData = UserData2(merchant: inputMerchant, amount: inputAmount, date: inputDate)
                                bettingViewModel.addData(bettingData: userData)
                                HapticManager.shared.vibrate(for: .success)
                                inputMerchant = ""
                                inputAmount = ""
                            }else{
                                dataSavedPresented2 = true
                                HapticManager.shared.vibrate(for: .error)
                            }
                        }
                    } label: {
                        if inputMerchant.isEmpty == false && inputAmount.isEmpty == false {
                            
                            Text("Submit")
                                .font(.system(size: 18))
                                .foregroundColor(.red)
                            
                        }else {
                            Text("Submit")
                                .font(.system(size: 18))
                            
                        }
                    }
                    .scaleEffect(animmate ? 1.3:1.0)
                    .buttonStyle(.bordered).padding()
                    
                }
                
                .onTapGesture {
                    nameIsFocused = false
                    hideKeyboard()
                }
                .alert("Transaction saved!", isPresented: $dataSavedPresented, actions: {
                })
                .alert("Fill all Entries", isPresented: $dataSavedPresented2, actions: {
                })
            }
            
            .onTapGesture {
                nameIsFocused = false
                hideKeyboard()
            }
            Spacer()
            VStack {
                AdBannerView(adUnitID: Ads.entryLevelUID) // Replace with your ad unit ID
                           .frame(height: 50)
            
                   }
        }
       
        .padding()
        
        .onAppear{
            HapticManager.shared.vibrateForSelection()
            print("Who will the Australia Open 2023? \nMedvedev")
        }
    }
    
}



struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        EntryView()
    }
}
