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
		return (posts.posts.count)
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		//indexPath.row % 4 == 0 is for test cause no post with media :)
		if (posts.posts[indexPath.row].media != nil && indexPath.row % 4 == 0) {
			if let cell = tableView.dequeueReusableCell(withIdentifier: "cellWithMedia", for: indexPath) as? PostWithMediaTableViewCell {
				cell.postLabel.text = posts.posts[indexPath.row].text
				cell.retweetsLabel.text = posts.posts[indexPath.row].retweetCount
				cell.favoritesLabel.text = posts.posts[indexPath.row].favoriteCount
				cell.dateLabel.text = posts.posts[indexPath.row].craetionDate.timeAgoDisplay()
				cell.media.download(from: posts.posts[indexPath.row].media!)
				cell.media.contentMode = .scaleAspectFill
				return (cell)
			}
		} else {
			if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PostTableViewCell {
				cell.postText.text = posts.posts[indexPath.row].text
				cell.retweetLabel.text = posts.posts[indexPath.row].retweetCount
				cell.favoriteLabel.text = posts.posts[indexPath.row].favoriteCount
				cell.date.text = posts.posts[indexPath.row].craetionDate.timeAgoDisplay()
				return (cell)
			}
		}
		return (UITableViewCell())
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		presentPostInSafari(for: indexPath.row)
	}
}

class TwitterPostsView: UIView, SFSafariViewControllerDelegate {
	
	private lazy var tableView = UITableView()
	
	private var viewModel: TwitterPostsViewModelProtocol!
	
	var posts = ViewData.PostsDataArray() {
		didSet {
			tableView.reloadData()
			if (refreshControl.isRefreshing) {
				refreshControl.endRefreshing()
			}
			setNeedsLayout()
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
		tableView.delegate = self
		tableView.dataSource = self
		tableView.frame = bounds
		tableView.refreshControl = refreshControl
		addSubview(tableView)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		updateView()
	}
	
	private func updateView() {
		
	}
	
	@objc private func refreshPosts(sender: UIRefreshControl) {
		viewModel.fetchPostData()
	}
	
	func presentPostInSafari(for index: Int) {
		guard let urlPost = URL(string: postPage + posts.posts[index].id) else {
			print("Ne fartanulo")
			return
		}
		let postViewController = SFSafariViewController(url: urlPost)
		postViewController.delegate = self
		delegate.presentPostViewController(for: postViewController, animated: true)
	}
}
