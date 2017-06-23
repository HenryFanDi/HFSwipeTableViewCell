//
//  HFSwipeTableViewCell.swift
//  HFSwipeTableViewCell
//
//  Created by HenryFan on 20/8/2016.
//  Copyright © 2016 HenryFanDi. All rights reserved.
//

import UIKit

extension UIView {
  func parentViewOfType<T>(_ type: T.Type) -> T? {
    var currentView = self
    while currentView.superview != nil {
      if currentView is T {
        return currentView as? T
      }
      currentView = currentView.superview!
    }
    return nil
  }
}

class HFSwipeTableViewCell: UITableViewCell, UIScrollViewDelegate {
  
  enum HFSwipeStatusType {
    case hfSwipeStatusCenter
    case hfSwipeStatusLeft
    case hfSwipeStatusRight
  }
  
  fileprivate var isOpened = Bool()
  fileprivate var tableView: UITableView?
  
  fileprivate let cellScrollView = UIScrollView()
  fileprivate let cellContentView = UIView()
  
  fileprivate let tapGestureRecognizer = UITapGestureRecognizer()
  
  fileprivate let rightView = UIView()
  fileprivate var rightViewConstraint = NSLayoutConstraint()
  
  fileprivate let rightSwipeBtnView = HFSwipeButtonView()
  
  // MARK: Lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupSwipeTableViewCell()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    cellContentView.frame = contentView.frame
    
