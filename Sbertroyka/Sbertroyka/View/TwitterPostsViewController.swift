//
//  ViewController.swift
//  Sbertroyka
//
//  Created by Stepan Kirillov on 1/25/22.
//

import UIKit

class TwitterPostsViewController: UIViewController {
	
	private var viewModel: TwitterPostsViewModelProtocol!
	
	private lazy var twitterPostsView = TwitterPostsView(frame: view.bounds)
	
	private var postsData: ViewData = .initial {
		didSet {
			print("popa")
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
		
		title = "Новости"
		
		viewModel.fetchPostData()
		viewModel.updatePostsData = { [weak self] viewData in
			self?.postsData = viewData
		}
		view.addSubview(twitterPostsView)
	}
}

