//
//  Router.swift
//  Fishy
//
//  Created by Chau Vo on 5/11/16.
//  Copyright © 2016 Chau Vo. All rights reserved.
//

import Alamofire

public enum Router: URLRequestConvertible {
  case ConnectServer
  case Fan
  case Light
  case Food
  
  public var URLRequest: NSMutableURLRequest {
    let result: (method: String, path: String, params: [String: AnyObject]?) = {
      switch self {
      case .ConnectServer: return ("GET", "/7", nil)
      case .Fan: return ("GET", "/fan", nil)
      case .Light: return ("GET", "/light", nil)
      case .Food: return ("GET", "/food", nil)
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
