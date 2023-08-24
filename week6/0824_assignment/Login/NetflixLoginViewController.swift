//
//  NetflixLoginViewController.swift
//  week6
//
//  Created by 장혜성 on 2023/08/24.
//

import UIKit
import SnapKit

class NetflixLoginViewController: UIViewController {

    //MARK: - 디자인 START
    let titleLabel = {
        let view = UILabel()
        view.text = "JACKFLIX"
        view.font = .systemFont(ofSize: 30, weight: .heavy)
        view.textColor = .red
        return view
    }()
    
    let emailTextField = {
        let view = NetflixLoginTextField()
        view.keyboardType = .emailAddress
        view.attributedPlaceholder = NSAttributedString(string: "이메일 주소 또는 전화번호", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        return view
    }()
    
    let pwTextField = {
        let view = NetflixLoginTextField()
        view.isSecureTextEntry = true
        view.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        return view
    }()
    
    let nicknameTextField = {
        let view = NetflixLoginTextField()
        view.keyboardType = .namePhonePad
        view.attributedPlaceholder = NSAttributedString(string: "닉네임", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        return view
    }()
    
    let locationTextField = {
        let view = NetflixLoginTextField()
        view.keyboardType = .decimalPad
        view.attributedPlaceholder = NSAttributedString(string: "위치", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        return view
    }()
    
    let codeTextField = {
        let view = NetflixLoginTextField()
        view.keyboardType = .numberPad
        view.attributedPlaceholder = NSAttributedString(string: "추천코드 입력", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        return view
    }()
    
    let signButton = {
        let view = UIButton()
        var attString = AttributedString("회원가입")
        attString.font = .systemFont(ofSize: 14, weight: .bold)
        attString.foregroundColor = .white
        var config = UIButton.Configuration.filled()
        config.attributedTitle = attString
        config.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        config.baseBackgroundColor = .red
        view.configuration = config
        return view
    }()
    
    let addGuideLabel = {
        let view = UILabel()
        view.text = "추가 정보 입력"
        view.font = .systemFont(ofSize: 14, weight: .medium)
        view.textColor = .white
        return view
    }()
    
    let selectSwitch = {
        let view = UISwitch()
        view.setOn(false, animated: true)
        view.onTintColor = .red
        view.thumbTintColor = .white
        return view
    }()
    
    //MARK: - 디자인 END
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        
        setHideKeyboardTabGesture()
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.centerX.equalTo(view)
        }
     
        let stackView = UIStackView(arrangedSubviews: [emailTextField, pwTextField, nicknameTextField, locationTextField, codeTextField])
        
        // 스택뷰
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.alignment = .fill
        stackView.spacing = 12
        stackView.snp.makeConstraints { make in
            make.centerY.equalTo(view)
            make.horizontalEdges.equalTo(view).inset(30)
        }
        
        view.addSubview(signButton)
        signButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(view).inset(30)
            make.height.equalTo(50)
        }
        
        view.addSubview(selectSwitch)
        selectSwitch.snp.makeConstraints { make in
            make.top.equalTo(signButton.snp.bottom).offset(12)
            make.trailing.equalTo(signButton.snp.trailing)
        }
        
        view.addSubview(addGuideLabel)
        addGuideLabel.snp.makeConstraints { make in
            make.centerY.equalTo(selectSwitch)
            make.leading.equalTo(signButton.snp.leading)
        }
    }

    @objc
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    func setHideKeyboardTabGesture() {
        var tap = UITapGestureRecognizer()
        tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
    }

}
