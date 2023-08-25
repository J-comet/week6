//
//  BlackRadiusTextField.swift
//  week6
//
//  Created by 장혜성 on 2023/08/24.
//

import UIKit

class BlackRadiusTextField: UITextField {
    
    // Interface Builder 를 사용하지 않고 UIView 를 상속 박응 커스텀 클래스를 코드로 구성할 때 사용되는 메서드
    override init(frame: CGRect) {  // UIView 애 만들어져있는 메서드
        super.init(frame: frame)

        setUpUI()
    }
    
    // XIB -> NIB 변환과정에서 객체 생성 시 필요한 init
    // InterFace Builder 에서 생성된 뷰들이 초기화 될 때 사용
    required init?(coder: NSCoder) {  // NSCoding 에 만들어지는 메서드
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        borderStyle = .none
        layer.cornerRadius = 8
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        textAlignment = .center
        font = .boldSystemFont(ofSize: 15)
        textColor = .black
    }
}

protocol ExampleProtocol {
    init(name:String)
}

class Mobile: ExampleProtocol {
    // required: 프로토콜에서 생성된 경우 사용하는 키워드
    // requirzed initializer
    required init(name: String) {
       
    }
}
