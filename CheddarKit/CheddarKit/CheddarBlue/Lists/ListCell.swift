//
//  ListCell.swift
//  CheddarKit
//
//  Created by Karl Weber on 1/2/18.
//  Copyright © 2018 Karl Weber. All rights reserved.
//

import UIKit

class ListCell: UICollectionViewCell {
    
    let titleLabel   = UILabel()
    let border  = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.frame = frame
        print("Frame width: \(frame.width)")
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
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
        titleLabel.text = "Whatever is happening I do not like. Why is it doing this? I do not understand."
        
        
        // border
        border.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(border)
        border.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15.0).isActive = true
        border.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15.0).isActive = true
        border.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0.0).isActive = true
        border.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        border.backgroundColor = .gray
        
        contentView.backgroundColor = .green
    }
    
    
//    contentView
    
    // this will accept a CDKList object to configure
    func configure() {
        
    }
    
    //
    
}
