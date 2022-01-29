//
//  Colors.swift
//  Sbertroyka
//
//  Created by Stepan Kirillov on 1/29/22.
//

import Foundation
import UIKit

let errorViewTintColorRed = UIColor(red: 229 / 256, green: 56 / 256, blue: 59 / 256, alpha: 1)
let errorButtonTintColorGray = UIColor(red: 177 / 256, green: 167 / 256, blue: 166 / 256, alpha: 0.2)
let errorViewTintColorGray = UIColor(red: 177 / 256, green: 167 / 256, blue: 166 / 256, alpha: 1)

let viewBackgroundColorLight = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
let viewBackgroundColorBlack = UIColor(red: 0, green: 0, blue: 0.7, alpha: 0)

let adaptiveViewBackgroundColor = UIColor { tc in
	switch tc.userInterfaceStyle {
	case .dark:
		return (viewBackgroundColorBlack)
	default:
		return (viewBackgroundColorLight)
	}
}
