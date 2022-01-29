//
//  TwitterPostsErrorView.swift
//  Sbertroyka
//
//  Created by Stepan Kirillov on 1/29/22.
//

import UIKit

class TwitterPostsErrorView: UIView {

	lazy var errorImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(systemName: "xmark.circle")
		imageView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(imageView)
		return (imageView)
	}()
	
	lazy var errorLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 1
		label.textAlignment = .center
		label.text = "Ошибка"
		label.font = UIFont.boldSystemFont(ofSize: 22)
		label.adjustsFontSizeToFitWidth = true
		addSubview(label)
		return (label)
	}()
	
	lazy var errorDescriptionLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 1
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 22, weight: .light)
		label.adjustsFontSizeToFitWidth = true
		addSubview(label)
		return (label)
	}()
	
	lazy var retryButton: UIButton = {
		let button = UIButton()
		
		return (button)
	}()

}
