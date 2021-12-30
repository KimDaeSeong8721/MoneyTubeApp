//
//  TableViewCell.swift
//  WebView_prac
//
//  Created by DaeSeong Kim on 2021/02/01.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var mainText: UILabel!
    @IBOutlet weak var subText: UILabel!
    @IBOutlet weak var view: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        view.backgroundColor = .clear
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
        // Configure the view for the selected state
    }
    
}
