//
//  ViewModifierBootCamp.swift
//  SwiftThinkingAdvance
//
//  Created by Jacob Ko on 2022/04/06.
//

import SwiftUI

// MARK: -  CUSTOM VIEWMODIFIER
struct DefaultButtonViewModifier: ViewModifier {
	let backgroundColor: Color
	
	func body(content: Content) -> some View {
		content
			.foregroundColor(.white)
			.frame(height: 55)
			.frame(maxWidth: .infinity)
			.background(backgroundColor)
			.cornerRadius(15)
			.shadow(radius: 10)
			.padding()
	}
}

// MARK: -  VIEW
struct ViewModifierBootCamp: View {
	// MARK: -  PROPERTY

	// MARK: -  BODY
	var body: some View {
		VStack {
			Text("Hello")
				.modifier(DefaultButtonViewModifier(backgroundColor: .orange))
				.font(.headline)
			
			Text("Hello, world")
				.withDefaultButtonFormatting(backgroundColor: .green)
				.font(.subheadline)
			
			// ViewModifier -> Extention 사용
			Text("Hello!!")
				.withDefaultButtonFormatting()
				.font(.title)
			
		} //: VSTACK
	}
}

// MARK: -  EXTENTION
extension View {
	func withDefaultButtonFormatting(backgroundColor: Color = .blue)-> some View {
		modifier(DefaultButtonViewModifier(backgroundColor: backgroundColor))
	}
}

// MARK: -  PREVIEW
struct ViewModifierBootCamp_Previews: PreviewProvider {
	static var previews: some View {
		ViewModifierBootCamp()
	}
}
