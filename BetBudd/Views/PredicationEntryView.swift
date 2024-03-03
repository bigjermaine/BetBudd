//
//  PredicationEntryView.swift
//  BetBudd
//
//  Created by MacBook AIR on 22/11/2023.
//

import SwiftUI

struct PredicationEntryView: View {
    @EnvironmentObject var vm:CloudKitViewModel
    @State var errorText:String = "Error enter all fields"
    @State var showFullScreen:Bool = false
    var body: some View {
        ZStack {
           
            ScrollView {
                VStack{
                    VStack{
                        VStack(spacing:20){
                            Text(vm.isSigned.description)
                            Text(vm.error)
                            Text(vm.returnedStatus.description)
                            Text("Player")
                                .fontWeight(.semibold)
                                .font(.title)
                            TextField("Player1", text: $vm.name)
                                .frame(height: 50)
                                .background(Color.blue)
                                .cornerRadius(10)
                                .autocapitalization(.words)
                                .autocorrectionDisabled()
                            Text("Player2")
                                .fontWeight(.semibold)
                                .font(.title)
                            TextField("Player2", text: $vm.name2)
                                .frame(height: 50)
                                .autocapitalization(.words)
                                .background(Color.blue)
                                .cornerRadius(10)
                                .autocorrectionDisabled()
                                
                        }
                        VStack(spacing:20){
                            Text("Tip")
                                .fontWeight(.semibold)
                                .font(.title)
                            TextField("Tips", text: $vm.tip)
                                .frame(height: 50)
                                .background(Color.blue)
                                .cornerRadius(10)
                                .autocapitalization(.none)
                                .autocorrectionDisabled()
                            
                            Text("Description About Tips")
                                .fontWeight(.semibold)
                                .font(.title)
                            TextField("MoreTips", text: $vm.moreTip)
                                .frame(height: 50)
                                .background(Color.blue)
                                .cornerRadius(10)
                                .autocapitalization(.none)
                                .autocorrectionDisabled()
                            HStack(spacing:20){
                                Text("image")
                                    .fontWeight(.semibold)
                                    .font(.title)
                                Picker(selection: $vm.image,label:Text("Label"), content: {
                                    Text("tennis")
                                        .tag("tennis")
                                    Text("football")
                                        .tag("football")
//                                    Text("0.1").tag("")
//                                    Text("0.2").tag("2")
//                                    Text("0.3").tag("3")
//                                    Text("0.4").tag("4")
//                                    Text("0.5").tag("5")
//                                    Text("0.6").tag("6")
//                                    Text("0.7").tag("7")
//                                    Text("0.8").tag("8")
//                                    Text("0.9").tag("6")
//                                    Text("1.0").tag("9")
//                                    
                                })
                            }
                            TextField("image", text: $vm.image)
                                .frame(height: 50)
                                .background(Color.blue)
                                .cornerRadius(10)
                                .autocapitalization(.none)
                                .autocorrectionDisabled()
                            Text("winLoseimage")
                                .fontWeight(.semibold)
                                .font(.title)
                            TextField("image", text: $vm.winLoseimage)
                                .frame(height: 50)
                                .background(Color.blue)
                                .cornerRadius(10)
                                .autocapitalization(.none)
                                .autocorrectionDisabled()
                            HStack{
                                Text("FirstPlayer percentage")
                                    .fontWeight(.semibold)
                                    .font(.title)
                                
                                Picker(selection: $vm.percentage,label:Text("Label"), content: {
                                  
                                    Text("0.1").tag("0.1")
                                    Text("0.2").tag("0.2")
                                    Text("0.3").tag("0.3")
                                    Text("0.4").tag("0.4")
                                    Text("0.5").tag("0.5")
                                    Text("0.6").tag("0.6")
                                    Text("0.7").tag("0.7")
                                    Text("0.8").tag("0.8")
                                    Text("0.9").tag("0.6")
                                    Text("1.0").tag("1.0")

                                })
                            }
                            }
                            TextField("First%", text: $vm.percentage)
                                .frame(height: 50)
                                .background(Color.blue)
                                .cornerRadius(10)
                                .autocapitalization(.none)
                                .autocorrectionDisabled()
                            
                          
                        
                        HStack{
                            
                            Text("Second Player percentage")
                                .fontWeight(.semibold)
                                .font(.title)
                        
                            Picker(selection: $vm.percentage2,label:Text("Label"), content: {
                        
                                Text("0.1").tag("0.1")
                                Text("0.2").tag("0.2")
                                Text("0.3").tag("0.3")
                                Text("0.4").tag("0.4")
                                Text("0.5").tag("0.5")
                                Text("0.6").tag("0.6")
                                Text("0.7").tag("0.7")
                                Text("0.8").tag("0.8")
                                Text("0.9").tag("0.6")
                                Text("1.0").tag("1.0")
                                
                            })
                        }
                            TextField("Second%", text: $vm.percentage2)
                                .frame(height: 50)
                                .background(Color.blue)
                                .cornerRadius(10)
                                .autocapitalization(.none)
                                .autocorrectionDisabled()
                       
                        }
                        
                        VStack(spacing:40){
                            Button{
                                vm.addItem()
                                errorText = "Tips Uploaded"
                                vm.error2 = true
                            }label: {
                                Text("Upload Tips")
                                    .bold()
                                    .padding()
                                    .frame(height: 50)
                                    .foregroundColor(.black)
                                    .background(Color.red)
                                    .cornerRadius(10)
                            }
                            
                            
                            Button{
                                vm.addItem2()
                                errorText = "Notification Has Been Sent To Users About The Newly Added Tips"
                                vm.error2 = true
                            }label: {
                                Text("Send Notification")
                                    .bold()
                                    .padding()
                                    .frame(height: 50)
                                    .foregroundColor(.black)
                                    .background(Color.red)
                                    .cornerRadius(10)
                            }
                        }
                        .padding()
                    }
                
            }       .padding()
            }
        
        .toolbar{
                Button{
                    showFullScreen = true
                }label: {
                    
                    Image(systemName: "arrow.clockwise")
                }
             }
        .alert(isPresented: $vm.error2) {
            Alert(title: Text(errorText))
        }
        
        .fullScreenCover(isPresented: $showFullScreen, content: {
            MainTabbar()
        })
        }
        
    }


struct PredicationEntryView_Previews: PreviewProvider {
   
    static var previews: some View {
        let vm  = CloudKitViewModel()
        PredicationEntryView()
            .environmentObject(vm)
           
           
    }
}
