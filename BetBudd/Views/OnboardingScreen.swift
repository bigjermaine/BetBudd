//
//  OnboardingScreen.swift
//  BetBudd
//
//  Created by MacBook AIR on 22/11/2023.
//

import SwiftUI

struct OnboardingScreen: View {
    @State var animmate:Bool = false
    @State var onboardingState:Int = 0
    let transition:AnyTransition = .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge:.leading))
    @AppStorage("Signed_In") var CurentSignedIN:Bool = false
    var body: some View {
        NavigationView{
            ZStack{
                ZStack{
                    switch onboardingState {
                    case 0:
                        welcomeScreen
                            .transition(transition)
                    case 1 :
                        welcomeScreen1
                            .transition(transition)
                    default:
                        welcomeScreen
                    }
                }
                VStack{
                    Spacer()
                    buttonButton
                }
            }
            .padding()
            .onAppear{
                
                addAnimation()
            }
        }
        
    }
}

struct OnboardingScreen_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingScreen()
    }
}


extension OnboardingScreen {
    
    private var buttonButton:some View {
        Text("Continue")
            .frame(height:50)
            .frame(maxWidth:.infinity)
            .foregroundColor(animmate ? Color.red : Color.green)
            .background(Color.blue)
            .scaleEffect(animmate ? 1.1:1.0)
            .cornerRadius(10)
            .onTapGesture {
                handleNextButton()
            }
        
         }

    func addAnimation() {
        guard !animmate else {return}
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(Animation.easeInOut(duration: 2.0).repeatForever()) {
                animmate.toggle()
                
            }
        }
    }
    
     private var welcomeScreen:some View {
        VStack(spacing:40){
            Image("firstOnboard")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width:200,height:200)
           Text("ready to take charge of your stakes?")
                .font(.title3)
                .fontWeight(.semibold)
                .italic()
                
           }
      }
    
    
    private var welcomeScreen1:some View {
       VStack(spacing:40){
           Image("secondOnboard")
               .resizable()
               .aspectRatio(contentMode: .fill)
               .frame(width:200,height:200)
          Text("unlock Insights, Maximize Wins,Stay on Top of Your Bets")
               .font(.title3)
               .fontWeight(.semibold)
               .italic()
           NavigationLink {
               Group {
                   AdminLoginView()
               }
           }label: {
               Text("Admin")
           }
          }
     }
    
    func handleNextButton() {
        withAnimation(.spring()) {
            if onboardingState == 1 {
                withAnimation(.spring()){
                    CurentSignedIN = true
                }
            }else{
                onboardingState += 1
            }
        }
    }
 }
