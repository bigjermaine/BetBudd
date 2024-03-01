//
//  MiniGameView.swift
//  BetBudd
//
//  Created by MacBook AIR on 05/11/2023.
//
import SwiftUI
import AVFoundation

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

class SoundManager {
    static let instance = SoundManager()
    
    var player: AVAudioPlayer?
    
    enum SoundOption: String {
        case dice
        case win
        case lose
        case wahwah
    }
    
    func playSound(sound: SoundOption) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
}

struct MiniGameView: View {
    
    @State private var playerDie1 = 0
    @State private var playerDie2 = 0
    @State private var playerDie3 = 0
    @State private var playerBalance = 5000.0
    @State private var Playerhealth = 0.0
    @State private var playerDieSum = 0
    
    @State private var playerArray = ["square", "die.face.1", "die.face.2", "die.face.3", "die.face.4", "die.face.5", "die.face.6"]
    
    @State private var cpuArray = ["square", "die.face.1", "die.face.2", "die.face.3", "die.face.4", "die.face.5", "die.face.6"]
    
    @State private var cpuDie1 = 0
    @State private var cpuDie2 = 0
    @State private var cpuDie3 = 0
    @State private var cpuDieSum = 0
    
    @State private var gameMessage = "Tap button to roll the first die."
    @State private var buttonText = "Roll die!"
    @State private var inputhealth = ""
    @State private var gamePhase = 1
  
    @State private var dieSize1 = 42.0
    @State private var dieSize2 = 42.0
    @State private var dieSize3 = 42.0
    
