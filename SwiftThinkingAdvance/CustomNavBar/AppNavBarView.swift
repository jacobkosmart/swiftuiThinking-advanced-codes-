//
//  AppNavBarView.swift
//  SwiftThinkingAdvance
//
//  Created by Jacob Ko on 2022/04/13.
//

import SwiftUI

struct AppNavBarView: View {
	// MARK: -  BODY
	var body: some View {
		CustomNavView {
			ZStack {
				Color.orange.ignoresSafeArea()
				
				CustomNavLink(destination:
												Text("Destination")
												.customNavigationTile("Second Screen")
												.customNavigationSubtitle("Sibtitle should be showing!!")
				) {
					Text("Navigate")
				}
			} //: ZSTACK
			.customNavBarItems(title: "New Title!", subtitle: nil, backButtonHidden: true)
		}
	}
}

// MARK: -  PREVIEW
struct AppNavBarView_Previews: PreviewProvider {
	static var previews: some View {
		AppNavBarView()
	}
}

// MARK: -  EXTENSTION
extension AppNavBarView {
	private var defaultNavView: some View {
		NavigationView {
			ZStack {
				Color.green.ignoresSafeArea()
				
				NavigationLink(destination: Text("Destination")
												.navigationTitle("Title 2")
												.navigationBarBackButtonHidden(false)) {
					Text("Navigate")
				}
			}
			.navigationTitle("Nav title here")
		} //: NAVIGATION
	}
}
