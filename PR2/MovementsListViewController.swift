//
//  MovementsListViewController.swift
//  PR2
//
//  Copyright © 2018 UOC. All rights reserved.
//

import UIKit

class MovementsListViewController: UITableViewController {
    // BEGIN-UOC-3
    var movements: [Movement] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movements = Services.getMovements()
    
        tableView.rowHeight = 75
    }
    // END-UOC-3
    

    
    
    // BEGIN-UOC-5
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movements.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == (movements.count)) {
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "LastMovementCell", for: indexPath)
            return cell
        } else {
            let cell: MovementCell = tableView.dequeueReusableCell(withIdentifier: "MovementCell", for: indexPath) as! MovementCell
            
            let description: String = movements[indexPath.row].movementDescription
            let date: Date = movements[indexPath.row].date
            let amount: Decimal = movements[indexPath.row].amount

            cell.descriptionCell.text = description
            cell.dateCell.text = getFormattedDate(dateToFormat: date)
            cell.amountCell.text = getFormattedAmount(amountToFormat: amount)
            
            changeAmountLabelColorIfNeeded(amount, cell)
            return cell
        }
    }
    
    func changeAmountLabelColorIfNeeded(_ amount: Decimal, _ cell: MovementCell) {
        if (amount < 0) {
            cell.amountCell.textColor = UIColor.red
        } else {
            cell.amountCell.textColor = UIColor.black
        }
    }
    
    func getFormattedDate(dateToFormat date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter.string(from: date)
    }
    
    func getFormattedAmount(amountToFormat amount: Decimal) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        if let stringAmount = formatter.string(from: amount as NSDecimalNumber) {
            return stringAmount + " €"
        }
        
        return ""
    }
    // END-UOC-5
    
    // BEGIN-UOC-7
    @IBOutlet var table: UITableView!
    
    @IBAction func filterMovementsList(_ sender: UISegmentedControl) {
        movements = Services.getMovements()
        switch sender.selectedSegmentIndex {
            case 0:
                table.reloadData()
            case 1:
                movements = applyFilter(category: "Transfers")
                self.table.reloadData()
            case 2:
                movements = applyFilter(category: "Credit cards")
                self.table.reloadData()
            case 3:
                movements = applyFilter(category: "Direct debits")
                self.table.reloadData()
            default:
                table.reloadData()
        }
    }
    
    func applyFilter(category: String) -> [Movement]{
        var filteredList: [Movement] = []
        for item in movements {
            if item.category.elementsEqual(category) {
                filteredList.append(item)
            }
        }
        
        return filteredList
    }
    
    // END-UOC-7
    
    // BEGIN-UOC-8.1
    // END-UOC-8.1
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
}
