//
//  ScreenshotModule.swift
//  ScreenshotAssignment
//
//  Created by Dipti Dilip Ladage on 08/10/24.
//

import Foundation
import UIKit

@objc(ScreenshotModule)
class ScreenshotModule: NSObject {
  
  @objc
  func isScreenCaptured(_ resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
    DispatchQueue.main.async {
      let isCaptured = UIScreen.main.isCaptured
      resolve(isCaptured)
    }
  }

  @objc
  func toggleScreenshotPrevention(_ enabled: Bool, resolve: @escaping RCTPromiseResolveBlock, rejecter reject: @escaping RCTPromiseRejectBlock) {
    DispatchQueue.main.async {
      if let currentWindow = UIApplication.shared.windows.first {
        if enabled {
          currentWindow.layer.opacity = 0.0 // To "prevent" screenshot, make the window invisible
        } else {
          currentWindow.layer.opacity = 1.0 // Restore visibility
        }
        resolve(nil)
      } else {
        reject("error", "Could not find active window", nil)
      }
    }
  }
}
