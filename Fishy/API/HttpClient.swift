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

class HttpClient {
  static var baseUrl = ""
  
  static func requestAPI(urlRequest: URLRequestConvertible, completion : (json : JSON?, error : NSError?) -> Void) {
    Alamofire.request(urlRequest).responseJSON { response in
      if let error = response.result.error {
        completion(json: nil, error: error)
      } else {
        if let data = response.result.value {
          let json = JSON(data)
          if let errorCode = json["status_code"].int {
            completion(json: nil, error: NSError(domain: HttpClient.baseUrl, code: errorCode, userInfo: nil))
          } else {
            completion(json: json, error: nil)
          }
        }
      }
    }
  }
  
}
