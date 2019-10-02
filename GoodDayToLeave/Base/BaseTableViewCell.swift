//
//  BaseTableViewCell.swift
//  GoodDayToLeave
//
//  Created by Tuan Nguyen on 2019/09/11.
//  Copyright © 2019 dattt. All rights reserved.
//

import UIKit
import Kingfisher

protocol PBaseTableViewCell {
    func bindingWithModel(_ model: PBaseRowModel)
}

class BaseTableViewCell: UITableViewCell,PBaseTableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel?
    //@IBOutlet weak var descLabel: UILabel?
    @IBOutlet weak var thumbImageView: UIImageView?
    
    func bindingWithModel(_ model: PBaseRowModel) {
        titleLabel?.text = model.title
        //descLabel?.text = model.desc
        if let url = URL(string: model.imageUrl) {
            thumbImageView?.kf.setImage(with: url)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
