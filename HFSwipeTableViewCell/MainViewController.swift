//
//  MainViewController.swift
//  HFSwipeTableViewCell
//
//  Created by HenryFan on 19/8/2016.
//  Copyright © 2016 HenryFanDi. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HFSwipeButtonDelegate {
  
  fileprivate let MainCellReuseIdentifier = "MainCellReuseIdentifier"
  fileprivate var avatars = [Dictionary <String, AnyObject>]()
  
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
  
  fileprivate func setupMainViewController() {
    setupAvatars()
    setupTableView()
  }
  
  fileprivate func setupAvatars() {
    let amy = ["image": UIImage.init(named: "Amy")!, "title": "Amy", "subTitle": "Hello, I'm Amy"] as [String : Any]
    let eric = ["image": UIImage.init(named: "Eric")!, "title": "Eric", "subTitle": "Hello, I'm Eric"] as [String : Any]
    let jason = ["image": UIImage.init(named: "Jason")!, "title": "Jason", "subTitle": "Hello, I'm Jason"] as [String : Any]
    avatars = [amy as Dictionary<String, AnyObject>, eric as Dictionary<String, AnyObject>, jason as Dictionary<String, AnyObject>]
  }
  
  fileprivate func setupTableView() {
    tableView.register(MainTableViewCell.nib(), forCellReuseIdentifier: MainCellReuseIdentifier)
    tableView.estimatedRowHeight = 70.0
    tableView.rowHeight = UITableViewAutomaticDimension
  }
  
  // MARK: UITableViewDataSource
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return avatars.count
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let mainTableViewCell = tableView.dequeueReusableCell(withIdentifier: MainCellReuseIdentifier) as? MainTableViewCell
    mainTableViewCell?.setRightSwipeButtons([
      swipeButton(swipeButtonType: .hfSwipeButtonDial)
      ], btnWidths: [50.0])
    mainTableViewCell?.configurationWithAvatar(avatars[indexPath.row])
    return mainTableViewCell!
  }
  
  // MARK: UITableViewDelegate
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  }
  
  // MARK: HFSwipeButton
  
  fileprivate func swipeButton(swipeButtonType: HFSwipeButtonType) -> HFSwipeButton {
    let swipeButton = HFSwipeButton.init(swipeButtonType: swipeButtonType)
    swipeButton.delegate = self
    return swipeButton
  }
  
  // MARK: HFSwipeButtonDelegate
  
  func dialBtnOnTap() {
    let alertController = UIAlertController.init(title: "", message: "Swipe Button On Tap", preferredStyle: .alert)
    alertController.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (alertAction) in
    }))
    present(alertController, animated: true) {}
  }
  
}
