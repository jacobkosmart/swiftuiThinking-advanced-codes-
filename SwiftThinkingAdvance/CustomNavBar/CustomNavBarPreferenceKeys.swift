//
//  CustomNavBarPreferenceKeys.swift
//  SwiftThinkingAdvance
//
//  Created by Jacob Ko on 2022/04/13.
//

import Foundation
import SwiftUI

struct CustomNavBarTitilePreferenceKey: PreferenceKey {
	static var defaultValue: String = ""
	
	static func reduce(value: inout String, nextValue: () -> String) {
		value = nextValue()
	}
}

struct CustomNavBarSubtitlePreferenceKey: PreferenceKey {
	static var defaultValue: String? = nil
	
	static func reduce(value: inout String?, nextValue: () -> String?) {
		value = nextValue()
	}
}
struct CustomNavBarBackButtonHiddenPreferenceKey: PreferenceKey {
	static var defaultValue: Bool = false
	
	static func reduce(value: inout Bool, nextValue: () -> Bool) {
		value = nextValue()
	}
}

extension View {
	func customNavigationTile(_ title: String) -> some View {
		self
			.preference(key: CustomNavBarTitilePreferenceKey.self, value: title)
	}
	
	func customNavigationSubtitle(_ subtitle: String?) -> some View {
		self
			.preference(key: CustomNavBarSubtitlePreferenceKey.self, value: subtitle)
	}
	
	func customNavigationBarBackButtonHidden(_ hidden: Bool) -> some View {
		self
			.preference(key: CustomNavBarBackButtonHiddenPreferenceKey.self, value: hidden)
	}
	
	// combine above three functions
	func customNavBarItems(title: String = "", subtitle: String? = nil, backButtonHidden: Bool = false) -> some View {
		self
			.customNavigationTile(title)
			.customNavigationSubtitle(subtitle)
			.customNavigationBarBackButtonHidden(backButtonHidden)
	}
}
