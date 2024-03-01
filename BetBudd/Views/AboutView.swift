//
//  AboutView.swift
//  BetBudd
//
//  Created by MacBook AIR on 05/11/2023.
//

import SwiftUI

struct AboutView: View {
    
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    let appName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String
    
    var body: some View {
        ScrollView {
            VStack {
                Text("\(appName ?? "")").font(.title)
                Text("v. \(appVersion ?? "")").font(.title2)
                Divider()
                VStack {
                    Text("Created by:").font(.title3).padding()
                    Divider()
                    Text("Daniel Jermaine").font(.title2)
                    VStack(spacing: 5) {
                        HStack {
                            Text("Twitter:")
                            Spacer()
                            Link(destination: URL(string:"https://twitter.com/jerm__3")!) {
                                Text("@jerm_3")
                            }
                        }
                        HStack {
                            Text("e-mail:")
                            Spacer()
                            Text("danieljermaine97@gmail.com")
                        }
                        HStack {
                            Text("LinkedIn:")
                            Spacer()
                            Link(destination: URL(string: "https://ng.linkedin.com/in/daniel-jermaine-614114245?original_referer=")!) {
                                
                                Text("Daniel Jermaine on LinkedIn")
                            }
                        }
                    }
                    Divider()
                    Text("Patrik Ell").font(.title2)
                    VStack {
                        HStack {
                            Text("Twitter:")
                            Spacer()
                            Link(destination: URL(string:"https://twitter.com/ell470")!) {
                                Text("@ell470")
                            }
                        }
                        HStack {
                            Text("e-mail")
                            Spacer()
                            Text("ell@particle.se")
                        }
                        HStack {
                            Text("Homepage:")
                            Spacer()
                            Link(destination: URL(string: "https://particle.se")!) {
                                Text("https://particle.se")
                            }
                        }
                        HStack {
                            Text("Developer profile:")
                            Spacer()
                            Link(destination: URL(string: "https://apps.apple.com/us/developer/patrik-ell/id1591951181")!) {
                                Text("Apple App Store")
                            }
                        }
                    }
                }
                Divider()
            }.padding()
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
