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

    // SourceType 촬영, 앨범에 저장, 갤러리 접근
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        // 뷰의 순서가 중요하기 떄문에 직접 선언하는 것이
        // 뷰 계층구조를 파악하는데 더 쉬울듯
//        view.addSubview(photoView)
//        view.addSubview(titleTextField)
        
        [photoView, titleTextField].forEach { item in
            view.addSubview(item)
        }
        setupConstraints()
        
        
//        self.navigationController?.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 갤러리에 있는 사진만 가지고 오는 기능만 있다면 사진권한 안줘도 됨.
        
        // available SourceType 에 접근 가능한지
        // 카메라를 사용할 때는 UIImagePickerController, 갤러리 관련은 PHPicker
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("카메라 접근 불가능")
//            print("갤러리 접근 불가능")
            return
        }
        picker.delegate = self
        picker.sourceType = .camera
        picker.allowsEditing = true  // 이미지 수정 허용할지 안할지 (크롭, 확대, 축소)
        
//        let picker = UIFontPickerViewController() // 폰트변경 ios 14
//        let picker = UIColorPickerViewController()  // 컬러변경
        present(picker, animated: true)
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

extension TextViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("선택 취소")
        dismiss(animated: true)
    }
    
    // 사진 선택 or 카메라 촬영 직후 호출됨.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("사진 선택 or 카메라 촬영 직후")
        
        // .InfoKey.originalImage - 이미지를 크롭하거나 확대,축소해도 원본이미지 사용
        // .InfoKey.editedImage - 이미지를 크롭하거나 확대,축소했을 때의 이미지 사용
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.photoView.image = image
            dismiss(animated: true)
        }
        
    }
}
