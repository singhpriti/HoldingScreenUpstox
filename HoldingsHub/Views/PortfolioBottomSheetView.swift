//
//  PortfolioBottomSheetView.swift
//  HoldingsHub
//
//  Created by Preity Singh on 15/11/24.
//

import UIKit

class PortfolioBottomSheetView: UIView {
   
   var viewModel: PortfolioViewModel? {
       didSet {
           updateBottomSheetData()
       }
   }
    
    private let currentValueTitleLabel = UILabel()
    private let currentValueLabel = UILabel()
    private let totalInvestmentTitleLabel = UILabel()
    private let totalInvestmentLabel = UILabel()
    private let pnlTitleLabel = UILabel()
    private let pnlLabel = UILabel()
    
    private let todayPnlTitleLabel = UILabel()
    private let todayPnlLabel = UILabel()
    

    let expandableStack = UIStackView()
    private let fixedStack = UIStackView()
    private let mainStack = UIStackView()
    
    private let separatorView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func setupUI() {
        self.backgroundColor = UIColor(named: "bottomSheet_Color")
       
       /// corner radius
       self.layer.cornerRadius = 15
       self.layer.masksToBounds = true
       self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        configureLabel(currentValueTitleLabel, fontSize: 14, textColor: .gray, alignment: .left, text: "Current Value")
        configureLabel(totalInvestmentTitleLabel, fontSize: 14, textColor: .gray, alignment: .left, text: "Total Investment")
        configureLabel(pnlTitleLabel, fontSize: 14, textColor: .gray, alignment: .left, text: "Profit & Loss")
        configureLabel(todayPnlTitleLabel, fontSize: 14, textColor: .gray, alignment: .left, text: "Today's Profit & Loss")
        
        configureLabel(currentValueLabel, fontSize: 14, alignment: .right)
        configureLabel(totalInvestmentLabel, fontSize: 14, alignment: .right)
        configureLabel(pnlLabel, fontSize: 14, alignment: .right)
        configureLabel(todayPnlLabel, fontSize: 14, alignment: .right)
        
 
        separatorView.backgroundColor = .lightGray
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        

        let currentStack = createHorizontalStack(title: currentValueTitleLabel, value: currentValueLabel)
        let investmentStack = createHorizontalStack(title: totalInvestmentTitleLabel, value: totalInvestmentLabel)
        let pnlStack = createHorizontalStack(title: pnlTitleLabel, value: pnlLabel)
        let todayPnlStack = createHorizontalStack(title: todayPnlTitleLabel, value: todayPnlLabel)
        

        expandableStack.axis = .vertical
        expandableStack.alignment = .fill
        expandableStack.spacing = 10
       [currentStack, investmentStack, pnlStack, separatorView].forEach { expandableStack.addArrangedSubview($0) }
        expandableStack.isHidden = true
        

        fixedStack.axis = .vertical
        fixedStack.alignment = .fill
        fixedStack.spacing = 10
        fixedStack.addArrangedSubview(todayPnlStack)
        
        mainStack.axis = .vertical
        mainStack.alignment = .fill
        mainStack.spacing = 10
        mainStack.addArrangedSubview(expandableStack)
        mainStack.addArrangedSubview(separatorView)
        mainStack.addArrangedSubview(fixedStack)
        

        addSubview(mainStack)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            mainStack.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func configureLabel(_ label: UILabel, fontSize: CGFloat, textColor: UIColor = .black, alignment: NSTextAlignment, text: String? = nil) {
        label.font = UIFont.systemFont(ofSize: fontSize)
        label.textColor = textColor
        label.textAlignment = alignment
        if let text = text {
            label.text = text
        }
    }
    
    private func createHorizontalStack(title: UILabel, value: UILabel) -> UIStackView {
        let hStack = UIStackView(arrangedSubviews: [title, value])
        hStack.axis = .horizontal
       hStack.distribution = .fillEqually
        hStack.spacing = 8
        return hStack
    }
    
   func updateBottomSheetData() {
       guard let viewModel = viewModel else { return }
       
       let totalCurrentValue = viewModel.holdings.reduce(0.0) { $0 + $1.currentValue }
       let totalInvestmentValue = viewModel.holdings.reduce(0.0) { $0 + $1.investmentValue }
       let totalPnl = totalCurrentValue - totalInvestmentValue
       let totalTodayPnl = viewModel.holdings.reduce(0.0) { $0 + $1.todayPnl }
       
       let pnlPercentage = (totalInvestmentValue != 0) ? (totalPnl / totalInvestmentValue) * 100 : 0
       let todayPnlPercentage = (totalInvestmentValue != 0) ? (totalTodayPnl / totalInvestmentValue) * 100 : 0

       currentValueLabel.text = String(format: "₹%.2f", totalCurrentValue)
       totalInvestmentLabel.text = String(format: "₹%.2f", totalInvestmentValue)
       pnlLabel.text = String(format: "%.2f%%", pnlPercentage)
       todayPnlLabel.text = String(format: "₹%.2f (%.2f%%)", totalTodayPnl, todayPnlPercentage)
       
       pnlLabel.textColor = totalPnl >= 0 ? .green : .red
       todayPnlLabel.textColor = totalTodayPnl >= 0 ? .green : .red
   }
}









