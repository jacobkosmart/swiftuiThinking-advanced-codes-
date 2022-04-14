//
//  DependencyInjectionBootCamp.swift
//  SwiftThinkingAdvance
//
//  Created by Jacob Ko on 2022/04/14.
//

import SwiftUI
import Combine

// MARK: -  MODEL
struct PostModel: Identifiable, Codable {
	let userId: Int
	let id: Int
	let title: String
	let body: String
}

// MARK: -  PROTOCOL
// To use Protocol swap in and out whatever we want to use as the data service
// if we were testing or maybe just developing quickly we could then use our mock data service
protocol DataServiceProtocol {
	func getData() -> AnyPublisher<[PostModel], Error>
}

// MARK: -  DATA SERVICE
class ProductionDataService {
	let url: URL
	
	init(url: URL) {
		self.url = url
	}
	
	func getData() -> AnyPublisher<[PostModel], Error> {
		URLSession.shared.dataTaskPublisher(for: url)
			.map({ $0.data })
			.decode(type: [PostModel].self, decoder: JSONDecoder())
			.receive(on: DispatchQueue.main)
			.eraseToAnyPublisher()
	}
}

class MockDataService: DataServiceProtocol {
	
	let testData: [PostModel]
	
	init(data: [PostModel]?) {
		self.testData = data ?? [
			PostModel(userId: 1, id: 1, title: "One", body: "one one"),
		 PostModel(userId: 2, id: 2, title: "Two", body: "two two")
	 ]
	}
	
	func getData() -> AnyPublisher<[PostModel], Error> {
		Just(testData)
			.tryMap({ $0 })
			.eraseToAnyPublisher()
	}
}



// MARK: -  VIEWMODEL
class DependencyInjectionViewModel: ObservableObject {
	// MARK: -  PROPERTY
	@Published var dataArray: [PostModel] = []
	var cancellables = Set<AnyCancellable>()
	let dataService: DataServiceProtocol
	// MARK: -  INIT
	// Not Global access in ProductionDataService
	init(dataService: DataServiceProtocol) {
		self.dataService = dataService
		loadPosts()
	}
	// MARK: -  FUNCTION
	private func loadPosts() {
		dataService.getData()
			.sink { _ in
				
			} receiveValue: { [weak self] returnedPosts in
				self?.dataArray = returnedPosts
			}
			.store(in: &cancellables)

	}
}

// MARK: -  VIEW
struct DependencyInjectionBootCamp: View {
	// MARK: -  PROPERTY
	@StateObject private var vm: DependencyInjectionViewModel
	
	init(dataService: DataServiceProtocol) {
		_vm = StateObject(wrappedValue: DependencyInjectionViewModel(dataService: dataService))
	}
	// MARK: -  BODY
	var body: some View {
		ScrollView {
			VStack {
				ForEach(vm.dataArray) { post in
					Text(post.title)
				}
			} //: VSTACK
		} //: SCROLL
	}
}

// MARK: -  PREVIEW
struct DependencyInjectionBootCamp_Previews: PreviewProvider {
	
	// Can customize init
	// static let dataService = ProductionDataService(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
	static let dataService = MockDataService(data: nil)
	static var previews: some View {
		DependencyInjectionBootCamp(dataService: dataService)
	}
}
