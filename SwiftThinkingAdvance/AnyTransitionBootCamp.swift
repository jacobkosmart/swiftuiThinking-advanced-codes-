//
//  AnyTransitionBootCamp.swift
//  SwiftThinkingAdvance
//
//  Created by Jacob Ko on 2022/04/07.
//

import SwiftUI

// MARK: -  VIEW
struct AnyTransitionBootCamp: View {
	// MARK: -  PROPERTY
	@State private var showRectangle: Bool = false
	// MARK: -  BODY
	var body: some View {
		VStack {
			Spacer()
			
			if showRectangle {
				RoundedRectangle(cornerRadius: 25)
					.frame(width: 250, height: 350)
					.frame(maxWidth: .infinity, maxHeight: .infinity)
					.transition(.rotateOn)
			}
			
			Spacer()
			Text("Click Me!")
				.withDefaultButtonFormatting()
				.padding(.horizontal, 40)
				.onTapGesture {
					withAnimation(.easeInOut) {
						showRectangle.toggle()
					}
				}
		} //: VSTACK
	}
}

// MARK: -  VIEWMODIFIER
struct RotateViewModifier: ViewModifier {
	let rotation: Double
	func body(content: Content) -> some View {
		content
			.rotationEffect(Angle(degrees: rotation))
			.offset(
				x: rotation != 0 ? UIScreen.main.bounds.width : 0,
				y: rotation != 0 ? UIScreen.main.bounds.height : 0)
	}
}

// MARK: -  EXTENSTION
extension AnyTransition {
	static var rotaing: AnyTransition {
		modifier(
			active: RotateViewModifier(rotation: 180),
			identity: RotateViewModifier(rotation: 0))
	}
	
	static func rotaing(rotation: Double) -> AnyTransition {
		modifier(
			active: RotateViewModifier(rotation: rotation),
			identity: RotateViewModifier(rotation: 0))
	}
	
	static var rotateOn: AnyTransition {
		asymmetric(
			insertion: .rotaing,
			removal: .move(edge: .leading))
	}
}

// MARK: -  PREVIEW
struct AnyTransitionBootCamp_Previews: PreviewProvider {
	static var previews: some View {
		AnyTransitionBootCamp()
	}
}
