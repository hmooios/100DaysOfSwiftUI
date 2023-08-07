//
//  ContentView.swift
//  Rock Paper Scissors
//
//  Created by Hmoo Myat Theingi on 06/08/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var moves = ["🪨","📄","✂️"].shuffled()
    @State private var appMove = "rock"
    @State private var yourScore = 0
    @State private var scoreTitle = ""
    @State private var questionCounter = 1
    @State private var showingScore = false
    @State private var appRandomMove = Int.random(in: 0..<3)
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: .white, location: 0.3),
                .init(color: Color("purpleBackground"), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            
            VStack{
                Spacer()
                Text("Rock, Paper & Scissors!")
                    .titleFontStyle()
                Spacer()
                Text("Your score : \(yourScore)")
                Spacer()
                VStack {
                    Text("Choose to meet")
                        .font(.title3.weight(.medium))
                        .foregroundStyle(.secondary)
                    Text("Win")
                        .font(.largeTitle.bold())
                    EmojiWithCircleBackground(emoji: moves[appRandomMove], backgroundColor: Color("purpleBackground"), width: 200, height: 200, size: 100)
                    HStack {
                        ForEach(0..<3) { number in
                            Button {
                                tappedMove(number)
                            } label: {
                                EmojiWithCircleBackground(emoji: moves[number], backgroundColor: .white, width: 100, height: 100, size: 50)
                            }

                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical,20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding()
                Spacer()
                Spacer()
                Spacer()

                
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            if questionCounter != 8{
                Button("Continue", action: askQuestion)
            }else{
                Button("Restart", action: restart)
            }
        }message: {
            if questionCounter != 8{
                Text("Your score : \(yourScore)")
            }else{
                Text("Your total score is \(yourScore)! \n Press to restart the game. ")            }
        }
    }
    func tappedMove(_ move:Int){
        if move != appRandomMove{
            scoreTitle="Correct"
            yourScore+=1
        }else{
            scoreTitle = "Wrong"
        }
        questionCounter+=1
        showingScore=true
    }
    func askQuestion(){
        moves.shuffle()
        appRandomMove=Int.random(in: 0..<3)
    }
    func restart(){
        moves.shuffle()
        appRandomMove=Int.random(in: 0..<3)
        questionCounter=1
        yourScore=0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TitleFont:ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title.bold())
    }
}

struct OtherFont:ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2.weight(.medium))
    }
}

extension View{
    func titleFontStyle()->some View{
        modifier(TitleFont())
    }
    func otherFontStyle()->some View{
        modifier(OtherFont())
    }
}

struct EmojiWithCircleBackground:View{
    let emoji:String
    let backgroundColor:Color
    let width:CGFloat
    let height:CGFloat
    let size:CGFloat
    
    var body: some View{
        ZStack{
            Circle()
                .fill(backgroundColor)
                .frame(width: width,height: height)
                .shadow(radius: 7)
            Text(emoji)
                .font(.system(size: size))
        }
    }
}
