//
//  VideoViewCell.swift
//  WebView_prac
//
//  Created by DaeSeong Kim on 2021/02/01.
//

import UIKit

class VideoViewCell: UITableViewCell {

   
    @IBOutlet weak var thumbNail: UIImageView!
    
    @IBOutlet weak var enclosingView: UIView!
    @IBOutlet weak var videoTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        enclosingView.backgroundColor = .clear
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
