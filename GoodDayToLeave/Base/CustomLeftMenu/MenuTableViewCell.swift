//
//  MenuTableViewCell.swift
//  GoodDayToLeave
//
//  Created by Tuan Nguyen on 2019/09/11.
//  Copyright © 2019 dattt. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindingWithModel(_ model: PBaseRowModel) {
        titleLabel?.text = model.title
        titleLabel.textColor = AppColor.textColor()
        thumbImageView?.image = UIImage(named: model.imageUrl)
    }
    
}
