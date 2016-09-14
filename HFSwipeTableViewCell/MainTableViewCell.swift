//
//  MainTableViewCell.swift
//  HFSwipeTableViewCell
//
//  Created by HenryFan on 22/8/2016.
//  Copyright © 2016 HenryFanDi. All rights reserved.
//

import UIKit

class MainTableViewCell: HFSwipeTableViewCell {
  
  @IBOutlet weak var avatarImageView: UIImageView!
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
  
  // MARK: Public
  
  func configurationWithAvatar(avatar: Dictionary <String, AnyObject>) {
    avatarImageView.image = avatar["image"] as? UIImage
    titleLabel.text = avatar["title"] as? String
    subTitleLabel.text = avatar["subTitle"] as? String
  }
  
  // MARK: Private
  
  private func setupMainTableViewCell() {
    setupAvatarImageView()
    setupTitleLabel()
    setupSubTitleLabel()
  }
  
  private func setupAvatarImageView() {
    avatarImageView.contentMode = .ScaleAspectFill
    avatarImageView.clipsToBounds = true
    avatarImageView.layer.borderWidth = 0.5
    avatarImageView.layer.borderColor = UIColor.lightGrayColor().CGColor
    avatarImageView.layer.cornerRadius = CGRectGetHeight(avatarImageView.frame) / 2.0
  }
  
  private func setupTitleLabel() {
    titleLabel.textColor = .blackColor()
  }
  
  private func setupSubTitleLabel() {
    subTitleLabel.textColor = .lightGrayColor()
  }
  
}
