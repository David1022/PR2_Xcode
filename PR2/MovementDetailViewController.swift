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
    var rejectButton: UIButton = UIButton()
    
    override func viewWillAppear(_ animated: Bool) {
        if movement.rejected {
            addRejectedText()
        } else {
            addButtonToReject()
        }
    }
    func addRejectedText() {
        let rejectedText = UILabel()
        
        rejectedText.text = "Rejected"
        rejectedText.textColor = UIColor.red
        rejectedText.font = UIFont.systemFont(ofSize: 17.0)
        
        view.addSubview(rejectedText)
        
        rejectedText.translatesAutoresizingMaskIntoConstraints = false
        rejectedText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        rejectedText.topAnchor.constraint(equalTo: accountBalance.bottomAnchor, constant: 20).isActive = true
    }
    
    func addButtonToReject() {
        rejectButton.setTitle("Reject", for: .normal)
        rejectButton.setTitleColor(.blue, for: .normal)
        rejectButton.setTitleColor(UIColor.blue.lighter(), for: .highlighted)
        rejectButton.addTarget(self, action: #selector (actionButton), for: .touchUpInside)
        
        view.addSubview(rejectButton)
        
        rejectButton.translatesAutoresizingMaskIntoConstraints = false
        rejectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        rejectButton.topAnchor.constraint(equalTo: accountBalance.bottomAnchor, constant: 20).isActive = true
    }

    @objc func actionButton() {
        movement.rejected = true
        rejectAction(sender: rejectButton)
    }
    
    func rejectAction(sender: UIButton!) {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    // END-UOC-9
}
