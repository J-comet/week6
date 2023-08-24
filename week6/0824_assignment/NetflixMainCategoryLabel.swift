//
//  NetflixMainCategory.swift
//  week6
//
//  Created by 장혜성 on 2023/08/24.
//

import UIKit


class NetflixMainCategoryLabel: UILabel {
    
    override init(frame: CGRect) {  // UIView 애 만들어져있는 메서드
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {  // NSCoding 에 만들어지는 메서드
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        textColor = .white
        font = .systemFont(ofSize: 15, weight: .medium)
        numberOfLines = 1
    }
}
