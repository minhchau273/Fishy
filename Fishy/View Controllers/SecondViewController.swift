//
//  SecondViewController.swift
//  Fishy
//
//  Created by Chau Vo on 5/13/16.
//  Copyright © 2016 Chau Vo. All rights reserved.
//

import UIKit
import SwiftString
import SwiftSpinner

class SecondViewController: UIViewController {
  
  @IBOutlet weak var temp1Label: UILabel!
  @IBOutlet weak var temp2Label: UILabel!
  
  @IBOutlet weak var foodButton: UIButton!
  @IBOutlet weak var fanButton: UIButton!
  @IBOutlet weak var lightButton: UIButton!
  
  var fanOn = false
  var lightOn = false
  
  let fanOnImage = UIImage(named: "FanOn")?.imageWithColor(FishyColor.onColor)
  let fanOffImage = UIImage(named: "FanOff")?.imageWithColor(FishyColor.offColor)
  
  let lightOnImage = UIImage(named: "LightOn")?.imageWithColor(FishyColor.onColor)
  let lightOffImage = UIImage(named: "LightOff")?.imageWithColor(FishyColor.offColor)
  
  var timer = NSTimer()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(SecondViewController.updateTemp), userInfo: nil, repeats: true)
    updateTemp()
    updateStatus()
  }
  
  func updateTemp() {
    FishyClient.getTemp { (message, error) in
      if let message = message {
        let temps = message.split("|")
        if temps.count == 2 {
          self.temp1Label.text = "\(temps[0]) ˚C"
          self.temp2Label.text = "\(temps[1]) ˚C"
        } else {
          SwiftSpinner.handleUserInfoError(error!)
          self.timer.invalidate()
        }
      }
    }
  }
  
  func updateStatus() {
    foodButton.setImage(UIImage(named: "Food")?.imageWithColor(FishyColor.onColor), forState: .Normal)
    foodButton.setImage(UIImage(named: "Food")?.imageWithColor(FishyColor.offColor), forState: .Highlighted)
    fanButton.setImage(fanOn ? fanOnImage : fanOffImage, forState: .Normal)
    lightButton.setImage(lightOn ? lightOnImage : lightOffImage, forState: .Normal)
  }
  
  @IBAction func onFoodTapped(sender: UIButton) {
    FishyClient.feed { (message, error) in
      if let error = error {
        SwiftSpinner.handleUserInfoError(error)
      }
    }
  }
  
  @IBAction func onFanTapped(sender: UIButton) {
    if fanOn {
      FishyClient.turnOffFan { (message, error) in
        if let error = error {
          SwiftSpinner.handleUserInfoError(error)
        } else {
          self.fanOn = false
          self.fanButton.setImage(self.fanOffImage, forState: .Normal)
        }
      }
    } else {
      FishyClient.turnOnFan { (message, error) in
        if let error = error {
          SwiftSpinner.handleUserInfoError(error)
        } else {
          self.fanOn = true
          self.fanButton.setImage(self.fanOnImage, forState: .Normal)
        }
      }
    }
  }
  
  @IBAction func onLightTapped(sender: UIButton) {
    if lightOn {
      FishyClient.turnOffLight { (message, error) in
        if let error = error {
          SwiftSpinner.handleUserInfoError(error)
        } else {
          self.lightOn = false
          self.lightButton.setImage(self.lightOffImage, forState: .Normal)
        }
      }
    } else {
      FishyClient.turnOnLight { (message, error) in
        if let error = error {
          SwiftSpinner.handleUserInfoError(error)
        } else {
          self.lightOn = true
          self.lightButton.setImage(self.lightOnImage, forState: .Normal)
        }
      }
    }
  }
  
  @IBAction func onDisconnectTapped(sender: UIButton) {
    timer.invalidate()
    FishyClient.disconnectServer { (status, error) in
      if let error = error {
        SwiftSpinner.handleUserInfoError(error)
      } else {
        self.dismissViewControllerAnimated(true, completion: nil)
      }
    }
  }
  
}
