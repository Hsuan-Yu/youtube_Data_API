//
//  AthleanX_TableViewCell.swift
//  youtube_Data_API
//
//  Created by Calvin Lee on 2023/4/7.
//

import UIKit

class AthleanX_TableViewCell: UITableViewCell {
    
    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var videoTitle: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
