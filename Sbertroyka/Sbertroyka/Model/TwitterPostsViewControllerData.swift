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
	case success(PostData)
	case failure(String)
	
	struct PostData {
		var text: String = ""
		var media: Data?
		
		init(text: String, media: Data?) {
			self.text = text
			self.media = media
		}
	}
}
