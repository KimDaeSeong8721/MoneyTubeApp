//
//  ItemViewCell.swift
//  WebView_prac
//
//  Created by DaeSeong Kim on 2021/02/09.
//

import UIKit
import SwipeCellKit
class ItemViewCell: SwipeTableViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var itemThumbNail: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        view.backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
