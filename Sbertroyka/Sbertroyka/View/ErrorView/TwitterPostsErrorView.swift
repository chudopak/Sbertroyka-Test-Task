//
//  TwitterPostsErrorView.swift
//  Sbertroyka
//
//  Created by Stepan Kirillov on 1/29/22.
//

import UIKit

class TwitterPostsErrorView: UIView {

	var errorCase: ViewData.FailCode = .httpResponse {
		didSet {
			setErrorDescription()
			setNeedsLayout()
		}
	}
	
	private var viewModel: TwitterPostsViewModelProtocol!

	lazy var errorImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(systemName: "xmark.circle")
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.tintColor = errorViewTintColorRed
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
		label.numberOfLines = 0
		label.textColor = errorViewTintColorGray
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 16, weight: .light)
		label.adjustsFontSizeToFitWidth = true
		addSubview(label)
		return (label)
	}()
	
	lazy var retryButton: UIButton = {
		let button = UIButton()
		button.backgroundColor = errorButtonTintColorGray
		button.layer.cornerRadius = 7
		button.clipsToBounds = true
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(retryDataFetch), for: .touchUpInside)
		button.addSubview(retryButtonLabel)
		addSubview(button)
		return (button)
	}()
	
	lazy var retryButtonLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 1
		label.textColor = errorViewTintColorRed
		label.text = "Попробовать снова"
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 18)
		label.adjustsFontSizeToFitWidth = true
		addSubview(label)
		return (label)
	}()
	
	init(viewModel: TwitterPostsViewModelProtocol) {
		super.init(frame: CGRect.zero)
		self.viewModel = viewModel
		translatesAutoresizingMaskIntoConstraints = false
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		translatesAutoresizingMaskIntoConstraints = false
	}
	
	@objc private func retryDataFetch() {
		viewModel.fetchPostData()
	}
	
	func setErrorDescription() {
		switch errorCase {
		case .urlCreation:
			errorDescriptionLabel.text = "Не удалось получить данные :("
		case .httpResponse:
			errorDescriptionLabel.text = "Не удалось подключиться к серверу :("
		case .noData:
			errorDescriptionLabel.text = "Не удалось загрузить данные :("
		}
	}
	
	func setConstraints() {
		NSLayoutConstraint.activate([
			errorImageView.topAnchor.constraint(equalTo: topAnchor),
			errorImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
			errorImageView.heightAnchor.constraint(equalToConstant: errorImageViewHeight),
			errorImageView.widthAnchor.constraint(equalToConstant: errorImageViewWidth)
		])
		
		NSLayoutConstraint.activate([
			errorLabel.topAnchor.constraint(equalTo: errorImageView.bottomAnchor, constant: errorViewEmptyHeightSpace * 0.1),
			errorLabel.rightAnchor.constraint(equalTo: rightAnchor),
			errorLabel.leftAnchor.constraint(equalTo: leftAnchor),
			errorLabel.heightAnchor.constraint(equalToConstant: errorLabelHeight)
		])
		
		NSLayoutConstraint.activate([
			errorDescriptionLabel.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: errorViewEmptyHeightSpace * 0.1),
			errorDescriptionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
			errorDescriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
			errorDescriptionLabel.heightAnchor.constraint(equalToConstant: errorDesctiptionLabelHeight)
		])
		
		NSLayoutConstraint.activate([
			retryButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -errorViewEmptyHeightSpace * 0.5),
			retryButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
			retryButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
			retryButton.heightAnchor.constraint(equalToConstant: errorRetryButtonHeight)
		])
		
		NSLayoutConstraint.activate([
			retryButtonLabel.topAnchor.constraint(equalTo: retryButton.topAnchor),
			retryButtonLabel.bottomAnchor.constraint(equalTo: retryButton.bottomAnchor),
			retryButtonLabel.rightAnchor.constraint(equalTo: retryButton.rightAnchor),
			retryButtonLabel.leftAnchor.constraint(equalTo: retryButton.leftAnchor)
		])
	}
}
