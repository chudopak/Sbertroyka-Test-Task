//
//  TwitterPostsViewControllerData.swift
//  Sbertroyka
//
//  Created by Stepan Kirillov on 1/28/22.
//

import Foundation
import UIKit

enum ViewData {
	case initial
	case loading
	case success(PostsDataArray)
	case failure(FailCode)
	
	struct PostsDataArray {
		let posts: [PostData]
		
		init() {
			posts = [PostData]()
		}
		
		init(posts: [PostData]) {
			self.posts = posts
		}
	}
	
	struct PostData {
		var text: String = ""
		var media: String?
		var creationDate = Date()
		var id = ""
		var favoriteCount = ""
		var retweetCount = ""
	}
	
	enum FailCode {
		case urlCreation
		case httpResponse
		case noData
		
	}
}
