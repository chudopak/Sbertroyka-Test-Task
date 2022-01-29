//
//  Date+Extension.swift
//  Sbertroyka
//
//  Created by Stepan Kirillov on 1/29/22.
//

import Foundation

extension Date {
	func timeAgoDisplay() -> String {
		let formatter = RelativeDateTimeFormatter()
		formatter.unitsStyle = .full
		return formatter.localizedString(for: self, relativeTo: Date())
	}
}
