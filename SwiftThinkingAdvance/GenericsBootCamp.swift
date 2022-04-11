//
//  GenericsBootCamp.swift
//  SwiftThinkingAdvance
//
//  Created by Jacob Ko on 2022/04/11.
//

import SwiftUI

// MARK: -  MODEL
struct StringModel {
	let info: String?
	
	func removeInfo() -> StringModel {
		StringModel(info: nil)
	}
}

// generic any type
struct GenericModel<T> {
	
	let info: T?
	func removeInfo() -> GenericModel {
		GenericModel(info: nil)
	}
}

// MARK: -  VIEWMODEL
class GenericsViewModel: ObservableObject {
	// MARK: -  PROPERTY
	@Published var stringModel = StringModel(info: "Hi World!")
	
	@Published var genericStringModel = GenericModel(info: "Hello, world")
	@Published var genericBoolModel = GenericModel(info: true)
	// MARK: -  INIT
	
	// MARK: -  FUNCTION
	func removeData() {
		stringModel = stringModel.removeInfo()
		genericStringModel = genericStringModel.removeInfo()
		genericBoolModel = genericBoolModel.removeInfo() 
	}
}

// MARK: -  VIEW
struct GenericsBootCamp: View {
	// MARK: -  PROPERTY
	@StateObject private var vm = GenericsViewModel()
	// MARK: -  BODY
	var body: some View {
		VStack {
			GenericView(content: Text("custom content"), title: "new View")
			
			Text(vm.stringModel.info ?? "No data")
			Text(vm.genericStringModel.info ?? "No data")
			Text(vm.genericBoolModel.info?.description ?? "No data")
				.onTapGesture {
					vm.removeData()
				}
		} //: VSTACK
	}
}

struct GenericView<T:View>: View {
	let content: T
	let title: String
	
	var body: some View {
		VStack {
			Text(title)
			content
		}
	}
}

// MARK: -  PREVIEW
struct GenericsBootCamp_Previews: PreviewProvider {
	static var previews: some View {
		GenericsBootCamp()
	}
}
