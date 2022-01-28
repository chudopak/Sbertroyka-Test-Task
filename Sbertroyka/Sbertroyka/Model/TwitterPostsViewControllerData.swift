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
	case failure(String)
	
	struct PostsDataArray {
		let posts: [PostData]?
		
		init() {
			posts = nil
		}
		
		init(posts: [PostData]) {
			self.posts = posts
		}
	}
	
	struct PostData {
		var text: String = ""
		var media: UIImage?
		var craetionDate = Date()
		var id = ""
		var favoriteCount = ""
		var retweetCount = ""
	}
}
