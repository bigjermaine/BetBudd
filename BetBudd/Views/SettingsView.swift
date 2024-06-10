//
//  SettingsView.swift
//  BetBudd
//
//  Created by MacBook AIR on 05/02/2024.
//

import SwiftUI
import UserNotifications



struct SettingsView: View {
    
    @AppStorage("UserName") var userName = "Username"
    @AppStorage("Twitter") var twitterHandle = "twitterHandle"
    @AppStorage("EMail") var eMailAdress = "user@domain.com"
    @AppStorage("YearlyBudget") var yearlyBudget = 0.0
    @AppStorage("ThePassword") var thePassword = "---"
    @AppStorage("Notifcation") var checkNotifcation = false
    @State var animmate:Bool = false
    @State private var updateUserIsPresented = false
    @State  var Toogleison:Bool = false
    @StateObject var inAppPurchase = InAppManager()
    var body: some View {
        NavigationView{
            List{
                VStack(alignment:.center){
                    Button {
                        updateUserIsPresented = true
                        
                        HapticManager.shared.vibrate(for: .success)
                        
                    } label: {
                        Image(systemName:"person.circle.fill")
                            .font(.system(size: 50))
                            .foregroundColor(animmate ? Color.red : Color.accentColor)
                            .scaleEffect(animmate ? 1.1:1.0)
                        Text("CLICK TO UPDATE")
                            .bold()
                            .foregroundColor(animmate ? Color.purple : Color.accentColor)
                            .scaleEffect(animmate ? 1.1:1.0)
                    }
                }.popover(isPresented: $updateUserIsPresented) {
                    UpdateUserView()
                }
                .frame(maxWidth:.infinity, maxHeight:80,alignment:.center)
                
                HStack {
                    Text("Name:")
                    Spacer()
                    Text("\(userName)")
                        .frame(maxWidth:120,alignment:.leading)
                }
                
                HStack {
                    Text("Twitter:")
                    Spacer()
                    Text("@\(twitterHandle)")
                        .frame(maxWidth:120,alignment:.leading)
                    
                }
                HStack {
                    Text("E-Mail:")
                    Spacer()
                    Text("\(eMailAdress)")
                        .lineLimit(1)
                        .frame(maxWidth:120,alignment:.leading)
                }
                HStack {
                    Text("Yearly budget:")
                    Spacer()
                    Text(("\(yearlyBudget)").currencyFormatting())
                        .frame(maxWidth:120,alignment:.leading)
                }
                
                
                HStack {
                    NavigationLink("Password randomizer     \(Image(systemName: "key.fill"))", destination: PasswordView())
                        .foregroundColor(.blue)
                }
                
                HStack {
                    NavigationLink("Mini game    \(Image(systemName: "gamecontroller.fill"))", destination: MiniGameView())
                        .foregroundColor(.blue)
                }
                HStack {
                    Link("Join Twitter", destination: URL(string: "https://x.com/betbudd1?s=21")!)
                  
                }
                .foregroundColor(animmate ? Color.red : Color.accentColor)
                .scaleEffect(animmate ? 1.1:1.0)
                HStack {
                    Link("Join Telegram", destination: URL(string: "https://t.me/+Ln4PHOXNdt4wNmM8")!)
                    Image("AppIcon")
                        .resizable()
                        .frame(width: 25,height: 25)
                    Spacer()
                  
                }
                .foregroundColor(animmate ? Color.red : Color.accentColor)
                .scaleEffect(animmate ? 1.1:1.0)
                if inAppPurchase.checkpurchase ?? false {
                    Text("Thanks for the coffee")
                        .font(.callout)
                }
            
            VStack{
                HStack {
                    Spacer()
                    VStack{
        
                        Text(inAppPurchase.myProduct?.localizedDescription ?? "")
                            .bold()
                            .foregroundColor(.brown)
                          Button{
                              inAppPurchase.didTapBuy()
                          }label: {
                              VStack{
                                  Image("coffee")
                                      .resizable()
                                      .aspectRatio(contentMode: .fill)
                                      .frame(width: 100,height: 50)
                                      .cornerRadius(4)
                                  Text(inAppPurchase.producePrice ?? "")
                                      .foregroundColor(.brown)
                              }
                          }
                      }
                     .opacity( inAppPurchase.checkpurchase ?? false ? 0: 1)
                   
                     Spacer()
                }
                Spacer()
            }
           
            .frame(height: inAppPurchase.checkpurchase ?? false ? 0: 200)
          
        }
      
        .navigationBarTitle("Profile").hiddenNavigationBarStyle().toolbar {
            ToolbarItem(placement: .bottomBar) {
                VStack {
                    Text("(Tap the icon at the top to update your information)").font(.footnote)
                        .foregroundColor(animmate ? Color.red : Color.accentColor)
                        .scaleEffect(animmate ? 1.1:1.0)
                }
            }
        }
        
        .onAppear {
            if !checkNotifcation {
               // NotificationManager.instance.requestauthoriztion()
            }
            addAnimation()
            UIApplication.shared.applicationIconBadgeNumber = 0
            HapticManager.shared.vibrateForSelection()
            
            }
          
         }
        .navigationViewStyle(.stack)
       
        }
    func addAnimation() {
        guard !animmate else {return}
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            checkNotifcation = true
            withAnimation(Animation.easeInOut(duration: 2.0).repeatForever()) {
                animmate.toggle()
                
            }
        }
    }

    }


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}


