//
//  TabBarItem.swift
//  SwiftThinkingAdvance
//
//  Created by Jacob Ko on 2022/04/13.
//

import Foundation
import SwiftUI

// struct TabBarItem: Hashable {
// 	let iconName: String
// 	let title: String
// 	let color: Color
// }

// Model is handy when you don't know the actual data tat you're going to get
// TabBar specifically we actually have all that data in our code
// We have all of the data already it will actually be easier to make this tab bar item and enum instead of struct

enum TabBarItem: Hashable {
	case home, favorites, profile, messages
	
	var iconName: String {
		switch self {
		case .home: return "house"
		case .favorites: return "heart"
		case .profile: return "person"
		case .messages: return "message"
		}
	}
	
	var title: String {
		switch self {
		case .home: return "Home"
		case .favorites: return "Favorites"
		case .profile: return "Profile"
		case .messages: return "Messages"
		}
	}
	
	var color: Color {
		switch self {
		case .home: return Color.blue
		case .favorites: return Color.red
		case .profile: return Color.green
		case .messages: return Color.orange
		}
	}
}


