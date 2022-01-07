//
//  InputViewController.swift
//  Moneygement
//
//  Created by Rizky Mashudi on 06/01/22.
//

import UIKit

class InputViewController: UIViewController {
    
    
    let recordCategory = ["Income", "Expense"]
    let headerSectionTitle = ["Category", "Period", "Amount"]
    var selectedCategory: String?

    // MARK: - Variable view object
    
    let tableViewInput: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tablecell")
        tableView.allowsMultipleSelection = false

        return tableView
    }()
    
//    enum InputRow: Int, CaseIterable {
//        case category
//        case period
//        case amount
//
//        func displayText(for record: Record?) -> String? {
//            switch self {
//            case .category:
//                return record?.category
//            case .period:
//                return record?.period
//            case .amount:
//                return record?.amount
//            }
//        }
//    }
    
    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setConstraint()
        setNavigationBar()

        tableViewInput.delegate = self
        tableViewInput.dataSource = self
        
    }
    
    
    
    
    // MARK: - Setup view
    func addSubviews() {
        view.addSubview(tableViewInput)
    }

    func setConstraint() {
        NSLayoutConstraint.activate([

            tableViewInput.topAnchor.constraint(equalTo: view.topAnchor),
            tableViewInput.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableViewInput.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableViewInput.bottomAnchor.constraint(equalTo: view.bottomAnchor),

        ])
    }
    
    func setNavigationBar() {
        //Navigation Bar
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        
        // Customizing our navigation bar
        navigationController?.navigationBar.tintColor = .tintColor
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        let rightBarButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveDidTap))
        let leftBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissView))
        self.navigationItem.rightBarButtonItem = rightBarButton
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc func dismissView(){
        print("Cancel tapped")
        dismiss(animated: true)
    }
    
    @objc func saveDidTap(){
        print("save tapped")
    }


    
}


extension InputViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section < headerSectionTitle.count {
            return headerSectionTitle[section]
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return recordCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let categoryCell = tableView.dequeueReusableCell(withIdentifier: "tablecell") {
            categoryCell.textLabel?.text = recordCategory[indexPath.row]
            categoryCell.selectionStyle = .none
            
            if let selectedRows = tableView.indexPathsForSelectedRows, selectedRows.contains(indexPath) {
                categoryCell.accessoryType = .checkmark
            } else {
                categoryCell.accessoryType = .none
            }
            
            return categoryCell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        selectedCategory = recordCategory[indexPath.row]
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
        selectedCategory = nil
    }
    
    
}
