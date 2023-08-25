//
//  CustomTableViewCell.swift
//  week6
//
//  Created by 장혜성 on 2023/08/25.
//

import UIKit
import SnapKit

class CustomTableViewCell: UITableViewCell {
    
    let titleLabel = {
        let view = UILabel()
        return view
    }()
    
    let button = {
        let view = UIButton()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        setConstraints()  // addSubView 이후에 constraints 설정
    }
    
    // 스토리보드 안쓴다고 명시함 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        titleLabel.backgroundColor = .blue
        button.backgroundColor = .yellow
        contentView.addSubview(titleLabel)
        contentView.addSubview(button)
    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.leadingMargin.bottom.equalTo(contentView)
            make.trailing.equalTo(button.snp.leading).inset(8)
        }
        
        button.snp.makeConstraints { make in
            make.size.equalTo(30)
            make.centerY.trailingMargin.equalTo(contentView)
        }
    }
    
    // Interface Builder (XIB) 사용할 떄 동작
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
