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
    
  }
}
