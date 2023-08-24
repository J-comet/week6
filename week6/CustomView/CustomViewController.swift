//
//  CustomViewController.swift
//  week6
//
//  Created by 장혜성 on 2023/08/24.
//

import UIKit
import SnapKit

class CustomViewController: UIViewController {

    let idTextField = {
        let view = BlackRadiusTextField()
        view.placeholder = "아이디를 입력해주세요"
        return view
    }()
    
    let pwTextField = {
        let view = BlackRadiusTextField()
        view.placeholder = "패스워드를 입력해주세요"
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(idTextField)
        idTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalTo(200)
        }
        
        view.addSubview(pwTextField)
        pwTextField.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalTo(200)
        }
    }

}
