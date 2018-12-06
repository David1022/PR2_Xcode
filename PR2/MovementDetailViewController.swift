//
//  MovementDetailViewController.swift
//  PR2
//
//  Copyright © 2018 UOC. All rights reserved.
//

import UIKit

class MovementDetailViewController: UIViewController {
    // BEGIN-UOC-8.2
    var movement: Movement!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var detailDescription: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var valueDate: UILabel!
    @IBOutlet weak var accountBalance: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        amount.text = getFormattedAmount(amountToFormat: movement.amount)
        detailDescription.text = movement.movementDescription
        date.text = getFormattedDate(dateToFormat: movement.date)
        valueDate.text = getFormattedDate(dateToFormat: movement.valueDate)
        accountBalance.text = getFormattedAmount(amountToFormat: movement.balance)
    
        if movement.amount < 0 {
            amount.textColor = UIColor.red
        }
        if movement.balance < 0 {
            accountBalance.textColor = UIColor.red
        }
    }
    
    func getFormattedDate(dateToFormat date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter.string(from: date)
    }
    
    func getFormattedAmount(amountToFormat amount: Decimal) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.decimalSeparator = ","
        formatter.groupingSeparator = "."
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        if let stringAmount = formatter.string(from: amount as NSDecimalNumber) {
            return stringAmount + " €"
        }
        
        return ""
    }

    // END-UOC-8.2
    
    // BEGIN-UOC-9
    func rejectAction(sender: UIButton!) {        
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    // END-UOC-9
}
