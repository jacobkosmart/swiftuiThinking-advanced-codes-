//
//  AnimatableDataBootCamp.swift
//  SwiftThinkingAdvance
//
//  Created by Jacob Ko on 2022/04/11.
//

import SwiftUI

// MARK: -  VIEW
struct AnimatableDataBootCamp: View {
	// MARK: -  PROPERTY
	@State private var animate: Bool = false
	// MARK: -  BODY
	var body: some View {
		ZStack {
			// RoundedRectangle(cornerRadius: animate ? 60 : 0)
			// RectangleWithSingleCornerAnimation(cornerRadius: animate ? 60 : 0)
			Pacman(offsetAmount: animate ? 20 : 0)
				.frame(width: 250, height: 250)
		} //: ZSTACK
		.onAppear {
			withAnimation(Animation.easeInOut.repeatForever()) {
				animate.toggle()
			}
		}
	}
}

// MARK: -  PREVIEW
struct AnimatableDataBootCamp_Previews: PreviewProvider {
	static var previews: some View {
		AnimatableDataBootCamp()
	}
}

// MARK: -  CUSTOM SHAPE
struct RectangleWithSingleCornerAnimation: Shape {
	
	var cornerRadius: CGFloat
	var animatableData: CGFloat {
		get { cornerRadius }
		set { cornerRadius = newValue }
	}
	
	func path(in rect: CGRect) -> Path {
		Path { path in
			path.move(to: .zero)
			path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
			path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))
			
			path.addArc(
				center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius),
				radius: cornerRadius,
				startAngle: Angle(degrees: 0),
				endAngle: Angle(degrees: 360),
				clockwise: false)
			path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY ))
			path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
		}
	}
}

struct Pacman: Shape {
	
	var offsetAmount: Double
	var animatableData: Double {
		get { offsetAmount }
		set { offsetAmount = newValue }
	}
	
	func path(in rect: CGRect) -> Path {
		Path { path in
			path.move(to: CGPoint(x: rect.midX, y: rect.midY))
			path.addArc(
				center: CGPoint(x: rect.midX, y: rect.midY),
				radius: rect.height / 2,
				startAngle: Angle(degrees: offsetAmount),
				endAngle: Angle(degrees: 360 - offsetAmount),
				clockwise: false)
		}
	}
}
