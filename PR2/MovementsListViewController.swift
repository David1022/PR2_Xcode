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
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movements.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovementCell = tableView.dequeueReusableCell(withIdentifier: "MovementCell", for: indexPath) as! MovementCell
        let description: String = movements[indexPath.row].movementDescription
        let date: Date = movements[indexPath.row].date
        let amount: Decimal = movements[indexPath.row].amount

        
        cell.descriptionCell.text = description
        cell.dateCell.text = getFormattedDate(dateToFormat: date)
        cell.amountCell.text = getFormattedAmount(amountToFormat: amount)
        
        if (amount < 0) {
            cell.amountCell.textColor = UIColor.red
        } else {
            cell.amountCell.textColor = UIColor.black
        }
        
        return cell
    }
    
    func getFormattedDate(dateToFormat date: Date) -> String{
        // TODO Format date
        return "2018-12-01"
    }
    
    func getFormattedAmount(amountToFormat amount: Decimal) -> String {
        // TODO Format amount
        return "\(amount)"
    }
    // END-UOC-5
    
    // BEGIN-UOC-7
    // END-UOC-7
    
    // BEGIN-UOC-8.1
    // END-UOC-8.1
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
}
