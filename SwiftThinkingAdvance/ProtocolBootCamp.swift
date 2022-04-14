//
//  ProtocolBootCamp.swift
//  SwiftThinkingAdvance
//
//  Created by Jacob Ko on 2022/04/13.
//

import SwiftUI

// MARK: -  VIEWMODEL
class DefaultDataSource: ButtonTextProtocol, ButtonPressedProtocol {
	var buttonText: String = "Protocol are Awesome"
	
	func buttonPressed() {
		print("Button was pressed!")
	}
}

class AlternativeDataSource: ButtonTextProtocol {
	var buttonText: String = "Protocol are Cool"
	func buttonPressed() {
		
	}
}


// MARK: -  VIEW
struct ProtocolBootCamp: View {
	// MARK: -  PROPERTY
	// let colorTheme: DefaultColorTheme = DefaultColorTheme()
	// let colorTheme: AlternativeColorTheme = AlternativeColorTheme()
	let colorTheme: ColorThemeProtocol
	let dataSource: ButtonTextProtocol
	let dataSource2: ButtonPressedProtocol
	
	// MARK: -  BODY
	var body: some View {
		ZStack {
			colorTheme.tertiary.ignoresSafeArea()
			
			Text(dataSource.buttonText)
				.font(.headline)
				.foregroundColor(colorTheme.secondary)
				.padding()
				.background(colorTheme.primary)
				.cornerRadius(10)
				.onTapGesture {
					dataSource2.buttonPressed()
				}
		}
	}
}

// // MARK: -  PREVIEW
// struct ProtocolBootCamp_Previews: PreviewProvider {
// 	static var previews: some View {
// 		ProtocolBootCamp(colorTheme: DefaultColorTheme(), dataSource2: DefaultDataSource())
// 	}
// }

// MARK: -  ColorTheme
struct DefaultColorTheme: ColorThemeProtocol {
	let primary: Color = .blue
	let secondary: Color = .white
	let tertiary: Color = .gray
}

struct AlternativeColorTheme: ColorThemeProtocol {
	let primary: Color = .red
	let secondary: Color = .white
	let tertiary: Color = .green
}

struct AnotherColorTheme: ColorThemeProtocol {
	var primary: Color = .blue
	var secondary: Color = .red
	var tertiary: Color = .purple
}

// MARK: -  PROTOCOL
protocol ColorThemeProtocol {
	var primary: Color { get }
	var secondary: Color { get }
	var tertiary: Color { get }
}

protocol ButtonTextProtocol {
	var buttonText: String { get }

}

protocol ButtonPressedProtocol {
	func buttonPressed()
}
