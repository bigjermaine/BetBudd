//
//  PredictionDetails.swift
//  BetBudd
//
//  Created by MacBook AIR on 21/11/2023.
//

import SwiftUI
import GoogleMobileAds
import CloudKit
struct PredictionDetails: View {
    var tips:Tips
    @State var interstitial: GADInterstitialAd?
    var body: some View {
        ZStack{
          
            ScrollView{
                VStack{
                    HStack{
                        Spacer()
                        VStack(spacing:20){
                            HStack(alignment: .center){
                                if tips.gameImage == "tennis"  {
                                    Image(systemName: "person.fill")
                                        .resizable()
                                        .frame(width: 50,height: 50)
                                }else {
                                    Image(systemName: "figure.australian.football")
                                        .resizable()
                                        .frame(width: 50,height: 50)
                                }
                              
                            }
                            Text(tips.FirstPlayer)
                                .font(.title)
                            ZStack{
                                Circle()
                                    .stroke(lineWidth:20)
                                    .opacity(0.5)
                                    .foregroundColor(.blue)
                                Circle()
                                    .trim(from: 0.0, to: min(1.0, Double(tips.percentageWin) ?? 0))
                                    .stroke(AngularGradient(gradient: Gradient(colors: [.red]), center: .center),style:StrokeStyle(lineWidth:20))
                                    .rotationEffect(Angle(degrees: 270))
                                Text("\(String(format: "%.f", (Double(tips.percentageWin) ?? 0) * 100))%")
                            }
                            .frame(width: 70,height: 70)
                        }
                        Spacer()
                        Text("VS")
                            .foregroundColor(.red)
                            .font(.title)
                        Spacer()
                        VStack(spacing:20){
                            HStack(alignment: .center){
                                
                                if tips.gameImage == "tennis"  {
                                    Image(systemName: "person.fill")
                                        .resizable()
                                        .frame(width: 50,height: 50)
                                }else {
                                    Image(systemName: "figure.australian.football")
                                        .resizable()
                                        .frame(width: 50,height: 50)
                                }
                            }
                            Text(tips.SecondPlayer)
                                .font(.title)
                            ZStack{
                                Circle()
                                    .stroke(lineWidth:20)
                                    .opacity(0.5)
                                    .foregroundColor(.blue)
                                Circle()
                                    .trim(from: 0.0, to: min(1.0, Double(tips.SecondPlayerpercentageWin) ?? 0))
                                    .stroke(AngularGradient(gradient: Gradient(colors: [.red]), center: .center),style:StrokeStyle(lineWidth:20))
                                    .rotationEffect(Angle(degrees: 270))
                                Text("\(String(format: "%.f", (Double(tips.SecondPlayerpercentageWin) ?? 0) * 100))%")
                            }
                            .frame(width: 70,height: 70)
                            
                        }
                        Spacer()
                    }
                    .padding()
        
                    VStack(alignment:.leading,spacing: 10){
                        Text("MoreTips")
                            .font(.title)
                            .bold()
                        Text(tips.MoreTips)
                    }
                    
                    
                }
                .padding()
            }
        }
        .onAppear{
            loadInterstitialAd()
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
             self.showad()
            }
            
        }
    }
    func showad() {
        if let interstitial = interstitial {
            // Show the interstitial ad
            let root = UIApplication.shared.windows.first?.rootViewController
            interstitial.present(fromRootViewController: root!)
        } else {
            print("Ad not ready yet. Please try again later.")
        }
    }

    
    func loadInterstitialAd() {
            let adUnitID = "ca-app-pub-4916382790527707/6536656010"
            let request = GADRequest()
            GADInterstitialAd.load(
                withAdUnitID: adUnitID,
                request: request
            ) { (ad, error) in
                if let error = error {
                    print("Failed to load interstitial ad: \(error.localizedDescription)")
                    return
                }
                self.interstitial = ad
            }
        }

}

struct PredictionDetails_Previews: PreviewProvider 

{
    static var  newfruit = CKRecord(recordType: "Tips")
    static var previews: some View {
        PredictionDetails(tips: Tips(FirstPlayer: "Federer", SecondPlayer: "Nadal", WinOrLoseImage: "l", WinSelection: "tenni", MoreTips: "consider Nadal's performance on clay courts; he is particularly strong on this surface", gameImage: "tenni", percentageWin: "0.1", SecondPlayerpercentageWin: "0.4", record:  newfruit))
           
    }
}
