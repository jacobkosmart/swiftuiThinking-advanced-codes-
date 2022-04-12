//
//  PreferenceKeyBootCamp.swift
//  SwiftThinkingAdvance
//
//  Created by Jacob Ko on 2022/04/12.
//

import SwiftUI

struct PreferenceKeyBootCamp: View {
	// MARK: -  PROPERTY
	@State  private var text: String = "Hellow world!"
	// MARK: -  BODY
	var body: some View {
		NavigationView {
			VStack {
				SecondaryScreen(text: text)
					.navigationTitle("Navigation Title")
					
			} //: VSTACK
		} //: NAVIGATION
		.onPreferenceChange(CustomTiltePreferenceKey.self) { value in
			self.text = value
		}
	}
}

// MARK: -  PREVIEW
struct PreferenceKeyBootCamp_Previews: PreviewProvider {
	static var previews: some View {
		PreferenceKeyBootCamp()
	}
}

struct SecondaryScreen: View {
	let text: String
	@State private var newValue: String = ""
	
	var body: some View {
		Text(text)
			.onAppear(perform: getDataFromDatabase)
			.customTitle(newValue)
	}
	
	func getDataFromDatabase() {
		// download fake data
		DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
			self.newValue = "New Value From DB"
		}
	}
}

extension View {
	func customTitle(_ text: String) -> some View {
			preference(key: CustomTiltePreferenceKey.self, value: text)
	}
}

struct CustomTiltePreferenceKey: PreferenceKey {
	
	static var defaultValue: String = ""
	
	static func reduce(value: inout String, nextValue: () -> String) {
		value = nextValue()
	}
}
