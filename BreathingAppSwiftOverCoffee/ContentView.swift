//
//  ContentView.swift
//  BreathingAppSwiftOverCoffee
//
//  Created by Dan Tavares on 04/03/2020.
//  Copyright © 2020 Dan Tavares. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	@State private var isBreathing = false
	@Environment(\.options) var options: Options
	let haptic = BreatingHapticFeedback()

    var body: some View {
		ZStack {
			Color.black
			Group {
				ForEach(0..<self.options.totalCircles) { idx in
					Circle()
						.fill(LinearGradient(self.options.colors))
						.blendMode(self.options.blendMode)
						.position(self.options.position(distance: self.isBreathing ? self.options.width * 0.5 : 0, idx: idx))
						.position(x: self.options.width, y: self.options.width)
						.opacity(self.isBreathing ? self.options.opacity.breathing : self.options.opacity.notBreathing)
				}
			}
			.frame(width: self.options.width, height: self.options.width)
			.scaleEffect(self.isBreathing ? self.options.scale.breathing : self.options.scale.notBreathing)
			.rotationEffect(.degrees(self.isBreathing ? self.options.rotationDegrees.breathing : self.options.rotationDegrees.notBreathing))
		}.edgesIgnoringSafeArea(.all)
		.onAppear {
			self.haptic?.play(duration: Options.animationDuration)
			withAnimation(self.options.animation, {
				self.isBreathing.toggle()
			})
		}
    }
}
