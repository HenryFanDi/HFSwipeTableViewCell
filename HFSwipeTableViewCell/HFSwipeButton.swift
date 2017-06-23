//
//  HFSwipeButton.swift
//  HFSwipeTableViewCell
//
//  Created by HenryFan on 15/9/2016.
//  Copyright © 2016 HenryFanDi. All rights reserved.
//

import UIKit

enum HFSwipeButtonType {
  case hfSwipeButtonUnknown
  case hfSwipeButtonDial
}

protocol HFSwipeButtonDelegate {
  func dialBtnOnTap()
}

class HFSwipeButton: UIButton {
  
  var delegate: HFSwipeButtonDelegate?

  fileprivate var swipeButtonType: HFSwipeButtonType
  fileprivate let swipeImageView: UIImageView
  fileprivate var swipeImageSize: CGFloat
  
  // MARK: Lifecycle
  
  convenience required init?(coder aDecoder: NSCoder) {
    self.init(swipeButtonType: .hfSwipeButtonUnknown)
  }
  
  init(swipeButtonType: HFSwipeButtonType) {
    self.delegate = nil
    self.swipeButtonType = swipeButtonType
    self.swipeImageView = UIImageView()
    self.swipeImageSize = 0.0
    super.init(frame: CGRect.zero)
    setupButton()
  }
  
  // MARK: Private
  
  fileprivate func setupButton() {
    setupSwipeButton()
    setupSwipeImageView()
    setupSwipeButtonWithSwipeButtonType()
    setupSwipeButtonConstraints()
  }
  
  fileprivate func setupSwipeButton() {
    translatesAutoresizingMaskIntoConstraints = false
  }
  
  fileprivate func setupSwipeImageView() {
    swipeImageSize = 20.0
    swipeImageView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(swipeImageView)
  }
  
  fileprivate func setupSwipeButtonWithSwipeButtonType() {
    var btnBackgroundColor = .white as UIColor
    var imageNamed = ""
    switch swipeButtonType {
    case .hfSwipeButtonDial:
      btnBackgroundColor = .init(red: 255.0/255.0, green: 198.0/255.0, blue: 26.0/255.0, alpha: 1.0)
      imageNamed = "Dial"
      addTarget(self, action: #selector(HFSwipeButton.dialBtnOnTap), for: .touchUpInside)
      break
    default:
      break
    }
    backgroundColor = btnBackgroundColor
    swipeImageView.image = UIImage.init(named: imageNamed)
  }
  
  fileprivate func setupSwipeButtonConstraints() {
    swipeImageView.addConstraints([
      NSLayoutConstraint.init(item: swipeImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: swipeImageSize),
      NSLayoutConstraint.init(item: swipeImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: swipeImageSize)
      ])
    
    addConstraints([
      NSLayoutConstraint.init(item: swipeImageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0),
      NSLayoutConstraint.init(item: swipeImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0)
      ])
  }
  
  // MARK: Dial
  
  func dialBtnOnTap() {
    delegate?.dialBtnOnTap()
  }
  
}
