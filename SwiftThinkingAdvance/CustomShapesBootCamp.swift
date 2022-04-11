//
//  CustomShapesBootCamp.swift
//  SwiftThinkingAdvance
//
//  Created by Jacob Ko on 2022/04/07.
//

import SwiftUI

// MARK: -  VIEW
struct CustomShapesBootCamp: View {
	// MARK: -  PROPERTY
	// MARK: -  BODY
	var body: some View {
		ZStack {
			
			Trapezoid()
				.frame(width: 300, height: 150)
		} //: ZSTACK
	}
}

// MARK: -  CUSTOM SHAPE
struct Triangle: Shape {
	
	func path(in rect: CGRect) -> Path {
		Path { path in
			path.move(to: CGPoint(x: rect.midX, y: rect.minY)) // Set Starting point
			path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
			path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
			path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
		}
	}
}

struct Diamond: Shape {
	func path(in rect: CGRect) -> Path {
		Path { path in
			let horizontalOffset: CGFloat = rect.width * 0.2
			path.move(to: CGPoint(x: rect.midX, y: rect.minY))
			path.addLine(to: CGPoint(x: rect.maxX - horizontalOffset, y: rect.midY))
			path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
			path.addLine(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.midY))
			path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
		}
	}
}

struct Trapezoid: Shape {
	func path(in rect: CGRect) -> Path {
		Path { path in
			let horizontalOffset: CGFloat = rect.width * 0.2
			path.move(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.minY ))
			path.addLine(to: CGPoint(x: rect.maxX - horizontalOffset, y: rect.minY))
			path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
			path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
			path.addLine(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.minY))
		}
	}
}

// MARK: -  PREVIEW
struct CustomShapesBootCamp_Previews: PreviewProvider {
	static var previews: some View {
		CustomShapesBootCamp()
	}
}
