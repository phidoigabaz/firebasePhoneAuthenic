//
//  MenuHeaderView.swift
//  GoodDayToLeave
//
//  Created by Tuan Nguyen on 2019/09/11.
//  Copyright © 2019 dattt. All rights reserved.
//

import UIKit

protocol MenuHeaderViewDelegate: NSObjectProtocol {
    func didSelectsignOut(_ view: UITableViewHeaderFooterView,_ sender: Any)
}
class MenuHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var signoutButton: UIButton!
    weak var delegate: MenuHeaderViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height/2
        signoutButton.layer.cornerRadius = signoutButton.frame.height/2
    }
    
    func bindingWith(_ viewModel: MenuViewModel) {
        
    }
    
    @IBAction func onActionSignOut(_ sender: Any) {
        delegate?.didSelectsignOut(self, sender)
    }
}
