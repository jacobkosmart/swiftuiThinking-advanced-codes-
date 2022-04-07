//
//  MatchedGeometryEffectBootCamp.swift
//  SwiftThinkingAdvance
//
//  Created by Jacob Ko on 2022/04/07.
//

import SwiftUI

struct MatchedGeometryEffectBootCamp: View {
	// MARK: -  PROPERTY
	@State private var isClicked: Bool = false
	@Namespace private var namespace
	// MARK: -  BODY
	var body: some View {
		VStack {
			if !isClicked {
				RoundedRectangle(cornerRadius: 25.0)
					.matchedGeometryEffect(id: "rectangle", in: namespace)
					.frame(width: 100, height: 100)
			}
			
			Spacer()
			if isClicked {
				RoundedRectangle(cornerRadius: 25.0)
					.matchedGeometryEffect(id: "rectangle", in: namespace)
					.frame(width: 300, height: 200)
			}
			
		} //: VSTACK
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(Color.red)
		.onTapGesture {
			withAnimation(.easeInOut) {
				isClicked.toggle()
			}
		}
	}
}

// MARK: -  PREVIEW
struct MatchedGeometryEffectBootCamp_Previews: PreviewProvider {
	static var previews: some View {
		MatchedGeometryEffectExample2()
	}
}


struct MatchedGeometryEffectExample2: View {
	
	let categories: [String] = ["Home", "Popular", "Saved"]
	@State private var selected: String = "Home"
	@Namespace private var namespace2
	
	var body: some View {
		HStack {
			ForEach(categories, id: \.self) { category in
				ZStack {
					if selected == category  {
						RoundedRectangle(cornerRadius: 10.0)
							.fill(Color.red)
							.matchedGeometryEffect(id: "category_background", in: namespace2)
							.frame(width: 40, height: 2)
							.offset(y: 20)
					}
					Text(category)
						.foregroundColor(selected == category ? .red : .black)
				}
				.frame(maxWidth: .infinity)
				.frame(height: 55)
				.onTapGesture {
					withAnimation(.spring()) {
						selected = category
					}
				}
			} //: LOOP
		} //: HSTACK
		.padding()
	}
}
