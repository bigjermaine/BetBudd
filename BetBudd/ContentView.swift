//
//  ContentView.swift
//  BetBudd
//
//  Created by MacBook AIR on 07/10/2023.
//

import SwiftUI
import GoogleMobileAds

struct ContentView: View {
    init() {
       //  Start Google Mobile Ads
        DispatchQueue.main.async {
            GADMobileAds.sharedInstance().start(completionHandler: nil)
        }
      
    }
    @AppStorage("Signed_In") var CurentSignedIN:Bool = false
    @AppStorage("adminView") var showAdminView:Bool = false
    var body: some View {
        
        ZStack {
            if CurentSignedIN {
                if  showAdminView {
                AdminMainView()
                }else{
                    MainTabbar()
                }
            }else {
             
                OnboardingScreen()
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


    
 
       


// UIViewRepresentable wrapper for AdMob banner view
struct AdBannerView: UIViewRepresentable {
    let adUnitID: String

    func makeUIView(context: Context) -> GADBannerView {
        let bannerView = GADBannerView(adSize: GADAdSizeFromCGSize(CGSize(width: 320, height: 50))) // Set your desired banner ad size
        bannerView.adUnitID = adUnitID
        bannerView.rootViewController = UIApplication.shared.windows.first?.rootViewController
        bannerView.load(GADRequest())
        return bannerView
    }
    
    func updateUIView(_ uiView: GADBannerView, context: Context) {}
}
