//
//  HFSwipeButtonView.swift
//  HFSwipeTableViewCell
//
//  Created by HenryFan on 15/9/2016.
//  Copyright © 2016 HenryFanDi. All rights reserved.
//

import UIKit

class HFSwipeButtonView: UIView {
  
  private var widthConstraint: NSLayoutConstraint
  private var swipeBtns: [HFSwipeButton]
  
  // MARK: Lifecycle
  
  convenience required init?(coder aDecoder: NSCoder) {
    self.init(frame: CGRectZero, swipeBtns: [])
  }
  
  init() {
    self.widthConstraint = NSLayoutConstraint()
    self.swipeBtns = []
    super.init(frame: CGRectZero)
    setupButtonView()
  }
  
  init(frame: CGRect, swipeBtns: [HFSwipeButton]) {
    self.widthConstraint = NSLayoutConstraint()
    self.swipeBtns = swipeBtns
    super.init(frame: CGRectZero)
    setupButtonView()
  }
  
  // MARK: Public
  
  func setSwipeButtons(swipeBtns: [HFSwipeButton], btnWidths: [CGFloat]) {
    setupSwipeButtons(swipeBtns)
    setupConstraints(btnWidths)
  }
  
  // MARK: Private
  
  private func setupButtonView() {
    translatesAutoresizingMaskIntoConstraints = false
    
    widthConstraint = NSLayoutConstraint.init(item: self, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: 0.0)
    widthConstraint.priority = UILayoutPriorityDefaultHigh
    addConstraint(widthConstraint)
  }
  
  private func setupSwipeButtons(swipeBtns: [HFSwipeButton]) {
    for btn in swipeBtns {
      btn.removeFromSuperview()
    }
    self.swipeBtns = swipeBtns
  }
  
  private func setupConstraints(anyObject: AnyObject) {
    var widthConstant = 0.0 as CGFloat
    if swipeBtns.count > 0 {
      var index = 0
      var btnPrevious = HFSwipeButton.init(swipeButtonType: .HFSwipeButtonUnknown)
      var metrics = [
        "padding": 0.0,
        "btnWidth": 0.0 as CGFloat
      ]
      
      for btn in swipeBtns {
        btn.translatesAutoresizingMaskIntoConstraints = false
        addSubview(btn)
        
        var btnWidth = 0.0 as CGFloat
        if anyObject is [CGFloat] {
          btnWidth = (anyObject as! [CGFloat])[index]
        } else {
          btnWidth = anyObject as! CGFloat
        }
        metrics["btnWidth"] = btnWidth
        
        if index == 0 {
          addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-padding-[btn(btnWidth)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: ["btn": btn]))
        } else {
          addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[btnPrevious]-padding-[btn(btnWidth)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: ["btnPrevious": btnPrevious, "btn": btn]))
        }
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-padding-[btn]-padding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: ["btn": btn]))
        
        widthConstant += btnWidth
        btnPrevious = btn
        index += 1
      }
      addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[btnPrevious]-padding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: ["btnPrevious": btnPrevious]))
    }
    widthConstraint.constant = widthConstant
    setNeedsLayout()
  }
  
}
