//
//  CustomNavBarView.swift
//  SwiftThinkingAdvance
//
//  Created by Jacob Ko on 2022/04/13.
//

import SwiftUI

// MARK: -  VIEW
struct CustomNavBarView: View {
	// MARK: -  PROPERTY
	@Environment(\.presentationMode) var presentationMode
	let  showBackButton: Bool
	let title: String
	let subtitle: String?
	// MARK: -  BODY
	var body: some View {
		HStack {
			if showBackButton {
				backButton
			}
			Spacer()
			titleSection
			Spacer()
			if showBackButton {
				backButton
					.opacity(0)
			}
			
		} //: HSTACK
		.padding()
		.accentColor(.white)
		.foregroundColor(.white)
		.font(.headline)
		.background(Color.blue.ignoresSafeArea(edges: .top))
	}
}

// MARK: -  PREVIEW
struct CustomNavBarView_Previews: PreviewProvider {
	static var previews: some View {
		VStack {
			CustomNavBarView(showBackButton: true, title: "Title here", subtitle: "Subtitle goes here")
			Spacer()
		}
	}
}

extension CustomNavBarView {
	private var backButton: some View {
		Button {
			presentationMode.wrappedValue.dismiss()
		} label: {
			Image(systemName: "chevron.left")
		}
	}
	
	private var titleSection: some View {
		VStack (spacing: 4) {
			Text(title)
				.font(.title)
				.fontWeight(.semibold)
			if let subtitle = subtitle {
				Text(subtitle)
			}
			
		} //: VSTACK
	}
}
