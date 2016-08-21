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
    setupTableView()
  }
  
  private func setupTableView() {
    tableView.registerNib(MainTableViewCell.nib(), forCellReuseIdentifier: MainCellReuseIdentifier)
    tableView.rowHeight = UITableViewAutomaticDimension
  }
  
  // MARK: UITableViewDataSource
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 5
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let mainTableViewCell = tableView.dequeueReusableCellWithIdentifier(MainCellReuseIdentifier) as? MainTableViewCell
    return mainTableViewCell!
  }
  
  // MARK: UITableViewDelegate
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
  }
  
}