    @State private var animationPlaying = false
    
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        VStack {
//            BannerAd(unitID:"ca-app-pub-8615080964851557/4338181789")
//                .frame(height:80)
//                .padding()
            Spacer()
            VStack(spacing: 5) {
                Text("Fighter").font(.title)
                Divider()
                HStack {
                    Text("\(Image(systemName: playerArray[playerDie1]))").font(.system(size: dieSize1))
                    
                    Text("\(Image(systemName: playerArray[playerDie2]))").font(.system(size: dieSize2))
                        
                    Text("\(Image(systemName: playerArray[playerDie3]))").font(.system(size: dieSize3))
                }
                Divider()
                VStack(alignment: .leading) {
                    Text("Balance: \(playerBalance, specifier: "%.0f") credits.")
                    Text("Current health: \(Playerhealth, specifier: "%.0f")")
                }.font(.title3)
            }
            Spacer()
            VStack(spacing: 5) {
                Text("The house").font(.title)
                Divider()
                HStack {
                    Text("\(Image(systemName: cpuArray[cpuDie1]))").font(.system(size: dieSize1))
                    Text("\(Image(systemName: cpuArray[cpuDie2]))").font(.system(size: dieSize2))
                    Text("\(Image(systemName: cpuArray[cpuDie3]))").font(.system(size: dieSize3))
                }
                Divider()
                Text(gameMessage)
            }
            TextField("Health:", text: $inputhealth).keyboardType(.numberPad).textFieldStyle(.roundedBorder).frame(width: screenWidth / 2)
            Button("\(buttonText)", action: {
                playGame()
                HapticManager.shared.vibrateForSelection()
            }).buttonStyle(.bordered)
            Spacer()
            Spacer()
          
        }
    }
    func playGame() {
        
        if gamePhase == 1 {
            playerDie2 = 0
            playerDie3 = 0
            cpuDie2 = 0
            cpuDie3 = 0
            withAnimation(.easeOut(duration: 0.3)) {
                dieSize1 = 8.0
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    withAnimation(.easeIn(duration: 0.3)) {
                        SoundManager.instance.playSound(sound: .dice)
                        playerDie1 = Int.random(in: 1...6)
                        cpuDie1 = Int.random(in: 1...6)
                        
                        dieSize1 = 42.0
                    }
                }
            }
            gameMessage = "Input amount The minimum Health is 50 Health."
            buttonText = "Play"
            gamePhase += 1
            
        }
        else if gamePhase == 2 {
            if inputhealth.toDouble() ?? 0.0 < 50 || inputhealth.isEmpty == true {
                Playerhealth = 50
                playerBalance -= 50
            }
            else if inputhealth.toDouble() ?? 0.0 <= playerBalance {
                Playerhealth = inputhealth.toDouble() ?? 50.0
                playerBalance -= inputhealth.toDouble() ?? 50.0
            }
            else if inputhealth.toDouble() ?? 0.0 > playerBalance {
                Playerhealth = playerBalance
                playerBalance -= playerBalance
            }
            gameMessage = "Tap button to roll second die."
            buttonText = "Roll die!"
            inputhealth = ""
            gamePhase += 1
            self.hideKeyboard()
        }
        else if gamePhase == 3 {
            withAnimation(.easeOut(duration: 0.3)) {
                dieSize2 = 8.0
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    withAnimation(.easeIn(duration: 0.3)) {
                        SoundManager.instance.playSound(sound: .dice)
                        playerDie2 = Int.random(in: 1...6)
                        cpuDie2 = Int.random(in: 1...6)
                        
                        dieSize2 = 42.0
                    }
                }
            }
            gameMessage = "Input amount between 0 - 500 to raise Health."
            buttonText = "Raise Health!"
            gamePhase += 1
        }
        else if gamePhase == 4 {
            if inputhealth.toDouble() ?? 0.0 <= 500 && inputhealth.toDouble() ?? 0.0 < playerBalance && inputhealth.isEmpty == false {
                Playerhealth += inputhealth.toDouble() ?? 0.0
                playerBalance -= inputhealth.toDouble() ?? 0.0
            }
            else if inputhealth.toDouble() ?? 0.0 > 500 && 500 <= playerBalance && inputhealth.isEmpty == false {
                Playerhealth += 500
                playerBalance -= 500
            }
            else if inputhealth.toDouble() ?? 0.0 > playerBalance {
                Playerhealth += playerBalance
                playerBalance = 0
            }
            gameMessage = "Tap button to roll the third die."
            buttonText = "Roll die!"
            inputhealth = ""
            gamePhase += 1
            self.hideKeyboard()
        }
        else if gamePhase == 5 {
            withAnimation(.easeOut(duration: 0.3)) {
                dieSize3 = 8.0
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    withAnimation(.easeIn(duration: 0.3)) {
                        SoundManager.instance.playSound(sound: .dice)
                        playerDie3 = Int.random(in: 1...6)
                        cpuDie3 = Int.random(in: 1...6)
                        
                        dieSize3 = 42.0
                    }
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                playerDieSum = playerDie1 + playerDie2 + playerDie3
                cpuDieSum = cpuDie1 + cpuDie2 + cpuDie3
                
                if playerDieSum > cpuDieSum {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        SoundManager.instance.playSound(sound: .win)
                    }
                    gameMessage = "You won! Tap button to go again!"
                    buttonText = "Roll die!"
                    playerBalance += Playerhealth * 2
                    Playerhealth = 0
                    gamePhase = 1
                }
                else if playerDieSum < cpuDieSum && playerBalance > 0 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        SoundManager.instance.playSound(sound: .lose)
                    }
                    gameMessage = "The house won... Tap button to go again!"
                    buttonText = "Roll die!"
                    Playerhealth = 0
                    gamePhase = 1
                    
                }
                else if playerDieSum < cpuDieSum && playerBalance <= 0 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        SoundManager.instance.playSound(sound: .wahwah)
                    }
                    gameMessage = "The house cleaned you out. Tap button to play another round."
                    buttonText = "Start over!"
                    gamePhase += 1
                }
                else if playerDieSum == cpuDieSum {
                    gameMessage = "It's a draw! Tap button to go again!"
                    buttonText = "Roll die!"
                    playerBalance += Playerhealth
                    Playerhealth = 0
                    gamePhase = 1
                }
            }
        }
        else if gamePhase == 6 {
          
            playerBalance = 5000
            Playerhealth = 0
            gameMessage = "Tap button to roll the first die!"
            buttonText = "Roll die!"
            playerDie1 = 0
            playerDie2 = 0
            playerDie3 = 0
            cpuDie1 = 0
            cpuDie2 = 0
            cpuDie3 = 0
            gamePhase = 1
        }
    }
}

struct MiniGameView_Previews: PreviewProvider {
    static var previews: some View {
        MiniGameView()
    }
}
