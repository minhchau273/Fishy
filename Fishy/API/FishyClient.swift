//
//  HttpClient.swift
//  Fishy
//
//  Created by Chau Vo on 5/11/16.
//  Copyright © 2016 Chau Vo. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class FishyClient {
  static var baseUrl = ""
  
  static func requestAPI(urlRequest: URLRequestConvertible, completion : (json : JSON?, error : NSError?) -> Void) {
    Alamofire.request(urlRequest).responseJSON { response in
      if let error = response.result.error {
        completion(json: nil, error: error)
      } else {
        if let data = response.result.value {
          let json = JSON(data)
          if let errorCode = json["status_code"].int {
            completion(json: nil, error: NSError(domain: FishyClient.baseUrl, code: errorCode, userInfo: nil))
          } else {
            completion(json: json, error: nil)
          }
        }
      }
    }
  }
  
  static func connectServer(completion: (status: String?, error: NSError?) -> ()) {
    requestAPI(Router.ConnectServer) { (json, error) -> Void in
      if let json = json {
        completion(status: json["msg"].stringValue, error: nil)
      } else {
        completion(status: nil, error: error)
        print("Error when connecting")
      }
    }
  }
  
  static func disconnectServer(completion: (status: String?, error: NSError?) -> ()) {
    requestAPI(Router.DisconnectServer) { (json, error) -> Void in
      if let json = json {
        completion(status: json["msg"].stringValue, error: nil)
      } else {
        completion(status: nil, error: error)
        print("Error when disconnecting")
      }
    }
  }
  
  static func getTemp(completion: (message: String?, error: NSError?) -> ()) {
    requestAPI(Router.GetTemp) { (json, error) -> Void in
      if let json = json {
        completion(message: json["msg"].stringValue, error: nil)
      } else {
        completion(message: nil, error: error)
        print("Error when getting temp")
      }
    }
  }
  
  static func feed(completion: (message: String?, error: NSError?) -> ()) {
    requestAPI(Router.Feed) { (json, error) -> Void in
      if let json = json {
        completion(message: json["msg"].stringValue, error: nil)
      } else {
        completion(message: nil, error: error)
        print("Error when feeding")
      }
    }
  }
  
  static func turnOnFan(completion: (message: String?, error: NSError?) -> ()) {
    requestAPI(Router.TurnOnFan) { (json, error) -> Void in
      if let json = json {
        completion(message: json["msg"].stringValue, error: nil)
      } else {
        completion(message: nil, error: error)
        print("Error when turning fan on")
      }
    }
  }
  
  static func turnOffFan(completion: (message: String?, error: NSError?) -> ()) {
    requestAPI(Router.TurnOffFan) { (json, error) -> Void in
      if let json = json {
        completion(message: json["msg"].stringValue, error: nil)
      } else {
        completion(message: nil, error: error)
        print("Error when turning fan off")
      }
    }
  }
  
  static func turnOnLight(completion: (message: String?, error: NSError?) -> ()) {
    requestAPI(Router.TurnOnLight) { (json, error) -> Void in
      if let json = json {
        completion(message: json["msg"].stringValue, error: nil)
      } else {
        completion(message: nil, error: error)
        print("Error when turning light on")
      }
    }
  }
  
  static func turnOffLight(completion: (message: String?, error: NSError?) -> ()) {
    requestAPI(Router.TurnOffLight) { (json, error) -> Void in
      if let json = json {
        completion(message: json["msg"].stringValue, error: nil)
      } else {
        completion(message: nil, error: error)
        print("Error when turning light off")
      }
    }
  }
  
}
