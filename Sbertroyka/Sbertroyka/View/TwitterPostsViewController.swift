//
//  ViewController.swift
//  Sbertroyka
//
//  Created by Stepan Kirillov on 1/25/22.
//

import UIKit

class TwitterPostsViewController: UIViewController {

	lazy var tableView = UITableView()
	
	let someInfo = ["one", "two", "three", "sadfasdfasfa asd fasd fjasdkj haksdhjf jshadl flsakjhf "]
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .green
		tableView.register(UINib(nibName: "TestXib", bundle: nil), forCellReuseIdentifier: "cell")
		tableView.delegate = self
		tableView.dataSource = self
		tableView.backgroundColor = .blue
		view.addSubview(tableView)
	}
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		tableView.frame = view.bounds
	}
}

extension TwitterPostsViewController : UITableViewDelegate, UITableViewDataSource {

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
