//
//  StaticTableViewCell.swift
//  Sbertroyka
//
//  Created by Stepan Kirillov on 1/29/22.
//

import UIKit

class StaticTableViewCell: UITableViewCell {

	@IBOutlet weak var cellView: UIView!

	override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
		cellView.addShadow()
		separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
    }
}
