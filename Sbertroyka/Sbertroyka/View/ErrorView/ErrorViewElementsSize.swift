//
//  ErrorViewElementsSize.swift
//  Sbertroyka
//
//  Created by Stepan Kirillov on 1/29/22.
//

import Foundation
import UIKit

let errorViewHeight = UIScreen.main.bounds.height * 0.4
let errorViewWidth = UIScreen.main.bounds.width < errorViewHeight ? UIScreen.main.bounds.width : errorViewHeight

let errorLabelHeight = errorViewHeight * 0.15
let errorDesctiptionLabelHeight = errorViewHeight * 0.15
let errorRetryButtonHeight = errorViewHeight * 0.15

let errorViewEmptyHeightSpace = errorViewHeight - errorLabelHeight - errorDesctiptionLabelHeight - errorRetryButtonHeight - errorImageViewHeight

let errorImageViewHeight = errorViewWidth * 0.30
let errorImageViewWidth = errorViewWidth * 0.30
//let activityIndicatorCenterOffset =  -0.1 * loadingViewHeight
