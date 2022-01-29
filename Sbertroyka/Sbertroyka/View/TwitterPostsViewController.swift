//
//  ViewController.swift
//  Sbertroyka
//
//  Created by Stepan Kirillov on 1/25/22.
//

import UIKit
import SafariServices

protocol TwitterPostsViewControllerDelegate: AnyObject {
	func presentPostViewController(for vc: SFSafariViewController, animated: Bool)
}

class TwitterPostsViewController: UIViewController, TwitterPostsViewControllerDelegate {
	
	private var viewModel: TwitterPostsViewModelProtocol!
	
	private lazy var postsView = TwitterPostsView(viewModel: viewModel, frame: view.bounds)
	private lazy var loadingView = TwitterPostsLoadingView(frame: view.bounds)
	private lazy var errorView = TwitterPostsErrorView(viewModel: viewModel)
	
	private var postsData: ViewData = .initial {
		didSet {
			updateView()
		}
	}
	
	init(viewModel: TwitterPostsViewModelProtocol) {
		super.init(nibName: nil, bundle: nil)
		self.viewModel = viewModel
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		viewModel.updatePostsData = { [weak self] viewData in
			self?.postsData = viewData
		}
		viewModel.fetchPostData()
		configureView()
		updateView()
	}
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
	}
	
	private func updateView() {
		switch postsData {
		case .initial, .loading:
			postsView.isHidden = true
			loadingView.isHidden = false
			errorView.isHidden = true
			if (!loadingView.activityIndicator.isAnimating) {
				loadingView.activityIndicator.startAnimating()
			}
		case .success(let postsDataArray):
			postsView.isHidden = false
			loadingView.isHidden = true
			errorView.isHidden = true
			if (loadingView.activityIndicator.isAnimating) {
				loadingView.activityIndicator.stopAnimating()
			}
			postsView.posts = postsDataArray
		case .failure(let errorCase):
			postsView.isHidden = true
			loadingView.isHidden = true
			errorView.isHidden = false
			errorView.errorCase = errorCase
			if (loadingView.activityIndicator.isAnimating) {
				loadingView.activityIndicator.stopAnimating()
			}
		}
	}
	
	private func configureView() {
		view.backgroundColor = adaptiveViewBackgroundColor
		title = "Новости"
//		navigationController?.navigationBar.barTintColor = UIColor(named: "background")
//		navigationController?.view.backgroundColor = UIColor(named: "background")
		navigationController?.navigationBar.backgroundColor = UIColor(named: "background")
		view.backgroundColor = UIColor(named: "background")
		
		view.addSubview(postsView)
		view.addSubview(loadingView)
		view.addSubview(errorView)
		postsView.delegate = self
		postsView.isHidden = true
		errorView.isHidden = true
		setConstraints()
		loadingView.setConstraints()
		loadingView.activityIndicator.startAnimating()
		errorView.setConstraints()
	}
	
	func presentPostViewController(for vc: SFSafariViewController, animated: Bool) {
		present(vc, animated: animated, completion: nil)
	}
	
	
	private func setConstraints() {
		NSLayoutConstraint.activate([
			postsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			postsView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			postsView.widthAnchor.constraint(equalTo: view.widthAnchor),
			postsView.heightAnchor.constraint(equalTo: view.heightAnchor)
		])
		
		NSLayoutConstraint.activate([
			loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			loadingView.heightAnchor.constraint(equalToConstant: loadingViewHeight),
			loadingView.widthAnchor.constraint(equalToConstant: loadingViewWidth)
		])
		
		NSLayoutConstraint.activate([
			errorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			errorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			errorView.heightAnchor.constraint(equalToConstant: errorViewHeight),
			errorView.widthAnchor.constraint(equalToConstant: errorViewWidth)
		])
	}
}

