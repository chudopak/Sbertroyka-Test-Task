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

		guard let tweetData = getDataJSON(data: data) else { return (nil) }
		let postsArray = parseJSONToPostsArray(json: tweetData)
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
		}
		if (post["id"].exists()) {
			postData.id = post["id"].stringValue
		}
		if (post["createdAt"].exists() && post["createdAt"].double != nil) {
			let seccondsFrom1970 = post["createdAt"].doubleValue * 0.001
			postData.creationDate = Date(timeIntervalSince1970: seccondsFrom1970)
		}
		if (post["retweetCount"].exists()) {
			postData.retweetCount = compressPostNumbers(numberStr: post["retweetCount"].stringValue)
		}
		if (post["favoriteCount"].exists()) {
			postData.favoriteCount = compressPostNumbers(numberStr: post["favoriteCount"].stringValue)
		}
		//this is for test cause no post with media :)
		postData.media = "https://i.ytimg.com/vi/Zr-qM5Vrd0g/maxresdefault.jpg"

		if (post["mediaEntities"].exists() && post["mediaEntities"].array != nil) {
			let array = post["mediaEntities"].arrayValue
			if (!array.isEmpty) {
				postData.media = array[0].stringValue
			}
		}
		return (postData)
	}
	
	private func compressPostNumbers(numberStr: String) -> String {
		guard let nb = Int(numberStr), nb >= 1000 else {
			return (numberStr)
		}
		if (1000 <= nb && nb <= 1_000_000) {
			return (String(nb / 1000) + "К")
		}
		return (String(nb / 1_000_000) + "M")
	}
}
