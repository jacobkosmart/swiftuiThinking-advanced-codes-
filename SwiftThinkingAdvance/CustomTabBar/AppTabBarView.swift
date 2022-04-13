//
//  AppTabBarView.swift
//  SwiftThinkingAdvance
//
//  Created by Jacob Ko on 2022/04/12.
//

import SwiftUI

struct AppTabBarView: View {
	// MARK: -  PROPERTY
	@State private var selection: String = "home"
	@State private var tabSelection: TabBarItem = .home
	// MARK: -  BODY
	var body: some View {
		CustomTabBarContainerView(selection: $tabSelection) {
			Color.blue
				.tabBarItem(tab: .home, selection: $tabSelection)
			
			Color.red
				.tabBarItem(tab: .favorites, selection: $tabSelection)
			
			Color.green
				.tabBarItem(tab: .profile, selection: $tabSelection)
			
			Color.orange
				.tabBarItem(tab: .messages, selection: $tabSelection)
		}
	}
}

// MARK: -  PREVIEW
struct AppTabBarView_Previews: PreviewProvider {
	static var previews: some View {
		AppTabBarView()
	}
}

// MARK: -  EXTENSTION
extension AppTabBarView {
	private var defaultTabView: some View {
		TabView(selection: $selection) {
			Color.red
				.tabItem {
					Image(systemName: "house")
					Text("Home")
				}
			
			Color.blue
				.tabItem {
					Image(systemName: "heart")
					Text("Favorite")
				}
			
			Color.orange
				.tabItem {
					Image(systemName: "person")
					Text("Profile")
				}
		} //: TAB
	}
}
