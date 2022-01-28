//
//  LoadingViewElementsSize.swift
//  Sbertroyka
//
//  Created by Stepan Kirillov on 1/28/22.
//

import Foundation
import UIKit

let loadingViewHeight = UIScreen.main.bounds.height * 0.35
let loadingViewWidth = UIScreen.main.bounds.width < loadingViewHeight ? UIScreen.main.bounds.width : loadingViewHeight

let lodingLabelHeight = loadingViewHeight * 0.2

let activityIndicatorHeight = loadingViewWidth * 0.40
let activityIndicatorWidht = loadingViewWidth * 0.40
let activityIndicatorCenterOffset =  -0.1 * loadingViewHeight
