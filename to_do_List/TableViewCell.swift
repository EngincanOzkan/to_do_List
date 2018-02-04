//
//  TableViewCell.swift
//  to_do_List
//
//  Created by Engincan Özkan on 24.11.2017.
//  Copyright © 2017 Engincan Özkan. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_todo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func commonInit(_ todo_title: String){
        lbl_todo.text = todo_title
    }
    
}
