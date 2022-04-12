//
//  ScrollViewOffsetPreferenceBootCamp.swift
//  SwiftThinkingAdvance
//
//  Created by Jacob Ko on 2022/04/12.
//

import SwiftUI

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
	static var defaultValue: CGFloat = 0
	static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
		value = nextValue()
	}
}

extension View {
	func onScrollViewoffsetChnaged(action: @escaping (_ offset: CGFloat) -> Void) -> some View {
		self
			.background(
				GeometryReader { geo in
						 Text("")
							 .preference(key: ScrollViewOffsetPreferenceKey.self, value: geo.frame(in: .global).minY)
					 }
				 )
			.onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
				action(value)
			}
	}
}

struct ScrollViewOffsetPreferenceBootCamp: View {
	
	let title: String = "New title here!!!"
	@State private var scrollViewOffset: CGFloat = 0
	
	var body: some View {
			ScrollView {
				VStack {
					titleLayer
						.opacity(Double(scrollViewOffset) / 63.0)
						.onScrollViewoffsetChnaged { value in
							self.scrollViewOffset = value
						}

					
					contentLayer
					
				} //: VSTACK
				.padding()
			} //: SCROLL
			.overlay(Text("\(scrollViewOffset)"))

			.overlay(
				navBarLayer
					.opacity(scrollViewOffset < 40 ? 1.0 : 0.0)
				, alignment: .top
			)
	}
}

struct ScrollViewOffsetPreferenceBootCamp_Previews: PreviewProvider {
	static var previews: some View {
		ScrollViewOffsetPreferenceBootCamp()
	}
}

extension ScrollViewOffsetPreferenceBootCamp {
	private var titleLayer: some View {
		Text(title)
			.font(.largeTitle)
			.fontWeight(.semibold)
			.frame(maxWidth: .infinity, alignment: .leading)
	}
	
	private var contentLayer: some View {
		ForEach(0..<100) { _ in
			RoundedRectangle(cornerRadius: 10)
				.fill(Color.red.opacity(0.3))
				.frame(width: 300, height: 300)
		} //: LOOP
	}
	
	private var navBarLayer: some View {
		Text(title)
			.font(.headline)
			.frame(maxWidth: .infinity)
			.frame(height: 55)
			.background(Color.blue)
	
	}
}
