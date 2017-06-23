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
  
  func configurationWithAvatar(_ avatar: Dictionary <String, AnyObject>) {
    avatarImageView.image = avatar["image"] as? UIImage
    titleLabel.text = avatar["title"] as? String
    subTitleLabel.text = avatar["subTitle"] as? String
  }
  
  // MARK: Private
  
  fileprivate func setupMainTableViewCell() {
    setupAvatarImageView()
    setupTitleLabel()
    setupSubTitleLabel()
  }
  
  fileprivate func setupAvatarImageView() {
    avatarImageView.contentMode = .scaleAspectFill
    avatarImageView.clipsToBounds = true
    avatarImageView.layer.borderWidth = 0.5
    avatarImageView.layer.borderColor = UIColor.lightGray.cgColor
    avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2.0
  }
  
  fileprivate func setupTitleLabel() {
    titleLabel.textColor = .black
  }
  
  fileprivate func setupSubTitleLabel() {
    subTitleLabel.textColor = .lightGray
  }
  
}
