//
//  MainTableViewCell.swift
//  HFSwipeTableViewCell
//
//  Created by HenryFan on 22/8/2016.
//  Copyright © 2016 HenryFanDi. All rights reserved.
//

import UIKit

class MainTableViewCell: HFSwipeTableViewCell {
  
  @IBOutlet weak var avatarView: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subTitleLabel: UILabel!
  
  // MARK: Lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupMainTableViewCell()
  }
  
  class func nib() -> UINib {
    return UINib(nibName: "MainTableViewCell", bundle: nil)
  }
  
  // MARK: Private
  
  private func setupMainTableViewCell() {
    setupAvatarView()
    setupTitleLabel()
    setupSubTitleLabel()
  }
  
  private func setupAvatarView() {
    avatarView.layer.cornerRadius = CGRectGetHeight(avatarView.frame) / 2.0
  }
  
  private func setupTitleLabel() {
  }
  
  private func setupSubTitleLabel() {
  }
  
}
