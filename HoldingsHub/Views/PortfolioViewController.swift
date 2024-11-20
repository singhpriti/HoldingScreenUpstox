//
//  PortfolioViewController.swift
//  HoldingsHub
//
//  Created by Preity Singh on 14/11/24.
//

import UIKit

class PortfolioViewController: UIViewController {
    
    private let tableView = UITableView()
    private let viewModel = PortfolioViewModel()
    private let customNavBar = CustomNavigationBarView()
    private let bottomSheet = PortfolioBottomSheetView()
    
    /// Bottom view
    private var bottomSheetHeightConstraint: NSLayoutConstraint!
    private let collapsedHeight: CGFloat = 60
    private var expandedHeight: CGFloat = 160
    private var isBottomSheetExpanded = false

    /// Segmented Control and Separator
    private let segmentedControl: UISegmentedControl = {
        let items = ["Positions", "Holdings"]
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 1
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        bottomSheet.viewModel = viewModel
        view.addSubview(customNavBar)
        view.addSubview(segmentedControl)
        view.addSubview(separatorView)
        view.addSubview(tableView)
        view.addSubview(bottomSheet)
        
        customNavBar.translatesAutoresizingMaskIntoConstraints = false
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        bottomSheet.translatesAutoresizingMaskIntoConstraints = false
       

        /// bottom sheet initial height
        bottomSheetHeightConstraint = bottomSheet.heightAnchor.constraint(equalToConstant: collapsedHeight)
        bottomSheetHeightConstraint.isActive = true

        NSLayoutConstraint.activate([
            /// Custom Navigation Bar
            customNavBar.topAnchor.constraint(equalTo: view.topAnchor),
            customNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customNavBar.heightAnchor.constraint(equalToConstant: UIDevice.current.hasTopNotch ? 110 : 90),
            
            /// Segmented Control
            segmentedControl.topAnchor.constraint(equalTo: customNavBar.bottomAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 1),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1),
            
            /// Separator View
            separatorView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 1),
            separatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 2),
            
            /// Table View
            tableView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomSheet.topAnchor),
            
            /// Bottom Sheet
            bottomSheet.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomSheet.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomSheet.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
   
        ])
        

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PortfolioTableViewCell.self, forCellReuseIdentifier: "PortfolioTableViewCell")
 
        

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleBottomSheet))
        bottomSheet.addGestureRecognizer(tapGesture)
    }

    @objc private func toggleBottomSheet() {
        isBottomSheetExpanded.toggle()
        
        ///  bottom sheet height and animate
        bottomSheetHeightConstraint.constant = isBottomSheetExpanded ? expandedHeight : collapsedHeight
        bottomSheet.expandableStack.isHidden = !isBottomSheetExpanded
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
   
   /// Fetch default "Holdings" data
    private func fetchData() {
        viewModel.fetchHoldings { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.bottomSheet.updateBottomSheetData()
            }
        }
    }
}

//MARK: - TableView DataSource & Delegate
extension PortfolioViewController: UITableViewDataSource, UITableViewDelegate {
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return viewModel.holdings.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "PortfolioTableViewCell", for: indexPath) as? PortfolioTableViewCell else {
         return UITableViewCell()
      }
      
      let holding = viewModel.holdings[indexPath.row]
      cell.configure(with: holding)
      
      return cell
   }
   
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 65
   }
}




