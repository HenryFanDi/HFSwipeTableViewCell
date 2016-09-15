//
//  HFSwipeButton.swift
//  HFSwipeTableViewCell
//
//  Created by HenryFan on 15/9/2016.
//  Copyright © 2016 HenryFanDi. All rights reserved.
//

import UIKit

enum HFSwipeButtonType {
  case HFSwipeButtonUnknown
  case HFSwipeButtonDial
}

class HFSwipeButton: UIButton {
  
  private var swipeButtonType: HFSwipeButtonType
  private let swipeImageView: UIImageView
  private var swipeImageSize: CGFloat
  
  // MARK: Lifecycle
  
  convenience required init?(coder aDecoder: NSCoder) {
    self.init(swipeButtonType: .HFSwipeButtonUnknown)
  }
  
  init(swipeButtonType: HFSwipeButtonType) {
    self.swipeButtonType = swipeButtonType
    self.swipeImageView = UIImageView()
    self.swipeImageSize = 0.0
    super.init(frame: CGRectZero)
    setupButton()
  }
  
  // MARK: Private
  
  private func setupButton() {
    setupSwipeButton()
    setupSwipeImageView()
    setupSwipeButtonWithSwipeButtonType()
    setupSwipeButtonConstraints()
  }
  
  private func setupSwipeButton() {
    translatesAutoresizingMaskIntoConstraints = false
  }
  
  private func setupSwipeImageView() {
    swipeImageSize = 20.0
    swipeImageView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(swipeImageView)
  }
  
  private func setupSwipeButtonWithSwipeButtonType() {
    var btnBackgroundColor = .whiteColor() as UIColor
    var imageNamed = ""
    switch swipeButtonType {
    case .HFSwipeButtonDial:
      btnBackgroundColor = .lightGrayColor()
      imageNamed = "Dial"
      break
    default:
      break
    }
    backgroundColor = btnBackgroundColor
    swipeImageView.image = UIImage.init(named: imageNamed)
  }
  
  private func setupSwipeButtonConstraints() {
    swipeImageView.addConstraints([
      NSLayoutConstraint.init(item: swipeImageView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1.0, constant: swipeImageSize),
      NSLayoutConstraint.init(item: swipeImageView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1.0, constant: swipeImageSize)
      ])
    
    addConstraints([
      NSLayoutConstraint.init(item: swipeImageView, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1.0, constant: 0.0),
      NSLayoutConstraint.init(item: swipeImageView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1.0, constant: 0.0)
      ])
  }
  
}
