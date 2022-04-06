//
//  ButtonStyleBootCamp.swift
//  SwiftThinkingAdvance
//
//  Created by Jacob Ko on 2022/04/06.
//

import SwiftUI

// MARK: -  VIEW
struct ButtonStyleBootCamp: View {
	// MARK: -  PROPERTY
	// MARK: -  BODY
	var body: some View {
		Button {
			
		} label: {
			Text("Click me")
				.font(.headline)
				.foregroundColor(.white)
				.frame(height: 55)
				.frame(maxWidth: .infinity)
				.background(Color.blue.cornerRadius(10))
				.shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0.0, y: 10.0)
		}
		// .buttonStyle(PlainButtonStyle())
		// .buttonStyle(PressableStyle())
		.withPressableStyle()
		.padding(40)

	}
}

// MARK: -  VIEWMODIFIER
struct PressableStyle: ButtonStyle {
	
	let scaledAmount: CGFloat
	
	// set default scaleAmount
	init(scaledAmount: CGFloat) {
		self.scaledAmount = scaledAmount
	}
	
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.scaleEffect(configuration.isPressed ? scaledAmount : 1.0)
			.opacity(configuration.isPressed ? 0.9 : 1.0)
			.brightness(configuration.isPressed ? 0.05 : 0)
	}
}

// MARK: -  EXTENSTION
extension View {
	func withPressableStyle(scaledAmount: CGFloat = 0.9) -> some View {
		self.buttonStyle(PressableStyle(scaledAmount: scaledAmount))
	}
}

// MARK: -  PREVIEW
struct ButtonStyleBootCamp_Previews: PreviewProvider {
	static var previews: some View {
		ButtonStyleBootCamp()
	}
}
