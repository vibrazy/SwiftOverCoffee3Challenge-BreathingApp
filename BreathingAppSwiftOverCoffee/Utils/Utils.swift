//
//  Utils.swift
//  BreathingAppSwiftOverCoffee
//
//  Created by Dan Tavares on 04/03/2020.
//  Copyright © 2020 Dan Tavares. All rights reserved.
//

import SwiftUI

extension Color {
	static let circleStart = Color(red: 125/255, green: 218/255, blue: 160/255)
    static let circleEnd = Color(red: 84/255, green: 161/255, blue: 176/255)
}

extension LinearGradient {
    init(_ colors: [Color]) {
        self.init(
			gradient: Gradient(colors: colors),
			startPoint: .topLeading,
			endPoint: .bottomTrailing
		)
    }
}
