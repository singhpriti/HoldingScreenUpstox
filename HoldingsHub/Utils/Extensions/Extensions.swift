//
//  Extensions.swift
//  HoldingsHub
//
//  Created by Preity Singh on 14/11/24.
//

import Foundation
import UIKit

extension UIDevice {
   /// Checks if the device has a top notch (i.e., devices with a safe area inset > 20).
   var hasTopNotch: Bool {
      return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
   }
}
