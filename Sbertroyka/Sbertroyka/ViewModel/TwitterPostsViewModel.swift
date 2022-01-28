//
//  TwitterPostsViewModel.swift
//  Sbertroyka
//
//  Created by Stepan Kirillov on 1/28/22.
//

import Foundation

protocol TwitterPostsViewModelProtocol {
	var updatePostsData: ((ViewData) -> ())? { get set }
	func fetchPostData()
}

final class TwitterPostsViewModel: TwitterPostsViewModelProtocol {

	var updatePostsData: ((ViewData) -> ())?
	
	lazy var sessionConfiguration = _setURLSessionConfiguration()
	lazy var session = URLSession(configuration: sessionConfiguration)
	
	public func fetchPostData() {
		guard let url = URL(string: api) else {
			updatePostsData?(.failure("Can't creaete URL"))
			return
		}
		updatePostsData?(.loading)
		let request  = session.dataTask(with: url) { [weak self] (data, response, error) in
			
			guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
				DispatchQueue.main.async { [weak self] in
					self?.updatePostsData?(.failure("Bad httpResponse"))
				}
				return
			}
			
			guard let data = data else {
				DispatchQueue.main.async { [weak self] in
					self?.updatePostsData?(.failure("Can't load data"))
				}
				return
			}
			
			print(data as? String ?? "")
			DispatchQueue.main.async { [weak self] in
				self?.updatePostsData?(.success(ViewData.PostData(text: "biba", media: nil)))
			}
		}
		request.resume()
	}
	
	private func _setURLSessionConfiguration() -> URLSessionConfiguration {
		let configuration = URLSessionConfiguration.default
		configuration.waitsForConnectivity = true
		configuration.timeoutIntervalForResource = 60
		return (configuration)
	}
}
