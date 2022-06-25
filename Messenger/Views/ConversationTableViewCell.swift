//
//  ConversationTableViewCell.swift
//  Messenger
//
//  Created by Kaori Persson on 2022-06-25.
//

import UIKit

class ConversationTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    public func configure(with mode: String) {
        
    }

}
