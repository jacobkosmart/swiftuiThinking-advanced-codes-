//
//  TabBarItemsPreferenceKey.swift
//  SwiftThinkingAdvance
//
//  Created by Jacob Ko on 2022/04/13.
//

import Foundation
import SwiftUI

// MARK: -  Create PreferenceKey
struct TabBarItemsPreferenceKey: PreferenceKey {
	
	static var defaultValue: [TabBarItem] = []
	
	static func reduce(value: inout [TabBarItem], nextValue: () -> [TabBarItem]) {
		value += nextValue()
	}
}

// MARK: -  ViewModifier
struct TabBarItemViewModifier: ViewModifier {
	
	let tab: TabBarItem
	@Binding var selection: TabBarItem
	
	func body(content: Content) -> some View {
		content
			.opacity(selection == tab ? 1.0 : 0.0)
			.preference(key: TabBarItemsPreferenceKey.self, value: [tab])
	}
}

// MARK: -  Extenstion
extension View {
	func tabBarItem(tab: TabBarItem, selection: Binding<TabBarItem>) -> some View {
		self
			.modifier(TabBarItemViewModifier(tab: tab, selection: selection))
	}
}
