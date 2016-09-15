//
//  MainViewController.swift
//  HFSwipeTableViewCell
//
//  Created by HenryFan on 19/8/2016.
//  Copyright © 2016 HenryFanDi. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  private let MainCellReuseIdentifier = "MainCellReuseIdentifier"
  private var avatars = [Dictionary <String, AnyObject>]()
  
  // MARK: Lifecycle
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainViewController()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: Private
  
  private func setupMainViewController() {
    setupAvatars()
    setupTableView()
  }
  
  private func setupAvatars() {
    let amy = ["image": UIImage.init(named: "Amy")!, "title": "Amy", "subTitle": "Hello, I'm Amy"]
    let eric = ["image": UIImage.init(named: "Eric")!, "title": "Eric", "subTitle": "Hello, I'm Eric"]
    let jason = ["image": UIImage.init(named: "Jason")!, "title": "Jason", "subTitle": "Hello, I'm Jason"]
    avatars = [amy, eric, jason]
  }
  
  private func setupTableView() {
    tableView.registerNib(MainTableViewCell.nib(), forCellReuseIdentifier: MainCellReuseIdentifier)
    tableView.estimatedRowHeight = 70.0
    tableView.rowHeight = UITableViewAutomaticDimension
  }
  
  // MARK: UITableViewDataSource
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return avatars.count
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let mainTableViewCell = tableView.dequeueReusableCellWithIdentifier(MainCellReuseIdentifier) as? MainTableViewCell
    mainTableViewCell?.setRightSwipeButtonsWithSingleWidth([
      HFSwipeButton.init(swipeButtonType: .HFSwipeButtonDial)
      ], btnWidth: 50.0)
    mainTableViewCell?.configurationWithAvatar(avatars[indexPath.row])
    return mainTableViewCell!
  }
  
  // MARK: UITableViewDelegate
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
  }
  
}
