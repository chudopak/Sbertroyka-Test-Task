//
//  TwitterPostsView.swift
//  Sbertroyka
//
//  Created by Stepan Kirillov on 1/28/22.
//

import UIKit
import SafariServices

extension TwitterPostsView : UITableViewDelegate, UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (posts.posts.count + 1)
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		//indexPath.row % 4 == 0 is for test cause no post with media :)
		if (indexPath.row == 0) {
			if let cell = tableView.dequeueReusableCell(withIdentifier: "static", for: indexPath) as? StaticTableViewCell {
				return (cell)
			}
		} else if (posts.posts[indexPath.row - 1].media != nil && indexPath.row % 4 == 0) {
			if let cell = tableView.dequeueReusableCell(withIdentifier: "cellWithMedia", for: indexPath) as? PostWithMediaTableViewCell {
				cell.postLabel.text = posts.posts[indexPath.row - 1].text
				cell.retweetsLabel.text = posts.posts[indexPath.row - 1].retweetCount
				cell.favoritesLabel.text = posts.posts[indexPath.row - 1].favoriteCount
				cell.dateLabel.text = posts.posts[indexPath.row - 1].craetionDate.timeAgoDisplay()
				cell.media.download(from: posts.posts[indexPath.row - 1].media!)
				cell.media.contentMode = .scaleAspectFill
				return (cell)
			}
		} else {
			if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PostTableViewCell {
				cell.postText.text = posts.posts[indexPath.row - 1].text
				cell.retweetLabel.text = posts.posts[indexPath.row - 1].retweetCount
				cell.favoriteLabel.text = posts.posts[indexPath.row - 1].favoriteCount
				cell.date.text = posts.posts[indexPath.row - 1].craetionDate.timeAgoDisplay()
				return (cell)
			}
		}
		return (UITableViewCell())
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		if (indexPath.row == 0) {
			presentPostInSafari(isMainPage: true)
		} else {
			presentPostInSafari(for: indexPath.row - 1)
		}
	}
}

class TwitterPostsView: UIView, SFSafariViewControllerDelegate {
	
	private lazy var tableView = UITableView()
	
	private var viewModel: TwitterPostsViewModelProtocol!
	
	var posts = ViewData.PostsDataArray() {
		didSet {
			tableView.reloadData()
		}
	}
	
	weak var delegate: TwitterPostsViewControllerDelegate!
	
	lazy var refreshControl: UIRefreshControl = {
		let control = UIRefreshControl()
		control.addTarget(self, action: #selector(refreshPosts(sender:)), for: .valueChanged)
		return (control)
	}()
	
	init(viewModel: TwitterPostsViewModelProtocol, frame: CGRect) {
		super.init(frame: frame)
		self.viewModel = viewModel
		translatesAutoresizingMaskIntoConstraints = false
		tableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
		tableView.register(UINib(nibName: "PostWithMediaTableViewCell", bundle: nil), forCellReuseIdentifier: "cellWithMedia")
		tableView.register(UINib(nibName: "StaticTableViewCell", bundle: nil), forCellReuseIdentifier: "static")
		tableView.delegate = self
		tableView.dataSource = self
		tableView.frame = bounds
		tableView.refreshControl = refreshControl
		tableView.backgroundColor = UIColor(named: "background")
		addSubview(tableView)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	@objc private func refreshPosts(sender: UIRefreshControl) {
		viewModel.fetchPostData()
		if (refreshControl.isRefreshing) {
			refreshControl.endRefreshing()
		}
	}
	
	fileprivate func presentPostInSafari(for index: Int = 0, isMainPage: Bool = false) {
		guard let urlPost = getTwittURL(for: index, isMainPage: isMainPage) else {
			return
		}
		let postViewController = SFSafariViewController(url: urlPost)
		postViewController.delegate = self
		delegate.presentPostViewController(for: postViewController, animated: true)
	}
	
	fileprivate func getTwittURL(for index: Int, isMainPage: Bool) -> URL? {
		if (!isMainPage) {
			guard let urlPost = URL(string: postPage + posts.posts[index].id) else {
				return (nil)
			}
			return (urlPost)
		} else {
			guard let urlPost = URL(string: twitterPage) else {
				return (nil)
			}
			return (urlPost)
		}
	}
	
}
