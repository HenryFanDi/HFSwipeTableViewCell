//
//  HFSwipeTableViewCell.swift
//  HFSwipeTableViewCell
//
//  Created by HenryFan on 20/8/2016.
//  Copyright © 2016 HenryFanDi. All rights reserved.
//

import UIKit

class HFSwipeTableViewCell: UITableViewCell, UIScrollViewDelegate {
  
  enum HFSwipeStatusType {
    case HFSwipeStatusCenter
    case HFSwipeStatusLeft
    case HFSwipeStatusRight
  }
  
  private let cellScrollView = UIScrollView()
  private let cellContentView = UIView()
  
  private let tapGestureRecognizer = UITapGestureRecognizer()
  
  private let rightView = UIView()
  private var rightViewConstraint = NSLayoutConstraint()
  
  private let rightSwipeBtnView = UIView()
  
  // MARK: Lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupSwipeTableViewCell()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    cellContentView.frame = contentView.frame
    
    let rightSwipeBtnViewWidth: CGFloat = 50.0 //
    cellScrollView.contentSize = CGSizeMake(CGRectGetWidth(contentView.frame) + rightSwipeBtnViewWidth, CGRectGetHeight(contentView.frame))
    if !cellScrollView.tracking && !cellScrollView.decelerating {
      cellScrollView.contentOffset = CGPointMake(0.0, 0.0)
    }
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  // MARK: Private
  
  private func setupSwipeTableViewCell() {
    setupCellScrollView()
    setupCellContentView()
    
    setupTapGestureRecognizer()
    setupCellViewsConstraints()
    
    setupSwipeViews()
    setupSwipeBtnViews()
    
    setupSwipeViewsConstraints()
  }
  
  private func setupCellScrollView() {
    cellScrollView.backgroundColor = .clearColor()
    cellScrollView.translatesAutoresizingMaskIntoConstraints = false
    cellScrollView.delegate = self
  }
  
  private func setupCellContentView() {
    cellContentView.backgroundColor = .clearColor()
    cellScrollView.addSubview(cellContentView)
    
    // Add the cell scroll view to the cell
    let cellSubviews = subviews
    insertSubview(cellScrollView, atIndex: 0)
    for (_, cellSubview) in cellSubviews.enumerate() {
      cellContentView.addSubview(cellSubview)
    }
  }
  
  private func setupTapGestureRecognizer() {
    tapGestureRecognizer.addTarget(self, action: #selector(HFSwipeTableViewCell.selectOnTap(_:)))
    tapGestureRecognizer.delegate = self
    cellScrollView.addGestureRecognizer(tapGestureRecognizer)
  }
  
  private func setupCellViewsConstraints() {
    let metrics = ["padding" : 0]
    let views = ["cellScrollView" : cellScrollView]
    let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-padding-[cellScrollView]-padding-|", options: [.AlignAllBaseline], metrics: metrics, views: views)
    let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-padding-[cellScrollView]-padding-|", options: [.AlignAllBaseline], metrics: metrics, views: views)
    addConstraints(horizontalConstraints)
    addConstraints(verticalConstraints)
  }
  
  private func setupSwipeViews() {
    rightView.frame = self.bounds
    rightView.backgroundColor = .clearColor()
    
    rightViewConstraint = NSLayoutConstraint.init(item: rightView,
                                                  attribute: .Left,
                                                  relatedBy: .Equal,
                                                  toItem: self,
                                                  attribute: .Right,
                                                  multiplier: 1.0,
                                                  constant: 0.0)
  }
  
  private func setupSwipeBtnViews() {
  }
  
  private func setupSwipeViewsConstraints() {
    let swipeViews = [rightView]
    let swipeViewConstraints = [rightViewConstraint]
    let swipeBtnViews = [rightSwipeBtnView]
    let swipeAttributes = [NSLayoutAttribute.Right]
    
    let swipeCounts = 1
    for index in 0...swipeCounts - 1 {
      let swipeView = swipeViews[index]
      swipeView.translatesAutoresizingMaskIntoConstraints = false
      swipeView.clipsToBounds = true
      cellScrollView.addSubview(swipeView)
      
      let swipeViewConstraint = swipeViewConstraints[index]
      swipeViewConstraint.priority = UILayoutPriorityDefaultHigh
      
      let swipeBtnView = swipeBtnViews[index]
      let swipeAttribute = swipeAttributes[index]
      addConstraints([
        NSLayoutConstraint.init(item: swipeView,
          attribute: .Top,
          relatedBy: .Equal,
          toItem: self,
          attribute: .Top,
          multiplier: 1.0,
          constant: 0.0),
        NSLayoutConstraint.init(item: swipeView,
          attribute: .Bottom,
          relatedBy: .Equal,
          toItem: self,
          attribute: .Bottom,
          multiplier: 1.0,
          constant: 0.0),
        NSLayoutConstraint.init(item: swipeView,
          attribute: swipeAttribute,
          relatedBy: .Equal,
          toItem: self,
          attribute: swipeAttribute,
          multiplier: 1.0,
          constant: 0.0),
        swipeViewConstraint
        ])
      
      swipeView.addSubview(swipeBtnView)
      swipeView.addConstraints([
        NSLayoutConstraint.init(item: swipeBtnView,
          attribute: .Top,
          relatedBy: .Equal,
          toItem: swipeView,
          attribute: .Top,
          multiplier: 1.0,
          constant: 0.0),
        NSLayoutConstraint.init(item: swipeBtnView,
          attribute: .Bottom,
          relatedBy: .Equal,
          toItem: swipeView,
          attribute: .Bottom,
          multiplier: 1.0,
          constant: 0.0),
        NSLayoutConstraint.init(item: swipeBtnView,
          attribute: swipeAttribute,
          relatedBy: .Equal,
          toItem: swipeView,
          attribute: swipeAttribute,
          multiplier: 1.0,
          constant: 0.0)
        ])
      
      addConstraints([
        NSLayoutConstraint.init(item: swipeBtnView,
          attribute: .Width,
          relatedBy: .LessThanOrEqual,
          toItem: self,
          attribute: .Width,
          multiplier: 1.0,
          constant: 90.0)
        ])
    }
  }
  
  private func updateSwipeCell(swipeStatusType: HFSwipeStatusType, scrollView: UIScrollView) {
    if swipeStatusType == .HFSwipeStatusRight {
      if scrollView.contentOffset.x >= 0.0 {
        var frame = self.contentView.superview?.convertRect(self.contentView.frame, toView: self)
        frame?.size.width = CGRectGetWidth(self.frame)
        
        rightViewConstraint.constant = min(0, CGRectGetMaxX(frame!) - CGRectGetMaxX(self.frame))
      } else {
        scrollView.setContentOffset(CGPointZero, animated: false)
      }
    }
  }
  
  // MARK: UITapGestureRecognizer
  
  func selectOnTap(tapGestureRecognizer: UITapGestureRecognizer) {
  }
  
  // MARK: UIScrollViewDelegate
  
  func scrollViewDidScroll(scrollView: UIScrollView) {
    updateSwipeCell(.HFSwipeStatusRight, scrollView: scrollView)
  }
  
}
