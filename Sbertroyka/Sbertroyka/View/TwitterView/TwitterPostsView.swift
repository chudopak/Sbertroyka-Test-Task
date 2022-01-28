//
//  TwitterPostsView.swift
//  Sbertroyka
//
//  Created by Stepan Kirillov on 1/28/22.
//

import UIKit

extension TwitterPostsView : UITableViewDelegate, UITableViewDataSource {

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return (someInfo.count)
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TestXib {
			cell.title.text = someInfo[indexPath.row]
			return (cell)
		}
		return (UITableViewCell())
	}
}

class TwitterPostsView: UIView {
	
	private lazy var tableView = UITableView()
	
	var posts = ViewData.PostsDataArray()
	
	let someInfo = ["one", "two", "three", "sadfasdfasfa asd fasd fjasdkj haksdhjf jshadl flsakjhf "]
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		tableView.register(UINib(nibName: "TestXib", bundle: nil), forCellReuseIdentifier: "cell")
		tableView.delegate = self
		tableView.dataSource = self
		tableView.frame = bounds
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
	

}
