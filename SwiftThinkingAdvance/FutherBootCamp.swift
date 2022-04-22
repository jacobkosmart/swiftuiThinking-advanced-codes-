//
//  FutherBootCamp.swift
//  SwiftThinkingAdvance
//
//  Created by Jacob Ko on 2022/04/22.
//

import SwiftUI
import Combine


// MARK: -  VIEWMODEL
class FuturesBootCampViewModel: ObservableObject {
	// MARK: -  PROPERTY
	@Published var title: String = "Starting title"
	let url = URL(string: "https://www.google.com")!
	var cancellables = Set<AnyCancellable>()
	// MARK: -  INIT
	init() {
		download()
	}
	// MARK: -  FUNCTION
	func download() {
		// getCombinePublisher()
		// 	.sink { _ in
		//
		// 	} receiveValue: { [weak self] returnedValue in
		// 		self?.title = returnedValue
		// 	}
		// 	.store(in: &cancellables)
		
		// getEscapingClosure { [weak self] returnedValue , error in
		// 	self?.title = returnedValue
		// }
		
		getFuturePublisher()
			.sink { _ in
		
			} receiveValue: { [weak self] returnedValue in
				self?.title = returnedValue
			}
			.store(in: &cancellables)

	}
	
	func getCombinePublisher() -> AnyPublisher<String, URLError> {
		URLSession.shared.dataTaskPublisher(for: url)
			.timeout(1, scheduler: DispatchQueue.main)
			.map({ _ in
				return "New Value"
			})
			.eraseToAnyPublisher()
	}
	
	func getEscapingClosure(completionHandler: @escaping (_ value: String, _ error: Error?) -> Void) {
		URLSession.shared.dataTask(with: url) { data, response, error in
			completionHandler("New value 2", nil)
		}
		.resume()
	}
	
	// Future : It's prodicing a single value where our regular publishers can possibly keep publishing over their lifetime and be subscurbed to them forever
	// Promise: The function promising that it will return a value in the future
	func getFuturePublisher() -> Future<String, Error> {
		 Future { promise in
			self.getEscapingClosure { returnedValue, error in
				if let error = error {
					promise(.failure(error))
				} else {
					promise(.success(returnedValue))
				}
			}
		}
	}
	
	// asyncroous code with @escaping
	func doSomething(completionHandler: @escaping (_ value: String) -> ()) {
		DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
			completionHandler("NEW STRING")
		}
	}
	// @escaping logic convert to Combine by using Future
	func doSomethingInTheFuture() -> Future<String, Never> {
		Future { promise in
			self.doSomething { value in
				promise(.success(value))
			}
		}
	}
}

// MARK: -  VIEW
struct FutherBootCamp: View {
	// MARK: -  PROPERTY
	@StateObject private var vm = FuturesBootCampViewModel()
	
	// MARK: -  BODY
	var body: some View {
		Text(vm.title)
	}
}

// MARK: -  PREVIEW
struct FutherBootCamp_Previews: PreviewProvider {
	static var previews: some View {
		FutherBootCamp()
	}
}
