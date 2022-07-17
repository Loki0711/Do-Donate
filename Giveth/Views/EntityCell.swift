//
//  EntityCell.swift
//  Giveth
//
//  Created by David Niño on 15/06/22.
//

import UIKit

class EntityCell: UITableViewCell {
    
    
    @IBOutlet weak var imageEntity: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var isConnected: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
