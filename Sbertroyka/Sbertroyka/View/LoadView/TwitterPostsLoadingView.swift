//
//  TwitterPostsLoadingView.swift
//  Sbertroyka
//
//  Created by Stepan Kirillov on 1/28/22.
//

import UIKit

class TwitterPostsLoadingView: UIView {

	lazy var activityIndicator: UIActivityIndicatorView = {
		let indicator = UIActivityIndicatorView(style: .large)
		indicator.color = .gray
		indicator.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
		indicator.hidesWhenStopped = true
		indicator.translatesAutoresizingMaskIntoConstraints = false
		addSubview(indicator)
		indicator.isHidden = false
		return (indicator)
	}()
	
	lazy var loadingLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
//		label.textColor = adaptiveTintColor
		label.numberOfLines = 1
		label.textAlignment = .center
		label.text = "Загрузка..."
		label.font = UIFont.boldSystemFont(ofSize: 22)
		label.adjustsFontSizeToFitWidth = true
		addSubview(label)
		return (label)
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = .red
		translatesAutoresizingMaskIntoConstraints = false
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	func setConstraints() {
		NSLayoutConstraint.activate([
			loadingLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
			loadingLabel.rightAnchor.constraint(equalTo: rightAnchor),
			loadingLabel.leftAnchor.constraint(equalTo: leftAnchor),
			loadingLabel.heightAnchor.constraint(equalToConstant: lodingLabelHeight)
		])
		
		NSLayoutConstraint.activate([
			activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
			activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor, constant: activityIndicatorCenterOffset),
			activityIndicator.heightAnchor.constraint(equalToConstant: activityIndicatorHeight),
			activityIndicator.widthAnchor.constraint(equalToConstant: activityIndicatorWidht)
		])
	}

}
