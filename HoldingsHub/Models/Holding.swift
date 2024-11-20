//
//  Holding.swift
//  HoldingsHub
//
//  Created by Preity Singh on 14/11/24.
//

import Foundation

struct Holding: Codable {
    let symbol: String
    let quantity: Int
    let ltp: Double
    let avgPrice: Double
    let close: Double
    
   /// Calculates the Profit & Loss (P&L) for this holding.
    var pnl: Double {
        return (ltp - avgPrice) * Double(quantity)
    }
   
   /// Calculates the current market value of the holding.
   var currentValue: Double {
       return ltp * Double(quantity)
   }
   
   /// Calculates the total investment value of the holding.
   var investmentValue: Double {
       return avgPrice * Double(quantity)
   }
   
   /// Calculates today's P&L based on the difference between the closing and latest prices.
   var todayPnl: Double {
       return (close - ltp) * Double(quantity)
   }
}

struct PortfolioData: Codable {
    let userHolding: [Holding]
}

struct APIResponse: Codable {
    let data: PortfolioData
}


