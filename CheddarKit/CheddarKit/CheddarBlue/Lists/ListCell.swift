//
//  ListCell.swift
//  CheddarKit
//
//  Created by Karl Weber on 1/2/18.
//  Copyright © 2018 Karl Weber. All rights reserved.
//

import UIKit

class ListCell: UICollectionViewCell {
    
    let titleLabel = UILabel()
    let activeTasksLabel = UILabel()
    let pillBackground = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.frame = frame
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupViews() {
        
        // title
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15.0).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15.0).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0.0).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0.0).isActive = true
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.text = "Whatever"
        
        pillBackground.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(pillBackground)
        pillBackground.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15.0).isActive = true
        pillBackground.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0.0).isActive = true
        pillBackground.heightAnchor.constraint(equalToConstant: 16.0).isActive = true
        pillBackground.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
        pillBackground.layer.cornerRadius = 8.0
        pillBackground.backgroundColor = .whiteSeven
        
        // Task Number
        activeTasksLabel.translatesAutoresizingMaskIntoConstraints = false
        activeTasksLabel.font = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        activeTasksLabel.textAlignment = .center
        activeTasksLabel.backgroundColor = .clear
        activeTasksLabel.layer.cornerRadius = 4.0
        activeTasksLabel.textColor = .blackFour
        contentView.addSubview(activeTasksLabel)
        activeTasksLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15.0).isActive = true
        activeTasksLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0.0).isActive = true
        activeTasksLabel.heightAnchor.constraint(equalToConstant: 16.0).isActive = true
        activeTasksLabel.widthAnchor.constraint(equalToConstant: 30.0).isActive = true

        activeTasksLabel.text = "0"
        
        self.contentView.backgroundColor = .whiteFive
    }
    
    func configure(indexPath: IndexPath, list: CDKList) {
        titleLabel.text = list.title
        activeTasksLabel.text = "\(list.active_uncompleted_tasks_count)"
    }
    
}
