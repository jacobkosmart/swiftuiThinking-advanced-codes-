//
//  GeometryPreferenceBootCamp.swift
//  SwiftThinkingAdvance
//
//  Created by Jacob Ko on 2022/04/12.
//

import SwiftUI

struct GeometryPreferenceBootCamp: View {
	// MARK: -  PROPERTY
	@State private var rectSize: CGSize = .zero
	// MARK: -  BODY
	var body: some View {
		VStack(spacing: 50) {
			Text("Hello")
				.frame(width: rectSize.width, height: rectSize.height)
				.background(Color.blue)
			
			
			HStack {
				Rectangle()
				
				GeometryReader { geo in
					Rectangle()
						.updateRectangleGeoSize(geo.size)
				}
				
				Rectangle()
			}
			.frame(height: 55)
		} //: VSTACK
		.onPreferenceChange(RectangleGeometrySizePreferenceKey.self) { value in
			self.rectSize = value
		}
	}
}

// MARK: -  PREVIEW
struct GeometryPreferenceBootCamp_Previews: PreviewProvider {
	static var previews: some View {
		GeometryPreferenceBootCamp()
	}
}

extension View {
	func updateRectangleGeoSize(_ size: CGSize) -> some View {
		preference(key: RectangleGeometrySizePreferenceKey.self, value: size)
	}
}

struct RectangleGeometrySizePreferenceKey: PreferenceKey {
	static var defaultValue: CGSize = .zero
	
	static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
		value = nextValue()
	}
}
