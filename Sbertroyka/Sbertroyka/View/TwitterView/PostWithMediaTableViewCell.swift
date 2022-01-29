//
//  PostWithMediaTableViewCell.swift
//  Sbertroyka
//
//  Created by Stepan Kirillov on 1/29/22.
//

import UIKit

class PostWithMediaTableViewCell: UITableViewCell {

	@IBOutlet weak var postLabel: UILabel!
	@IBOutlet weak var retweetsLabel: UILabel!
	@IBOutlet weak var favoritesLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var media: UIImageView!
	override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
		separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}
