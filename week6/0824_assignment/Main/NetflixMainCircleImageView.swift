//
//  NetflixMainCircleImageView.swift
//  week6
//
//  Created by 장혜성 on 2023/08/24.
//

import UIKit


class NetflixMainCircleImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.size.width / 2
    }
    
    private func setUpUI() {
//        layer.masksToBounds = true
        clipsToBounds = true
        layer.borderWidth = 1.5
        layer.borderColor = UIColor.brown.cgColor
    }
}
