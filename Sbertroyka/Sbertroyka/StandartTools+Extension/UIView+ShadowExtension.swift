//
//  UIView+ShadowExtension.swift
//  Sbertroyka
//
//  Created by Stepan Kirillov on 1/29/22.
//

import UIKit

extension UIView {

	func addShadow(scale: Bool = true) {
		layer.masksToBounds = false
		layer.shadowColor = UIColor.black.cgColor
		layer.shadowOpacity = 0.2
		layer.shadowOffset = CGSize(width: 1, height: 1)
		layer.shadowRadius = 10

		layer.shadowPath = UIBezierPath(rect: bounds).cgPath
		layer.shouldRasterize = true
		layer.rasterizationScale = scale ? UIScreen.main.scale : 1
	}
}
