//
//  UIImageView+DownloadImageExtension.swift
//  Sbertroyka
//
//  Created by Stepan Kirillov on 1/29/22.
//

import UIKit

extension UIImageView {

	func download(from url: URL, contentMode mode: ContentMode = .scaleAspectFill) {
		contentMode = mode
		URLSession.shared.dataTask(with: url) { data, response, error in
			guard
				let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
				let data = data, error == nil,
				let image = UIImage(data: data)
			else {
				let image = UIImage(systemName: "questionmark.circle")
				DispatchQueue.main.async() { [weak self] in
					self?.image = image
				}
				print("Error - can't fetch profile image")
				return
			}
			DispatchQueue.main.async() { [weak self] in
				self?.image = image
			}
		}.resume()
	}

	func download(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
		guard let url = URL(string: link) else {
			print("Error - can't create URL for profile image")
			return
		}
		download(from: url, contentMode: mode)
	}
}
