//
//  Router.swift
//  Fishy
//
//  Created by Chau Vo on 5/11/16.
//  Copyright © 2016 Chau Vo. All rights reserved.
//

import Alamofire

public enum Router: URLRequestConvertible {
  case DisconnectServer
  case ConnectServer
  case TurnOnFan
  case TurnOffFan
  case Feed
  case TurnOnLight
  case TurnOffLight
  case GetTemp
  
  public var URLRequest: NSMutableURLRequest {
    let result: (method: String, path: String, params: [String: AnyObject]?) = {
      switch self {
      case .DisconnectServer: return ("GET", "/0", nil)
      case .ConnectServer: return ("GET", "/1", nil)
      case .TurnOnFan: return ("GET", "/2", nil)
      case .TurnOffFan: return ("GET", "/3", nil)
      case .Feed: return ("GET", "/4", nil)
      case .TurnOnLight: return ("GET", "/5", nil)
      case .TurnOffLight: return ("GET", "/6", nil)
      case .GetTemp: return ("GET", "/7", nil)
      }
    }()
    
    if let baseUrl = NSURL(string: FishyClient.baseUrl) {
      let baseUrlRequest = NSMutableURLRequest(URL: baseUrl.URLByAppendingPathComponent(result.path))
      baseUrlRequest.HTTPMethod = result.method
      
      var encoding = Alamofire.ParameterEncoding.JSON
      if result.method == "GET" {
        encoding = Alamofire.ParameterEncoding.URL
      }
      
      return encoding.encode(baseUrlRequest, parameters: result.params ?? [String: AnyObject]()).0
    }
    
    return NSMutableURLRequest()
  }
}
