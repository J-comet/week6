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
//  1. isActive
//  2. addConstraints
// => NSLayoutAnchor

class ViewController: UIViewController {

    let emailTextField = UITextField()
    let pwTextField = UITextField()
    let signButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 루트뷰에 텍스트필드 추가
        view.addSubview(emailTextField)
        view.addSubview(pwTextField)
        
        
        // NSLayoutConstraint 와 AutoresizingMask 를 같이 사용할 수 없음.
        pwTextField.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        // 크기 위치 정의
        emailTextField.frame = CGRect(x: 50, y: 80, width: UIScreen.main.bounds.width - 100, height: 50)
        
        emailTextField.backgroundColor = .lightGray
        emailTextField.isSecureTextEntry = true
        emailTextField.keyboardType = .numberPad
        emailTextField.placeholder = "입력"
        
        // 레이아웃에 대한 활성화
        // 1. isActive 방식
//        NSLayoutConstraint(item: pwTextField, attribute: .leading, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 50).isActive = true
//
//        NSLayoutConstraint(item: pwTextField, attribute: .trailing, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1, constant: -50).isActive = true
//
//        NSLayoutConstraint(item: pwTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 60).isActive = true
//
//        NSLayoutConstraint(item: pwTextField, attribute: .top, relatedBy: .equal, toItem: emailTextField, attribute: .bottom, multiplier: 1, constant: 50).isActive = true
        
        
        
        // 2. addConstraints 방식
        let leading = NSLayoutConstraint(item: pwTextField, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 50)
        let trailing = NSLayoutConstraint(item: pwTextField, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -50)
        let height = NSLayoutConstraint(item: pwTextField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 60)
        let top = NSLayoutConstraint(item: pwTextField, attribute: .top, relatedBy: .equal, toItem: emailTextField, attribute: .bottom, multiplier: 1, constant: 50)
        view.addConstraints([leading, trailing, height, top])
        pwTextField.backgroundColor = .link
        
       setLayoutAnchor()
    }
    
    @objc
    func signupButtonClicked() {
        // 스토리보드에서 사용하지 않기 때문에 스냅뷰컨트롤러를 바로 사용
        let nav = UINavigationController(rootViewController: LocationViewController())
        present(nav, animated: true)
    }

    // NSLayoutAnchor 방식
    func setLayoutAnchor() {
        view.addSubview(signButton)
        signButton.translatesAutoresizingMaskIntoConstraints = false
        signButton.backgroundColor = .orange
        signButton.addTarget(self, action: #selector(signupButtonClicked), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            signButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signButton.widthAnchor.constraint(equalToConstant: 300),
            signButton.heightAnchor.constraint(equalToConstant: 50),
            signButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

