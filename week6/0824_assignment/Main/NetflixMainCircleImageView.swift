//
//  NetflixMainCircleImageView.swift
//  week6
//
//  Created by 장혜성 on 2023/08/24.
//

import UIKit


class NetflixMainCircleImageView: UIImageView {
    
    override init(image: UIImage?) {
        super.init(image: image)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpUI()
    }
    
    private func setUpUI() {
        layer.masksToBounds = true
        clipsToBounds = true
        layer.borderWidth = 3
        layer.borderColor = UIColor.brown.cgColor
        DispatchQueue.main.async {
            self.layer.cornerRadius = self.frame.size.width / 2
        }
        
    }
}
