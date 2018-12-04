//
//  MovementCellTableViewCell.swift
//  PR2
//
//  Copyright © 2018 UOC. All rights reserved.
//

import UIKit

class MovementCell: UITableViewCell {
// BEGIN-UOC-4
    @IBOutlet weak var descriptionCell: UILabel!
    
    @IBOutlet weak var dateCell: UILabel!
    
    @IBOutlet weak var amountCell: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
// END-UOC-4
}
