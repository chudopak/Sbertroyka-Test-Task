//
//  TestXib.swift
//  Sbertroyka
//
//  Created by Stepan Kirillov on 1/28/22.
//

import UIKit

class TestXib: UITableViewCell {

	@IBOutlet weak var title: UILabel!

	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
