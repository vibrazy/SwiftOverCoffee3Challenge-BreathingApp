//
//  BreatingHapticFeedback.swift
//  BreathingAppSwiftOverCoffee
//
//  Created by Dan Tavares on 04/03/2020.
//  Copyright © 2020 Dan Tavares. All rights reserved.
//	https://www.hackingwithswift.com/example-code/core-haptics/how-to-modify-haptic-events-over-time-using-chhapticparametercurve
//

import CoreHaptics

final class BreatingHapticFeedback {
	private var engine: CHHapticEngine?
	private var player: CHHapticAdvancedPatternPlayer?
	init?() {
		guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

		do {
			engine = try CHHapticEngine()
			try engine?.start()
		} catch {
			print("There was an error creating the engine: \(error.localizedDescription)")
			return nil
		}
	}

	func play(duration: TimeInterval) {
		let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0)
		let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)

		let start = CHHapticParameterCurve.ControlPoint(relativeTime: 0.5, value: Float(duration))
		let end = CHHapticParameterCurve.ControlPoint(relativeTime: duration, value: 0)

		let parameter = CHHapticParameterCurve(parameterID: .hapticIntensityControl, controlPoints: [start, end], relativeTime: 0.5)

		let event = CHHapticEvent(eventType: .hapticContinuous, parameters: [sharpness, intensity], relativeTime: 0.5, duration: duration)

		do {
			let pattern = try CHHapticPattern(events: [event], parameterCurves: [parameter])
			player = try engine?.makeAdvancedPlayer(with: pattern)
			self.startPlaying()

			Timer.scheduledTimer(withTimeInterval: duration * 2, repeats: true) { timer in
				self.startPlaying()
			}
		} catch {
			// add your own meaningful error handling here!
			print(error.localizedDescription)
		}
	}

	private func startPlaying() {
		do {
			try player?.start(atTime: 0)
		} catch {
			print(error.localizedDescription)
		}
	}
}
