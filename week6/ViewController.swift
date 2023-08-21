//
//  ViewController.swift
//  week6
//
//  Created by 장혜성 on 2023/08/21.
//

import UIKit

// 기존 방법
// 1. 객체 올린 후 , 아웃렛 연결 ,속성 조절 (autolayout storyboard)

// 코드로 ui
// 1. 뷰객체 프로퍼티 선언 (클래스 인스턴스 생성)
// 2. 명시적으로 루트뷰에 추가 ( + translatesAutoresizingMaskIntoConstraints = false )
// 3. 크기와 위치 정의
// => Frame 한계 - 다양한 디바이스 대응 불가
// => AutoResizingMask, AutoLayout => 지금까지 스토리보드로 대응
// => NSLayoutConstraints => 코드베이스 대응

class ViewController: UIViewController {

    let emailTextField = UITextField()
    let pwTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 루트뷰에 텍스트필드 추가
        view.addSubview(emailTextField)
        view.addSubview(pwTextField)
        
        // NSLayoutConstraint 와 AutoresizingMask 를 같이 사용할 수 없음.
        pwTextField.translatesAutoresizingMaskIntoConstraints = false
        
        // 레이아웃에 대한 활성화
        NSLayoutConstraint(item: pwTextField, attribute: .leading, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 50).isActive = true
        
        NSLayoutConstraint(item: pwTextField, attribute: .trailing, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1, constant: -50).isActive = true
        
        NSLayoutConstraint(item: pwTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 60).isActive = true
        
        NSLayoutConstraint(item: pwTextField, attribute: .top, relatedBy: .equal, toItem: emailTextField, attribute: .bottom, multiplier: 1, constant: 50).isActive = true
        
        pwTextField.backgroundColor = .link
        
        
        
        // 크기 위치 정의
        emailTextField.frame = CGRect(x: 50, y: 80, width: UIScreen.main.bounds.width - 100, height: 50)
        
        emailTextField.backgroundColor = .lightGray
        emailTextField.isSecureTextEntry = true
        emailTextField.keyboardType = .numberPad
        emailTextField.placeholder = "입력"
    }


}

