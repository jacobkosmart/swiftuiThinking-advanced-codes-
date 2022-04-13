//
//  UIViewControllerRepresentableBootCamp.swift
//  SwiftThinkingAdvance
//
//  Created by Jacob Ko on 2022/04/13.
//

import SwiftUI

struct UIViewControllerRepresentableBootCamp: View {
	// MARK: -  PROPERTY
	@State private var showScreen: Bool = false
	@State private var image: UIImage? = nil
	// MARK: -  BODY
	var body: some View {
		VStack {
			Text("Hi")
			
			if let image = image {
				Image(uiImage: image)
					.resizable()
					.scaledToFit()
					.frame(width: 200, height: 200)
			}
			
			Button {
				showScreen.toggle()
			} label: {
				Text("Click Here")
			}
			.sheet(isPresented: $showScreen) {
				UIImagePickerControllerRepresentable(image: $image, showScreen: $showScreen)
			}
		}
	}
}

// MARK: -  PREVIEW
struct UIViewControllerRepresentableBootCamp_Previews: PreviewProvider {
	static var previews: some View {
		UIViewControllerRepresentableBootCamp()
	}
}

struct UIImagePickerControllerRepresentable: UIViewControllerRepresentable {
	@Binding var image: UIImage?
	@Binding var showScreen: Bool
	
	func makeUIViewController(context: Context) -> UIImagePickerController {
		let vc = UIImagePickerController()
		vc.allowsEditing = false
		vc.delegate = context.coordinator
		return vc
	}
	
	// from SwiftUI to UIKit
	func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
		
	}
	
	// from UIKit to SwiftUI
	func makeCoordinator() -> Coordinator {
		return Coordinator(image: $image, showScreen: $showScreen)
	}
	
	class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
		@Binding var image: UIImage?
		@Binding var showScreen: Bool
		
		init(image: Binding<UIImage?>, showScreen: Binding<Bool>) {
			self._image = image
			self._showScreen = showScreen
		}
		func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
			guard let newImage = info[.originalImage] as? UIImage else { return }
			image = newImage
			showScreen = false
		}
	}
}

// MARK: -  UIViewControllerRepresentable
struct BasicUIViewControllerRepresentalbe: UIViewControllerRepresentable {
	
	let lableText: String
	
	func makeUIViewController(context: Context) -> some UIViewController {
		let vc = MyFirstViewController()
		vc.lableText = lableText
		return vc
	}
	
	func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
		
	}
}

class MyFirstViewController: UIViewController {
	
	var lableText: String = "Starting value"
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .blue
		
		let label = UILabel()
		label.text = lableText
		label.textColor = UIColor.white
		
		view.addSubview(label)
		label.frame = view.frame
	}
}


