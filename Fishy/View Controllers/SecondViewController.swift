//
//  SecondViewController.swift
//  Fishy
//
//  Created by Chau Vo on 5/13/16.
//  Copyright © 2016 Chau Vo. All rights reserved.
//

import UIKit

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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    updateStatus()
  }
  
  func updateStatus() {
    foodButton.setImage(UIImage(named: "Food")?.imageWithColor(FishyColor.onColor), forState: .Normal)
    foodButton.setImage(UIImage(named: "Food")?.imageWithColor(FishyColor.offColor), forState: .Highlighted)
    fanButton.setImage(fanOn ? fanOnImage : fanOffImage, forState: .Normal)
    lightButton.setImage(lightOn ? lightOnImage : lightOffImage, forState: .Normal)
  }
  
  @IBAction func onFoodTapped(sender: UIButton) {
  }
  
  @IBAction func onFanTapped(sender: UIButton) {
    fanOn = !fanOn
    let fanOnImage = UIImage(named: "FanOn")?.imageWithColor(FishyColor.onColor)
    let fanOffImage = UIImage(named: "FanOff")?.imageWithColor(FishyColor.offColor)
    fanButton.setImage(fanOn ? fanOnImage : fanOffImage, forState: .Normal)
  }
  
  @IBAction func onLightTapped(sender: UIButton) {
    lightOn = !lightOn
    
    lightButton.setImage(lightOn ? lightOnImage : lightOffImage, forState: .Normal)
  }
  
  @IBAction func onDisconnectTapped(sender: UIButton) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
}
