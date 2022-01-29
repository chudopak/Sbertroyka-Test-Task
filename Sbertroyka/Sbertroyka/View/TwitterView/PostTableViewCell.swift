//
//  TestXib.swift
//  Sbertroyka
//
//  Created by Stepan Kirillov on 1/28/22.
//

import UIKit

class PostTableViewCell: UITableViewCell {
	
	@IBOutlet weak var postText: UILabel!
	@IBOutlet weak var date: UILabel!
	@IBOutlet weak var favoriteLabel: UILabel!
	@IBOutlet weak var retweetLabel: UILabel!
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
	}
		
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
		separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}
