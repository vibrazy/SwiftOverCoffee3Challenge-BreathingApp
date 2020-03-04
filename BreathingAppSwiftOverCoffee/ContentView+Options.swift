//
//  ContentView+Options.swift
//  BreathingAppSwiftOverCoffee
//
//  Created by Dan Tavares on 04/03/2020.
//  Copyright © 2020 Dan Tavares. All rights reserved.
//

import SwiftUI

struct Options {
	var totalCircles: Int
	var width: CGFloat
	var colors: [Color]
	var blendMode: BlendMode
	var opacity: (breathing: Double, notBreathing: Double)
	var scale: (breathing: CGFloat, notBreathing: CGFloat)
	var rotationDegrees: (breathing: Double, notBreathing: Double)
	var animation: Animation
}

// MARK: - Defaults

extension Options {
	static let animationDuration: TimeInterval = 3.4

	func position(distance: CGFloat, idx: Int) -> CGPoint {
		let angleStep = 2.0 * CGFloat.pi / CGFloat(totalCircles)
		return CGPoint(
			x: distance * cos(angleStep * CGFloat(idx)),
			y: distance * sin(angleStep * CGFloat(idx))
		)
	}
}

extension Options {
	static var `default`: Self = .init(
		totalCircles: 6,
		width: 150,
		colors: [Color.circleStart, Color.circleEnd],
		blendMode: .screen,
		opacity: (1, 0.25),
		scale: (1, 0.25),
		rotationDegrees: (60, 0),
		animation: Animation.timingCurve(
			0.5,
			0,
			0.5,
			1,
		duration: Options.animationDuration).repeatForever(autoreverses: true)
	)
}

// MARK: - Environment

struct OptionsKey: EnvironmentKey {
	static let defaultValue: Options = Options.default
}

extension EnvironmentValues {
    var options: Options {
        get {
            return self[OptionsKey.self]
        }
        set {
            self[OptionsKey.self] = newValue
        }
    }
}
