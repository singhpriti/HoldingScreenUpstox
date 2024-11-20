//
//  PortfolioTableViewCell.swift
//  HoldingsHub
//
//  Created by Preity Singh on 14/11/24.
//

import UIKit

class PortfolioTableViewCell: UITableViewCell {

    // MARK: - UI Components
    private let symbolLabel = UILabel()
    private let quantityLabel = UILabel()
    private let ltpLabel = UILabel()
    private let pnlLabel = UILabel()
    private let mainStackView = UIStackView()
    private let leftStackView = UIStackView()
    private let rightStackView = UIStackView()
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        mainStackView.axis = .horizontal
        mainStackView.spacing = 18
        mainStackView.alignment = .center
        contentView.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        leftStackView.axis = .vertical
        leftStackView.spacing = 18
        leftStackView.alignment = .leading
        
        rightStackView.axis = .vertical
        rightStackView.spacing = 18
        rightStackView.alignment = .trailing
        
        leftStackView.addArrangedSubview(symbolLabel)
        leftStackView.addArrangedSubview(quantityLabel)
        
        rightStackView.addArrangedSubview(ltpLabel)
        rightStackView.addArrangedSubview(pnlLabel)
        
        mainStackView.addArrangedSubview(leftStackView)
        mainStackView.addArrangedSubview(rightStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
   // MARK: - Configure Cell
   func configure(with holding: Holding) {
       symbolLabel.text = holding.symbol
       symbolLabel.font = UIFont.boldSystemFont(ofSize: 14)

       let quantityText = NSMutableAttributedString(string: "NET QTY: ", attributes: [
           .font: UIFont.systemFont(ofSize: 10),
           .foregroundColor: UIColor.gray
       ])
       quantityText.append(NSAttributedString(string: "\(holding.quantity)", attributes: [
           .font: UIFont.systemFont(ofSize: 13),
           .foregroundColor: UIColor.black
       ]))
       quantityLabel.attributedText = quantityText

       let ltpAttributedString = NSMutableAttributedString(string: "LTP: ", attributes: [
           .font: UIFont.systemFont(ofSize: 10),
           .foregroundColor: UIColor.gray
       ])
       let priceSymbol = "\u{20B9}"
       let ltpPriceAttributedString = NSAttributedString(string: "\(priceSymbol) \(holding.ltp)", attributes: [
           .font: UIFont.systemFont(ofSize: 13),
           .foregroundColor: UIColor.black
       ])
       ltpAttributedString.append(ltpPriceAttributedString)
       ltpLabel.attributedText = ltpAttributedString
       
       let pnlAttributedString = NSMutableAttributedString(string: "P&L: ", attributes: [
           .font: UIFont.systemFont(ofSize: 10),
           .foregroundColor: UIColor.gray
       ])
       let pnlColor = holding.pnl >= 0 ? UIColor.systemGreen : UIColor.systemRed
       let pnlValueAttributedString = NSAttributedString(string: "\(priceSymbol) \(String(format: "%.2f", holding.pnl))", attributes: [
           .font: UIFont.boldSystemFont(ofSize: 13),
           .foregroundColor: pnlColor
       ])
       pnlAttributedString.append(pnlValueAttributedString)
       pnlLabel.attributedText = pnlAttributedString
   }

}





