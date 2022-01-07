//
//  ViewController.swift
//  Moneygement
//
//  Created by Rizky Mashudi on 04/01/22.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: -Variable
    let segmentItems = ["Incomes", "Expenses"]
    var dummyData = [String]()
    var dummyDataDesc = [String]()
    var dummyExpense = [String]()
    
    
    // MARK: -Variable Component
    lazy var yourBalanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.text = "Your balance"
        
        return label
    }()
    
    lazy var currentBalanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 33, weight: .semibold)
        label.text = "IDR 0"
        
        return label
    }()
    
    lazy var monthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 22, weight: .regular)
        label.text = "Month period"
        
        return label
    }()
    
    var incomeExpenseView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 14
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.backgroundColor = UIColor(named: "IncomeExpenseViewColor")
        
        return view
    }()
    
    var historyView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 14
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.backgroundColor = .white
        
        return view
    }()
    
    var incomeIcon: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "arrowtriangle.up.circle")
        image.tintColor = UIColor(named: "IncomeIconColor")
        
        return image
    }()
    
    var incomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.text = "Incomes"
        
        return label
    }()
    
    lazy var incomeNominal: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "IncomeIconColor")
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.text = "IDR 0"
        
        return label
    }()
    
    var expenseIcon: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "arrowtriangle.down.circle")
        image.tintColor = UIColor(named: "ExpenseIconColor")
        
        return image
    }()
    
    var expenseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.text = "Expenses"
        
        return label
    }()
    
    lazy var expenseNominal: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "ExpenseIconColor")
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.text = "IDR 0"
        
        return label
    }()
    
    var historyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "HistoryLabelColor")
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.text = "History"
        
        return label
    }()
    
    //Segmented Control
    lazy var segmentedControlHistory: UISegmentedControl = {
         
        let control = UISegmentedControl(items: segmentItems)
        control.translatesAutoresizingMaskIntoConstraints = false
        control.addTarget(self, action: #selector(segmentControl(_:)), for: .valueChanged)
        control.selectedSegmentIndex = 0
        
        return control
    }()
    
    //TableView
    lazy var listView: UITableView = {
        let listView = UITableView()
        listView.translatesAutoresizingMaskIntoConstraints = false
        listView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return listView
    }()
    

    // MARK: - Override func
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor(named: "MainBackground")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Navigation Bar
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
//        appearance.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 20.0), .foregroundColor: UIColor.black]

        // Customizing our navigation bar
        navigationController?.navigationBar.tintColor = .tintColor
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        navigationItem.title = "Moneygement"
        let rightBarButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(self.myRightSideBarButtonItemTapped(_:)))
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        for i in 0...40 {
            dummyData.append("Dummy income title \(i)")
            dummyExpense.append("Dummy expense title \(i)")
            dummyDataDesc.append("Dummy Desc \(i)")
        }
        
        listView.delegate = self
        listView.dataSource = self
        
        addSubviews()
        setConstraints()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
   
    
    // MARK: - Objc func
    @objc func segmentControl(_ segmentedControl: UISegmentedControl) {
        switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            // First segment tapped
            self.listView.reloadData()
            break
        case 1:
            // Second segment tapped
            print("expense tapped")
            self.listView.reloadData()
            break
        default:
            break
        }
    }
    
    @objc func myRightSideBarButtonItemTapped(_ sender:UIBarButtonItem!){
        print("myRightSideBarButtonItemTapped")
        let inputView = InputViewController()
        inputView.title = "New record"
        let navVc = UINavigationController(rootViewController: inputView)
        present(navVc, animated: true)
    }
    
    
    // MARK: - Func Subviews
    func addSubviews(){
        
        view.addSubview(yourBalanceLabel)
        view.addSubview(currentBalanceLabel)
        view.addSubview(monthLabel)
        view.addSubview(incomeExpenseView)
        
        incomeExpenseView.addSubview(historyView)
        incomeExpenseView.addSubview(incomeIcon)
        incomeExpenseView.addSubview(incomeLabel)
        incomeExpenseView.addSubview(incomeNominal)
        
        incomeExpenseView.addSubview(expenseIcon)
        incomeExpenseView.addSubview(expenseLabel)
        incomeExpenseView.addSubview(expenseNominal)
        
        historyView.addSubview(historyLabel)
        historyView.addSubview(segmentedControlHistory)
        
        historyView.addSubview(listView)
        
    }
    
    // MARK: - Func constraint configuration
    func setConstraints(){
        
        NSLayoutConstraint.activate([
            yourBalanceLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            yourBalanceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            currentBalanceLabel.topAnchor.constraint(equalTo: yourBalanceLabel.bottomAnchor, constant: 30),
            currentBalanceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            monthLabel.topAnchor.constraint(equalTo: currentBalanceLabel.bottomAnchor, constant: 30),
            monthLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            incomeExpenseView.topAnchor.constraint(equalTo: monthLabel.bottomAnchor, constant: 40),
            incomeExpenseView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            incomeExpenseView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            incomeExpenseView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            historyView.topAnchor.constraint(equalTo: monthLabel.bottomAnchor, constant: 115),
            historyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            historyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            historyView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            incomeIcon.topAnchor.constraint(equalTo: incomeExpenseView.topAnchor, constant: 15),
            incomeIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            incomeIcon.heightAnchor.constraint(equalToConstant: 45),
            incomeIcon.widthAnchor.constraint(equalToConstant: 45),
            
            incomeLabel.topAnchor.constraint(equalTo: incomeExpenseView.topAnchor, constant: 17),
            incomeLabel.leadingAnchor.constraint(equalTo: incomeIcon.trailingAnchor, constant: 5),
            
            incomeNominal.topAnchor.constraint(equalTo: incomeLabel.bottomAnchor, constant: 7),
            incomeNominal.leadingAnchor.constraint(equalTo: incomeIcon.trailingAnchor, constant: 5),
            
            expenseIcon.topAnchor.constraint(equalTo: incomeExpenseView.topAnchor, constant: 15),
            expenseIcon.trailingAnchor.constraint(equalTo: expenseLabel.leadingAnchor, constant: -5),
            expenseIcon.heightAnchor.constraint(equalToConstant: 45),
            expenseIcon.widthAnchor.constraint(equalToConstant: 45),
            
            expenseLabel.topAnchor.constraint(equalTo: incomeExpenseView.topAnchor, constant: 17),
            expenseLabel.trailingAnchor.constraint(equalTo: incomeExpenseView.trailingAnchor, constant: -80),
            
            expenseNominal.topAnchor.constraint(equalTo: expenseLabel.bottomAnchor, constant: 7),
            expenseNominal.leadingAnchor.constraint(equalTo: expenseIcon.trailingAnchor, constant: 5),
            
            historyLabel.topAnchor.constraint(equalTo: historyView.topAnchor, constant: 15),
            historyLabel.leadingAnchor.constraint(equalTo: historyView.leadingAnchor, constant: 17),
            historyLabel.trailingAnchor.constraint(equalTo: historyView.trailingAnchor, constant: -17),
            
            segmentedControlHistory.topAnchor.constraint(equalTo: historyLabel.bottomAnchor, constant: 20),
            segmentedControlHistory.leadingAnchor.constraint(equalTo: historyView.leadingAnchor, constant: 17),
            segmentedControlHistory.trailingAnchor.constraint(equalTo: historyView.trailingAnchor, constant: -17),
            segmentedControlHistory.heightAnchor.constraint(equalToConstant: 30),
            
            listView.topAnchor.constraint(equalTo: segmentedControlHistory.bottomAnchor, constant: 15),
            listView.leadingAnchor.constraint(equalTo: historyView.leadingAnchor, constant: 2),
            listView.trailingAnchor.constraint(equalTo: historyView.trailingAnchor, constant: -17),
            listView.bottomAnchor.constraint(equalTo: historyView.safeAreaLayoutGuide.bottomAnchor),
            
        ])
        

        
    }
    
   

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch segmentedControlHistory.selectedSegmentIndex {
        case 0 :
            return dummyData.count
        case 1 :
            return dummyExpense.count
        default:
            return 0
            break
        }
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        switch segmentedControlHistory.selectedSegmentIndex{
        case 0:
            cell.textLabel?.text = dummyData[indexPath.row]
            cell.detailTextLabel?.text = dummyDataDesc[indexPath.row]
            break
        case 1:
            cell.textLabel?.text = dummyExpense[indexPath.row]
            cell.detailTextLabel?.text = dummyDataDesc[indexPath.row]
            break
        default:
            break
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detail = DetailViewController()
//        let nav = UINavigationController(rootViewController: detail)
//        self.present(nav, animated: true)
        self.navigationController?.pushViewController(detail, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath.row)
    }
    
    
}

