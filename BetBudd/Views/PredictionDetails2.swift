//
//  PredictionDetails2.swift
//  BetBudd
//
//  Created by MacBook AIR on 23/11/2023.
//

import SwiftUI

struct PredictionDetails2: View {
    var tips:Tips
    @EnvironmentObject var vm:CloudKitViewModel
    var body: some View {
        ZStack{
            if tips.gameImage == "tennis" {
                Image(systemName: tips.gameImage)
                .foregroundColor(.green)
            }else{
                Image(systemName: tips.gameImage)
                    .foregroundColor(.blue)
            }
            ScrollView{
                VStack{
                    HStack{
                        Text(tips.FirstPlayer)
                            .font(.title)
                        Text("VS")
                        Text(tips.SecondPlayer)
                            .font(.title)
                    }
                    .padding()
                    
                    Text(tips.MoreTips)
                    HStack{
                        Spacer()
                        Button{
                            vm.updateWin(Fruit: tips)
                        }label: {
                            Text("win")
                                .foregroundColor(.white)
                                .frame(height: 40)
                                .background(Color.green)
                                .cornerRadius(10)
                        }
                        Spacer()
                        Button{
                            vm.updateLose(Fruit: tips)
                        }label: {
                            Text("Lose")
                                .foregroundColor(.white)
                                .frame(height: 40)
                                .background(Color.red)
                                .cornerRadius(10)
                        }
                        Spacer()
                    }
                    
                }
                .padding()
            }
        }
    }
}
