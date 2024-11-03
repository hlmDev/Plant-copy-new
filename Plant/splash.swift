import SwiftUI
import AVFoundation

struct splash: View {
    @State private var size = 0.6
    @State private var opacity = 0.0
    @State private var showMainPage = false
    @State private var displayedText = ""
    @State private var audioPlayer: AVAudioPlayer?

    let fullText = "Care about your Plants 🪴"

    var body: some View {
        if showMainPage {
            Mainpage()
        } else {
            VStack {
                Image("plant")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .scaleEffect(size)
                Text(displayedText)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            .opacity(opacity)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
            .onAppear {
                playSound(sound: "doitt", type: "mp3")

                withAnimation(.easeIn(duration: 1.2)) {
                    size = 1.1
                    opacity = 1.0
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    startTyping()
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    withAnimation(.easeOut(duration: 0.5)) {
                        opacity = 0.0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        showMainPage = true
                    }
                }
            }
        }
    }

    func startTyping() {
        displayedText = ""
        var delay = 0.0
        for letter in fullText {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                displayedText.append(letter)
            }
            delay += 0.05
        }
    }

    func playSound(sound: String, type: String) {
        if let url = Bundle.main.url(forResource: sound, withExtension: type) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.volume = 1.0
                audioPlayer?.play()
                print("Playing sound: \(sound).\(type)")
            } catch {
                print("Error: Could not play sound file.")
            }
        } else {
            print("Error: Sound file \(sound).\(type) not found.")
        }
    }
}

struct splash_Previews: PreviewProvider {
    static var previews: some View {
        splash()
    }
}
