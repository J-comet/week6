//
//  TextViewController.swift
//  week6
//
//  Created by 장혜성 on 2023/08/22.
//

import UIKit
import SnapKit

class TextViewController: UIViewController {
    
    // 1. 초기화 시점 미뤄서 함수를 통해 정적인 디자인 세팅
//    lazy var photoView = setImageView()
    //    func setImageView() -> UIImageView {
    //        let view = UIImageView()
    //        view.backgroundColor = .blue
    //        view.contentMode = .scaleAspectFill
    //        return view
    //    }
    
    // 2. 클로저를 통해서 함수 호출
    let photoView = {
        let view = UIImageView()
        view.backgroundColor = .blue
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let titleTextField = {
        let view = UITextField()
        view.borderStyle = .none
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.placeholder = "날짜를 입력해주세요"
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 15)
        return view
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        // 뷰의 순서가 중요하기 떄문에 직접 선언하는 것이
        // 뷰 계층구조를 파악하는데 더 쉬울듯
//        view.addSubview(photoView)
//        view.addSubview(titleTextField)
        
        [photoView, titleTextField].forEach { view in
            view.addSubview(view)
        }
        setupConstraints()
    }

    // 어떻게 다른파일에서 관리가 가능할지 추가 고민
    func setupConstraints() {
        photoView.snp.makeConstraints { make in
//            make.height.equalTo(200)
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view).multipliedBy(0.3)
        }
     
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(photoView.snp.bottom).offset(20)
            make.leadingMargin.equalTo(20)
//            make.leading.equalTo(view).inset(20)  // 위의 leadingMargin 과 동일한 코드
            
            make.trailingMargin.equalTo(-20)
            make.height.equalTo(50)
        }
    }
}
