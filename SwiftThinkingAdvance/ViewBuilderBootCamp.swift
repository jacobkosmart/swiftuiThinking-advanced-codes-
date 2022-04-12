//
//  ViewBuilderBootCamp.swift
//  SwiftThinkingAdvance
//
//  Created by Jacob Ko on 2022/04/12.
//

import SwiftUI

// MARK: -  VIEW
struct ViewBuilderBootCamp: View {
	// MARK: -  PROPERTY

	// MARK: -  BODY
	var body: some View {
		VStack {
			HeaderViewRegular(title: "New Title", description: "Hello", iconName: "heart.fill")
			HeaderViewRegular(title: "Another Title", description: nil, iconName: nil)
			
			HeaderViewGeneric(title: "Generic Tilte") {
				HStack {
					Text("Hi")
					Image(systemName: "heart.fill")
				} //: HSTACK
			}
			
			CustomHStack {
				Text("Hi 1")
				Text("Hi 2")
			}
			HStack {
				Text("Hi 3")
				Text("Hi 4")
			}
			Spacer()
		} //: VSTACK
	}
}

// MARK: -  EXTENSTION
struct HeaderViewRegular: View {
	let title: String
	let description: String?
	let iconName: String?
	
	var body: some View {
		VStack(alignment: .leading, spacing: 10) {
			Text(title)
				.font(.largeTitle)
				.fontWeight(.semibold)
			
			if let description = description {
				Text(description)
					.font(.callout)
			}
			if let iconName = iconName {
				Image(systemName: iconName)
			}
			
			RoundedRectangle(cornerRadius: 5)
				.frame(height: 2)
			
		} //: VSTACK
		.frame(maxWidth: .infinity, alignment: .leading)
		.padding()
	}
}

struct HeaderViewGeneric<Content:View>: View {
	
	let title: String
	let content: Content
	
	init(title: String, @ViewBuilder content: () -> Content) {
		self.title = title
		self.content = content()
	}
	
	var body: some View {
		VStack(alignment: .leading, spacing: 10) {
			Text(title)
				.font(.largeTitle)
				.fontWeight(.semibold)
			
			content
			
			// if let description = description {
			// 	Text(description)
			// 		.font(.callout)
			// }
			// if let iconName = iconName {
			// 	Image(systemName: iconName)
			// }
			//
			RoundedRectangle(cornerRadius: 5)
				.frame(height: 2)
		} //: VSTACK
		.frame(maxWidth: .infinity, alignment: .leading)
		.padding()
	}
}

struct CustomHStack<Content:View>: View {
	let content: Content
	
	init(@ViewBuilder content: () -> Content) {
		self.content = content()
	}
	var body: some View {
		HStack {
			content
		}
	}
}

// MARK: -  PREVIEW
struct ViewBuilderBootCamp_Previews: PreviewProvider {
	static var previews: some View {
		// ViewBuilderBootCamp()
		LocalViewBuilder(type: .one)
	}
}

struct LocalViewBuilder: View {
	enum ViewType {
		case one, two, three
	}
	let type: ViewType
	
	@ViewBuilder  private var headerSection: some View {
		switch type {
		case .one:
			viewOne
		case .two:
			viewTwo
		case .three:
			viewThree
		}
		// if type == .one {
		// 	viewOne
		// } else if type == .two {
		// 	viewTwo
		// } else if type == .three {
		// 	viewThree
		// }
	}
	
	private var viewOne: some View {
		Text("One!")
	}
	private var viewTwo: some View {
		VStack {
			Text("Two")
			Image(systemName: "heart.fill")
		}
	}
	private var viewThree: some View {
		Image(systemName: "heart.fill")
	}
	var body: some View {
		VStack {
			headerSection
		} //: VSTACK
	}
	
}
