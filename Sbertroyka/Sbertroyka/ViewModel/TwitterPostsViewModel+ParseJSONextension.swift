//
//  TwitterPostsViewModel+ParseJSONextension.swift
//  Sbertroyka
//
//  Created by Stepan Kirillov on 1/28/22.
//

import Foundation
import SwiftyJSON

extension TwitterPostsViewModel {
	
	func parseJSON(data: Data) -> [ViewData.PostData]? {

		guard let twittData = getDataJSON(data: data) else { return (nil) }
		let postsArray = parseJSONToPostsArray(json: twittData)
		return (postsArray)
	}
	
	private func getDataJSON(data: Data) -> JSON? {

		let json: JSON
		do {
			json = try JSON(data: data)
		} catch {
			return (nil)
		}
		guard json["success"].exists() && json["success"] == true && json["data"].exists() else {
			return (nil)
		}
		return (json["data"])
	}
	
	private func parseJSONToPostsArray(json: JSON) -> [ViewData.PostData] {

		var postsData = [ViewData.PostData]()
		postsData.reserveCapacity(json.arrayValue.count)
		
		for post in json.arrayValue {
			postsData.append(setPostProperties(post: post))
		}
		
		return (postsData)
	}
	
	private func setPostProperties(post: JSON) -> ViewData.PostData {

		var postData = ViewData.PostData()
		
		if (post["text"].exists() && post["text"].string != nil) {
			postData.text = post["text"].stringValue
			print(postData.text)
		}
		if (post["id"].exists()) {
			postData.id = post["id"].stringValue
			print(postData.id)
		}
		if (post["createdAt"].exists() && post["createdAt"].double != nil) {
			let seccondsFrom1970 = post["createdAt"].doubleValue * 0.001
			postData.craetionDate = Date(timeIntervalSince1970: seccondsFrom1970)
			print(postData.craetionDate)
		}
		if (post["retweetCount"].exists()) {
			postData.retweetCount = post["retweetCount"].stringValue
			print(postData.retweetCount)
		}
		if (post["favoriteCount"].exists()) {
			postData.favoriteCount = post["favoriteCount"].stringValue
			print(postData.favoriteCount)
		}
		if (post["mediaEntities"].exists() && post["mediaEntities"].array != nil) {
			let array = post["mediaEntities"].arrayValue
			if (!array.isEmpty) {
				postData.media = downloadPicture(from: array[0].stringValue)
			}
		}
		
		return (postData)
	}
	
	private func downloadPicture(from url: URL) -> UIImage? {
		var picture: UIImage?
		URLSession.shared.dataTask(with: url) { data, response, error in
			guard
				let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
				let data = data, error == nil,
				let image = UIImage(data: data)
			else {
				print("Error - can't fetch profile image")
				picture = nil
				return
			}
			picture = image
		}.resume()
		return (picture)
	}

	private func downloadPicture(from link: String) -> UIImage? {
		guard let url = URL(string: link) else {
			print("Error - can't create URL for profile image")
			return (nil)
		}
		let image = downloadPicture(from: url)
		return (image)
	}
}
