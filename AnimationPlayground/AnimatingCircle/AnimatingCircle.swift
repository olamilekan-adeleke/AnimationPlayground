//
//  AnimatingCircle.swift
//  AnimationPlayground
//
//  Created by Kod Enigma on 20/07/2024.
//

import SwiftUI

struct AnimatingCircle: View {
    @State private var scaleInOut = false
    @State private var rotateInOut = false
    @State private var moveInOut = false

    var body: some View {
        ZStack {
            Rectangle().edgesIgnoringSafeArea(.all)

            ZStack {
                circlePairs(0, colors: [Color.teal, .white])
                circlePairs(60, colors: [Color.teal, Color.white])
                circlePairs(120, colors: [Color.teal, Color.white])
            }
            .rotationEffect(.degrees(rotateInOut ? 90 : 0))
            .scaleEffect(scaleInOut ? 1 : 1 / 4)
            .animation(.easeInOut.repeatForever(autoreverses: true).speed(1 / 8))
            .onAppear {
                withAnimation {
                    moveInOut.toggle()
                    scaleInOut.toggle()
                    rotateInOut.toggle()
                }
            }
        }
    }

    @ViewBuilder func circlePairs(_ degree: CGFloat, colors: [Color]) -> some View {
        ZStack {
            Circle().fill(LinearGradient(gradient: Gradient(colors: colors), startPoint: .top, endPoint: .bottom))
                .frame(width: 120, height: 120)
                .offset(y: moveInOut ? -60 : 0)

            Circle().fill(LinearGradient(gradient: Gradient(colors: colors), startPoint: .bottom, endPoint: .top))
                .frame(width: 120, height: 120)
                .offset(y: moveInOut ? 60 : 0)
        }
        .opacity(0.5)
        .rotationEffect(.degrees(degree))
    }
}

#Preview {
    AnimatingCircle()
}
