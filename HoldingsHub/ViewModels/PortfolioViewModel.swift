//
//  PortfolioViewModel.swift
//  HoldingsHub
//
//  Created by Preity Singh on 14/11/24.
//

import Foundation

class PortfolioViewModel {
    var holdings: [Holding] = []
    
   /// Fetches holdings data from the network and updates the `holdings` array.
    func fetchHoldings(completion: @escaping () -> Void) {
        NetworkManager.shared.fetchHoldings { [weak self] result in
            switch result {
            case .success(let holdings):
                self?.holdings = holdings
                completion()
            case .failure(let error):
                print("Failed to fetch holdings: \(error)")
                completion()
            }
        }
    }
    
   /// Calculates the profit or loss for a specific holding.
    func profitOrLoss(for holding: Holding) -> Double {
        return (holding.ltp - holding.avgPrice) * Double(holding.quantity)
    }
}

