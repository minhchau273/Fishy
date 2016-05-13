//
//  FirstViewController.swift
//  Fishy
//
//  Created by Chau Vo on 5/11/16.
//  Copyright © 2016 Chau Vo. All rights reserved.
//

import UIKit
import SwiftSpinner

class FirstViewController: UIViewController {
  
  @IBOutlet weak var ipTextField: UITextField!
  @IBOutlet weak var connectButtonBottomConstraint: NSLayoutConstraint!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    
    //    FishyClient.connectServer { (status, error) in
    //      print("asf")
    //    }
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    subscribe()
  }
  
  override func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(animated)
    unsubscribe()
  }
  
  func subscribe() {
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FirstViewController.keyboardWillShow(_:)), name:UIKeyboardWillShowNotification, object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FirstViewController.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: nil)
  }
  
  func unsubscribe() {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    view.endEditing(true)
  }
  
  func keyboardWillShow(notification: NSNotification) {
    if let info = notification.userInfo, duration = info[UIKeyboardAnimationDurationUserInfoKey] as? NSTimeInterval, value = info[UIKeyboardFrameEndUserInfoKey] as? NSValue {
      let keyboardFrame = value.CGRectValue()
      UIView.animateWithDuration(duration, animations: { () -> Void in
        self.connectButtonBottomConstraint.constant = keyboardFrame.size.height + 20
        self.view.layoutIfNeeded()
      })
    }
  }
  
  func keyboardWillHide(notification: NSNotification) {
    if let info = notification.userInfo, duration = info[UIKeyboardAnimationDurationUserInfoKey] as? NSTimeInterval {
      UIView.animateWithDuration(duration, animations: { () -> Void in
        self.connectButtonBottomConstraint.constant = 128
        self.view.layoutIfNeeded()
      })
    }
  }
  
  @IBAction func onConnectButtonTapped(sender: UIButton) {
    if let ipAddress = ipTextField.text where ipAddress.characters.count > 0 {
      FishyClient.baseUrl = "http://\(ipAddress)"
      view.endEditing(true)
      SwiftSpinner.show("Connecting...")
      FishyClient.connectServer({ (status, error) in
        if let error = error {
          SwiftSpinner.handleUserInfoError(error)
        } else {
          SwiftSpinner.hide()
          self.performSegueWithIdentifier("GoToSecondScreen", sender: self)
        }
      })
    }
  }
}