    let rightSwipeBtnViewWidth: CGFloat = rightSwipeBtnView.frame.width
    cellScrollView.contentSize = CGSize(width: contentView.frame.width + rightSwipeBtnViewWidth, height: contentView.frame.height)
    if !cellScrollView.isTracking && !cellScrollView.isDecelerating {
      cellScrollView.contentOffset = CGPoint(x: 0.0, y: 0.0)
    }
  }
  
  override func didMoveToSuperview() {
    tableView = parentViewOfType(UITableView.self)
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  // MARK: Public
  
  func setRightSwipeButtons(_ rightSwipeBtns: [HFSwipeButton], btnWidths: [CGFloat]) {
    rightSwipeBtnView.setSwipeButtons(rightSwipeBtns, btnWidths: btnWidths)
  }
  
  // MARK: Private
  
  fileprivate func setupSwipeTableViewCell() {
    setupCellScrollView()
    setupCellContentView()
    
    setupTapGestureRecognizer()
    setupCellViewsConstraints()
    
    setupSwipeViews()
    setupSwipeBtnViews()
    
    setupSwipeViewsConstraints()
  }
  
  fileprivate func setupCellScrollView() {
    cellScrollView.backgroundColor = .clear
    cellScrollView.translatesAutoresizingMaskIntoConstraints = false
    cellScrollView.delegate = self
    cellScrollView.showsHorizontalScrollIndicator = false
    cellScrollView.isScrollEnabled = true
  }
  
  fileprivate func setupCellContentView() {
    cellContentView.backgroundColor = .clear
    cellScrollView.addSubview(cellContentView)
    
    // Add the cell scroll view to the cell
    let cellSubviews = subviews
    insertSubview(cellScrollView, at: 0)
    for (_, cellSubview) in cellSubviews.enumerated() {
      cellContentView.addSubview(cellSubview)
    }
  }
  
  fileprivate func setupTapGestureRecognizer() {
    tapGestureRecognizer.addTarget(self, action: #selector(HFSwipeTableViewCell.selectOnTap(_:)))
    tapGestureRecognizer.delegate = self
    cellScrollView.addGestureRecognizer(tapGestureRecognizer)
  }
  
  fileprivate func setupCellViewsConstraints() {
    let metrics = ["padding": 0.0]
    let views = ["cellScrollView": cellScrollView]
    let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-padding-[cellScrollView]-padding-|", options: [.alignAllLastBaseline], metrics: metrics, views: views)
    let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-padding-[cellScrollView]-padding-|", options: [.alignAllLastBaseline], metrics: metrics, views: views)
    addConstraints(horizontalConstraints)
    addConstraints(verticalConstraints)
  }
  
  fileprivate func setupSwipeViews() {
    rightView.frame = self.bounds
    rightView.backgroundColor = .clear
    
    rightViewConstraint = NSLayoutConstraint.init(item: rightView,
                                                  attribute: .left,
                                                  relatedBy: .equal,
                                                  toItem: self,
                                                  attribute: .right,
                                                  multiplier: 1.0,
                                                  constant: 0.0)
  }
  
  fileprivate func setupSwipeBtnViews() {
  }
  
  fileprivate func setupSwipeViewsConstraints() {
    let swipeViews = [rightView]
    let swipeViewConstraints = [rightViewConstraint]
    let swipeBtnViews = [rightSwipeBtnView]
    let swipeAttributes = [NSLayoutAttribute.right]
    
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
        NSLayoutConstraint.init(item: swipeView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0),
        NSLayoutConstraint.init(item: swipeView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0),
        NSLayoutConstraint.init(item: swipeView, attribute: swipeAttribute, relatedBy: .equal, toItem: self, attribute: swipeAttribute, multiplier: 1.0, constant: 0.0),
        swipeViewConstraint
        ])
      
      swipeView.addSubview(swipeBtnView)
      swipeView.addConstraints([
        NSLayoutConstraint.init(item: swipeBtnView, attribute: .top, relatedBy: .equal, toItem: swipeView, attribute: .top, multiplier: 1.0, constant: 0.0),
        NSLayoutConstraint.init(item: swipeBtnView, attribute: .bottom, relatedBy: .equal, toItem: swipeView, attribute: .bottom, multiplier: 1.0, constant: 0.0),
        NSLayoutConstraint.init(item: swipeBtnView, attribute: swipeAttribute, relatedBy: .equal, toItem: swipeView, attribute: swipeAttribute, multiplier: 1.0, constant: 0.0)
        ])
      
      addConstraints([
        NSLayoutConstraint.init(item: swipeBtnView, attribute: .width, relatedBy: .lessThanOrEqual, toItem: self, attribute: .width, multiplier: 1.0, constant: 90.0)
        ])
    }
  }
  
  fileprivate func updateSwipeCell(_ swipeStatusType: HFSwipeStatusType, scrollView: UIScrollView) {
    if swipeStatusType == .hfSwipeStatusRight {
      if scrollView.contentOffset.x >= 0.0 {
        var frame = self.contentView.superview?.convert(self.contentView.frame, to: self)
        frame?.size.width = self.frame.width
        
        rightViewConstraint.constant = min(0, frame!.maxX - self.frame.maxX)
      } else {
        scrollView.setContentOffset(CGPoint.zero, animated: false)
      }
    }
  }
  
  // MARK: UITapGestureRecognizer
  
  func selectOnTap(_ tapGestureRecognizer: UITapGestureRecognizer) {
  }
  
  // MARK: UIScrollViewDelegate
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    updateSwipeCell(.hfSwipeStatusRight, scrollView: scrollView)
  }
  
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    hideVisibleCells()
  }
  
  func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    let rightThreshold: CGFloat = rightSwipeBtnView.frame.width / 2.0
    if targetContentOffset.pointee.x > rightThreshold {
      isOpened = true
      targetContentOffset.pointee = scrollViewContentOffsetWithSwipeStatusType(.hfSwipeStatusRight)
    } else {
      isOpened = false
      targetContentOffset.pointee = CGPoint.zero
    }
  }
  
  // MARK: HFSwipeStatusType
  
  fileprivate func scrollViewContentOffsetWithSwipeStatusType(_ swipeStatusType: HFSwipeStatusType) -> CGPoint {
    var scrollPoint = CGPoint.zero
    switch swipeStatusType {
    case .hfSwipeStatusCenter, .hfSwipeStatusLeft:
      break
    case .hfSwipeStatusRight:
      scrollPoint.x = rightSwipeBtnView.frame.width
      break
    }
    return scrollPoint
  }
  
  // MARK: Hide Visible
  
  fileprivate func hideVisibleCells() {
    if tableView != nil {
      for cell in tableView!.visibleCells {
        if cell.isKind(of: HFSwipeTableViewCell.self) {
          if (cell as! HFSwipeTableViewCell).isOpened && cell != self {
            hideCell((cell as! HFSwipeTableViewCell))
          }
        }
      }
    }
  }
  
  fileprivate func hideCell(_ cell: HFSwipeTableViewCell) {
    cell.isOpened = false
    cell.cellScrollView.setContentOffset(CGPoint.zero, animated: true)
  }
  
}
