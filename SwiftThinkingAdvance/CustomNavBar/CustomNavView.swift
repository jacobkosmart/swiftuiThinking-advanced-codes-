//
//  CustomNavView.swift
//  SwiftThinkingAdvance
//
//  Created by Jacob Ko on 2022/04/13.
//

import SwiftUI

struct CustomNavView<Content:View>: View {
	// MARK: -  PROPERTY
	let content: Content
	
	init(@ViewBuilder content: () -> Content) {
		self.content = content()
	}
	// MARK: -  BODY
	var body: some View {
		NavigationView {
			CustomNavBarContainerView {
				content
			}
			.navigationBarHidden(true)
		} //: NAVIGATION
		.navigationViewStyle(.stack)
	}
}

// MARK: -  PREVIEW
struct CustomNavView_Previews: PreviewProvider {
	static var previews: some View {
		CustomNavView {
			Color.red.ignoresSafeArea()
		}
	}
}

// enable drage back gesture in CustomNavBar
extension UINavigationController {
	open override func viewDidLoad() {
		super.viewDidLoad()
		interactivePopGestureRecognizer?.delegate = nil
	}
}
