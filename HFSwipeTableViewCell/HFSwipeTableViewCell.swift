//
//  HFSwipeTableViewCell.swift
//  HFSwipeTableViewCell
//
//  Created by HenryFan on 20/8/2016.
//  Copyright © 2016 HenryFanDi. All rights reserved.
//

import UIKit

class HFSwipeTableViewCell: UITableViewCell, UIScrollViewDelegate {
  
  private let cellScrollView = UIScrollView()
  private let cellContentView = UIView()
  
  private let tapGestureRecognizer = UITapGestureRecognizer()
  
  private let rightView = UIView()
  private var rightViewConstraint = NSLayoutConstraint()
  
  // MARK: Lifecycle
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupSwipeTableViewCell()
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
    
    setupSwipeView()
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
    insertSubview(cellScrollView, atIndex: 0)
    for (_, subView) in subviews.enumerate() {
      cellContentView.addSubview(subView)
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
  
  private func setupSwipeView() {
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
  
  // MARK: UITapGestureRecognizer
  
  func selectOnTap(tapGestureRecognizer: UITapGestureRecognizer) {
  }
  
}
