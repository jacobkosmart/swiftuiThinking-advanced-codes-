//
//  CustomNavBarContainerView.swift
//  SwiftThinkingAdvance
//
//  Created by Jacob Ko on 2022/04/13.
//

import SwiftUI

// MARK: -  VIEW
struct CustomNavBarContainerView<Content: View>: View {
	// MARK: -  PROPERTY
	let content: Content
	@State private var showBackButton: Bool = true
	@State private var title: String = ""
	@State private var subtitle: String? = nil
	
	init(@ViewBuilder content: () -> Content) {
		self.content = content()
	}
	// MARK: -  BODY
	var body: some View {
		VStack (spacing: 0) {
			CustomNavBarView(showBackButton: showBackButton, title: title, subtitle: subtitle)
			content
				.frame(maxWidth: .infinity, maxHeight: .infinity)
		}
		.onPreferenceChange(CustomNavBarTitilePreferenceKey.self) { value in
			self.title = value
		}
		.onPreferenceChange(CustomNavBarSubtitlePreferenceKey.self) { value in
			self.subtitle = value
		}
		.onPreferenceChange(CustomNavBarBackButtonHiddenPreferenceKey.self) { value in
			self.showBackButton = !value
		}
	}
}

// MARK: -  PREVIEW
struct CustomNavBarContainerView_Previews: PreviewProvider {
	static var previews: some View {
		CustomNavBarContainerView {
			ZStack {
				Color.green.ignoresSafeArea()
				
				Text("Hello")
					.foregroundColor(.white)
					.customNavigationTile("New Title")
					.customNavigationSubtitle("subtitle")
					.customNavigationBarBackButtonHidden(true)
			}
		}
	}
}
