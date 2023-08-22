//
//  Exam01ViewController.swift
//  week6
//
//  Created by 장혜성 on 2023/08/22.
//

import UIKit
import SnapKit

class Exam01ViewController: UIViewController {
    
    let grayView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    let titleLabel = {
        let view = UITextField()
        view.textAlignment = .center
        view.attributedPlaceholder = NSAttributedString(
            string: "제목을 입력해주세요",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        view.borderStyle = .none
        view.layer.borderColor = UIColor.brown.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    let dateLabel = {
        let view = UITextField()
        view.textAlignment = .center
        view.attributedPlaceholder = NSAttributedString(
            string: "날짜를 입력해주세요",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        view.borderStyle = .none
        view.layer.borderColor = UIColor.brown.cgColor
        view.layer.borderWidth = 2
        return view
    }()
    
    let bottomView = {
        let view = UIView()
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.brown.cgColor
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        /**
         leadingMargin, trailingMargin vs horizontalEdges 로 같은 값으로 했는데
         다르게 나타나는데 기본설정 어디서 할 수 있는지??
         */
        view.backgroundColor = .white
        
        view.addSubview(grayView)
        grayView.snp.makeConstraints { make in
            make.top.equalTo(view)
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(view).multipliedBy(0.3)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leadingMargin.equalTo(20)
            make.trailingMargin.equalTo(-20)
            make.top.equalTo(grayView.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
        
        view.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view).inset(20)
//            make.leadingMargin.trailingMargin.equalTo(view).inset(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
        
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view).inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

}
