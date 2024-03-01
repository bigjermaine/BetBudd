//
//  Predication.swift
//  BetBudd
//
//  Created by MacBook AIR on 20/11/2023.
//

import SwiftUI

struct Predication: View {
    @State var toogleView:Bool = false
    @StateObject private var vm = CloudKitViewModel()
    var body: some View {
        NavigationView {
            VStack{
                if !vm.Tips.isEmpty {
                   TipsAvaible
                    
                }else {
                    Text("Tips Coming Soon.....")
                        .font(.title)
                        .fontWeight(.semibold)
                        .italic()
                }
                Spacer()
                    AdBannerView(adUnitID: "ca-app-pub-4916382790527707/1575139226") // Replace with your ad unit ID
                        .frame(height: 50)
                    
            }
            .navigationTitle("Tips..")
            .toolbar{
                if vm.isLoading {
                    ProgressView()
                }else{
                    Button{
                        HapticManager.shared.vibrateForSelection()
                        vm.fetchItems()
                        
                    }label: {
                        
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
        }
        
        .onAppear{
            HapticManager.shared.vibrateForSelection()
        }
    }
}

struct Predication_Previews: PreviewProvider {
    static var previews: some View {
        Predication()
    }
}


extension Predication {
    
    private var TipsAvaible:some View {
        
        
        List {
            ForEach(vm.Tips,id:\.self){ x in
                HStack{
                    NavigationLink {
                        PredictionDetails(tips: x)
                    }label: {
                        HStack{
                            Text(x.FirstPlayer)
                                .font(.callout)
                                .frame(width:80,alignment: .center)
                                .padding(.leading)
                            VStack{
                                Text("Vs")
                            }
                            .frame(width:20,alignment: .center)
                            .padding(.trailing)
                            Spacer()
                            Text(x.SecondPlayer)
                                .font(.callout)
                                .frame(width:80,alignment: .topLeading)
                                .padding(.trailing)
                            Text(x.WinSelection)
                                .frame(width:50,alignment: .topLeading)
                                .padding(.trailing)
                            if x.WinOrLoseImage == "L"{
                                Image(systemName: "x.square")
                                    .foregroundColor(.red)
                                    .frame(width:10,alignment: .topLeading)
                                    .padding(.trailing)
                            }else  if x.WinOrLoseImage == "W" {
                                Image(systemName: "chart.bar.fill")
                                    .foregroundColor(.green)
                                    .frame(width:10,alignment: .topLeading)
                                    .padding(.trailing)
                            }else if x.WinOrLoseImage == "tennis" {
                                Image(systemName: "tennis.racket")
                                    .foregroundColor(.green)
                                    .frame(width:10,alignment: .topLeading)
                                    .padding(.trailing)
                                
                            }
                            else if x.WinOrLoseImage == "football" {
                                Image(systemName: "soccerball")
                                    .foregroundColor(.green)
                                    .frame(width:10,alignment: .topLeading)
                                    .padding(.trailing)
                                
                            }else {
                                Image(systemName: "sportscourt.fill")
                                    .foregroundColor(.green)
                                    .frame(width:10,alignment: .topLeading)
                                    .padding(.trailing)
                            }
                            
                            
                        }
                        
                        
                    }
                    
                    //.padding(.leading)
                }
            }
            
        }
        .refreshable {
            vm.fetchItems()
        }
        .listStyle(.grouped)
    }
    
    
}


