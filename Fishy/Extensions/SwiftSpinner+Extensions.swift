//
//  SwiftSpinner+Extensions.swift
//  Fishy
//
//  Created by Chau Vo on 5/12/16.
//  Copyright © 2016 Chau Vo. All rights reserved.
//

import SwiftSpinner

extension SwiftSpinner {
  public class func handleUserInfoError(error: NSError) {
    show("\(error.localizedDescription)", animated: false).addTapHandler(
      { hide() }, subtitle: "Tap to try again"
    )
  }
}
