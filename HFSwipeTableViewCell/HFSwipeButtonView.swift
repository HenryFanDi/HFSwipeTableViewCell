//
//  HFSwipeButtonView.swift
//  HFSwipeTableViewCell
//
//  Created by HenryFan on 15/9/2016.
//  Copyright © 2016 HenryFanDi. All rights reserved.
//

import UIKit

class HFSwipeButtonView: UIView {
  
  fileprivate var widthConstraint: NSLayoutConstraint
  fileprivate var swipeBtns: [HFSwipeButton]
  
  // MARK: Lifecycle
  
  convenience required init?(coder aDecoder: NSCoder) {
    self.init(frame: CGRect.zero, swipeBtns: [])
  }
  
  init() {
    self.widthConstraint = NSLayoutConstraint()
    self.swipeBtns = []
    super.init(frame: CGRect.zero)
    setupButtonView()
  }
  
  init(frame: CGRect, swipeBtns: [HFSwipeButton]) {
    self.widthConstraint = NSLayoutConstraint()
    self.swipeBtns = swipeBtns
    super.init(frame: CGRect.zero)
    setupButtonView()
  }
  
  // MARK: Public
  
  func setSwipeButtons(_ swipeBtns: [HFSwipeButton], btnWidths: [CGFloat]) {
    setupSwipeButtons(swipeBtns)
    setupConstraints(btnWidths as AnyObject)
  }
  
  // MARK: Private
  
  fileprivate func setupButtonView() {
    translatesAutoresizingMaskIntoConstraints = false
    
    widthConstraint = NSLayoutConstraint.init(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 0.0)
    widthConstraint.priority = UILayoutPriorityDefaultHigh
    addConstraint(widthConstraint)
  }
  
  fileprivate func setupSwipeButtons(_ swipeBtns: [HFSwipeButton]) {
    for btn in swipeBtns {
      btn.removeFromSuperview()
    }
    self.swipeBtns = swipeBtns
  }
  
  fileprivate func setupConstraints(_ anyObject: AnyObject) {
    var widthConstant = 0.0 as CGFloat
    if swipeBtns.count > 0 {
      var index = 0
      var btnPrevious = HFSwipeButton.init(swipeButtonType: .hfSwipeButtonUnknown)
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
          addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-padding-[btn(btnWidth)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: ["btn": btn]))
        } else {
          addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[btnPrevious]-padding-[btn(btnWidth)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: ["btnPrevious": btnPrevious, "btn": btn]))
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-padding-[btn]-padding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: ["btn": btn]))
        
        widthConstant += btnWidth
        btnPrevious = btn
        index += 1
      }
      addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[btnPrevious]-padding-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: ["btnPrevious": btnPrevious]))
    }
    widthConstraint.constant = widthConstant
    setNeedsLayout()
  }
  
}
