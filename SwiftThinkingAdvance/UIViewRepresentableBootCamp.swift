//
//  UIViewRepresentableBootCamp.swift
//  SwiftThinkingAdvance
//
//  Created by Jacob Ko on 2022/04/13.
//

import SwiftUI

// Convert a UIView from UIKit to SwiftUI
struct UIViewRepresentableBootCamp: View {
	// MARK: -  PROPERTY
	@State private var text: String = ""
	// MARK: -  BODY
	var body: some View {
		VStack {
			Text(text)
			
			HStack {
				Text("SwiftUI:")
				TextField("Type here..", text: $text)
					.frame(height: 55)
					.background(Color.gray.opacity(0.2))
			}
			
			HStack {
				Text("UIKit")
				UITextFieldViewRepresentable(text: $text)
					.updatePlaceholder("New Placeholder")
					.frame(height: 55)
					.background(Color.gray.opacity(0.2))
			}
			
		} //: VSTACK
	}
}

// MARK: -  PREVIEW
struct UIViewRepresentableBootCamp_Previews: PreviewProvider {
	static var previews: some View {
		UIViewRepresentableBootCamp()
	}
}

struct UITextFieldViewRepresentable: UIViewRepresentable {
	
	@Binding var text: String
	var placeholder: String
	let placeholderColor: UIColor
	
	init(text: Binding<String>, placeholder: String = "Default placeholder...", placeholderColor: UIColor = .red) {
		self._text = text
		self.placeholder = placeholder
		self.placeholderColor = placeholderColor
	}
	
	func makeUIView(context: Context) -> UITextField {
		let textfield = getTextField()
		textfield.delegate = context.coordinator
		return textfield
	}
	
	// send data from SwiftUI to UIKit
	func updateUIView(_ uiView: UITextField, context: Context) {
		uiView.text = text
	}
	
	private func getTextField() -> UITextField {
		let textfield = UITextField(frame: .zero)
		let placeholder = NSAttributedString(
			string: placeholder,
			attributes: [
				.foregroundColor : placeholderColor
			])
		textfield.attributedPlaceholder = placeholder
		// textfield.delegate
		return textfield
	}
	
	func updatePlaceholder(_ text: String) -> UITextFieldViewRepresentable {
		var viewRepresentable = self
		viewRepresentable.placeholder = text
		return viewRepresentable
	}
	
	// Send data from UIKit to SwiftUI
	func makeCoordinator() ->Coordinator {
		return Coordinator(text: $text)
	}
	
	class Coordinator: NSObject, UITextFieldDelegate {
		
		@Binding var text: String
		
		init(text: Binding<String>) {
			self._text = text
		}
		func textFieldDidChangeSelection(_ textField: UITextField) {
			text = textField.text ?? ""
		}
	}
}
