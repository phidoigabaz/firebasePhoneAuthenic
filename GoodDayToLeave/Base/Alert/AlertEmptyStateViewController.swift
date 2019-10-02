//
//  AlertEmptyStateViewController.swift
//  GoodDayToLeave
//
//  Created by Tuan Nguyen on 2019/09/20.
//  Copyright © 2019 dattt. All rights reserved.
//

import UIKit
import EmptyStateKit

class AlertEmptyStateViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var tryagainButton: UIButton!
    @IBOutlet weak var fadedView: UIView!
    
    var typeError: TableState?
    var desc: String = ""
    
    init(_ desc: String) {
        super.init(nibName: "AlertEmptyStateViewController", bundle: nil)
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .overCurrentContext
        self.desc = desc
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        if let type = typeError {
            thumbImageView.image = type.image
            titleLabel.text = type.title
            descLabel.text = desc
            tryagainButton.setTitle(type.titleButton, for: .normal)
        }
    }
    
    //MARK: METHODS
    func setupView() {
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        tryagainButton.layer.cornerRadius = 10
        tryagainButton.backgroundColor = "44CCD6".hexColor
    }
    
    //MARK: ACTION
    @IBAction func onBackAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
