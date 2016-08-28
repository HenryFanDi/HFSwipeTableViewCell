//
//  MainTableViewCell.swift
//  HFSwipeTableViewCell
//
//  Created by HenryFan on 22/8/2016.
//  Copyright © 2016 HenryFanDi. All rights reserved.
//

import UIKit

class MainTableViewCell: HFSwipeTableViewCell {
  
  // MARK: Lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  class func nib() -> UINib {
    return UINib(nibName: "MainTableViewCell", bundle: nil)
  }
  
}
