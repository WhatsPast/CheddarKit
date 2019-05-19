//
//  MemberCell.swift
//  CheddarKit
//
//  Created by Karl Weber on 5/17/19.
//  Copyright © 2019 Karl Weber. All rights reserved.
//


import UIKit

class MemberCell: UICollectionViewCell {
    
    let textLabel = UILabel()
    let border = UIView()
    
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
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textLabel)
        textLabel.leftAnchor.constraint(equalTo: contentView.rightAnchor, constant: 6.0).isActive = true
        textLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -6.0).isActive = true
        textLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0.0).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0.0).isActive = true
        textLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        textLabel.textColor = .black
        textLabel.textAlignment = .left
        textLabel.lineBreakMode = .byWordWrapping
        textLabel.numberOfLines = 0
        textLabel.text = "Whatever"
        
        // border
        border.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(border)
        border.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0.0).isActive = true
        border.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -0.0).isActive = true
        border.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0.0).isActive = true
        border.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        border.backgroundColor = .whiteFour
        
        self.contentView.backgroundColor = .white
    }
    
    func configure(indexPath: IndexPath, member: CDKUser) {
        border.backgroundColor = .whiteFour
        if indexPath.row == 0 {
            border.backgroundColor = .white
        }
        textLabel.text = "@\(member.username)"
    }
    
}

