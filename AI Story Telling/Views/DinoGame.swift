import SwiftUI

struct DinosaurJumpGame: View {
    @State private var dinosaurYPosition: CGFloat = 0
    @State private var jumpVelocity: CGFloat = 0
    @State private var isJumping = false
    @State private var isGameOver = false
    @State private var score = 0

    private let gravity: CGFloat = 1.5
    private let jumpStrength: CGFloat = 20
    private let groundLevel: CGFloat = 0

    private let cactusSpacing: CGFloat = 300
    private let cactusWidth: CGFloat = 40
    private let cactusHeight: CGFloat = 60

    private let gameSpeed: Double = 0.03

    private let screenHeight = UIScreen.main.bounds.height

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color("Background1")
                    .ignoresSafeArea()

                if !isGameOver {
                    VStack {
                        Spacer()
                        HStack(spacing: cactusSpacing) {
                            ForEach(0..<3) { _ in
                                CactusView(width: cactusWidth, height: cactusHeight)
                            }
                        }
                        .frame(width: geometry.size.width, alignment: .leading)
                        .offset(x: -CGFloat(score) * CGFloat(cactusSpacing) * CGFloat(gameSpeed), y: 0)

                        DinosaurView()
                            .offset(x: 0, y: dinosaurYPosition)

                        Spacer()
                    }
                } else {
                    GameOverView(score: score, restartGame: restartGame)
                }
            }
            .onAppear {
                startGameLoop()
            }
            .onTapGesture {
                if !isJumping && !isGameOver {
                    jump()
                } else if isGameOver {
                    restartGame()
                }
            }
        }
    }

    private func jump() {
        jumpVelocity = -jumpStrength
        isJumping = true
    }

    private func startGameLoop() {
        Timer.scheduledTimer(withTimeInterval: gameSpeed, repeats: true) { _ in
            updateGameState()
        }
    }

    private func updateGameState() {
        if isJumping {
            dinosaurYPosition += jumpVelocity
            jumpVelocity += gravity
        }

        if dinosaurYPosition >= groundLevel {
            dinosaurYPosition = groundLevel
            isJumping = false
        }

        if isColliding() {
            endGame()
        }

        if !isGameOver {
            score += 1
        }
    }

    private func isColliding() -> Bool {
        let dinosaurFrame = CGRect(x: 0, y: dinosaurYPosition, width: 60, height: 60)

        for i in 0..<3 {
            let cactusFrame = CGRect(x: CGFloat(i) * cactusSpacing - CGFloat(score) * CGFloat(cactusSpacing) * CGFloat(gameSpeed), y: groundLevel, width: cactusWidth, height: cactusHeight)
            if dinosaurFrame.intersects(cactusFrame) {
                return true
            }
        }

        return false
    }

    private func endGame() {
        isGameOver = true
    }

    private func restartGame() {
        dinosaurYPosition = 0
        jumpVelocity = 0
        isJumping = false
        isGameOver = false
        score = 0
    }
}

struct CactusView: View {
    let width: CGFloat
    let height: CGFloat

    var body: some View {
        Image("Cactus")
            .resizable()
            .frame(width: width, height: height)
    }
}

struct DinosaurView: View {
    var body: some View {
        Image("Dinosaur")
            .resizable()
            .frame(width: 60, height: 60)
    }
}

struct GameOverView: View {
    let score: Int
    let restartGame: () -> Void

    var body: some View {
        VStack {
            Text("Game Over")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
            Text("Score: \(score)")
                .font(.headline)
                .foregroundColor(Color.white)
            Text("Tap to play again")
                .font(.subheadline)
                .foregroundColor(Color.white)
        }
        .onAppear(perform: restartGame)
    }
}

struct DinosaurJumpGame_Previews: PreviewProvider {
    static var previews: some View {
        DinosaurJumpGame()
    }
}
