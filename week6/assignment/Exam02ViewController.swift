//
//  Exam02ViewController.swift
//  week6
//
//  Created by 장혜성 on 2023/08/22.
//

import UIKit
import SnapKit
import Kingfisher

class Exam02ViewController: UIViewController {
    
    let bgUrl = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTCyu8HJW2ApXIdqXzmTILqdjZGyISSY-abCg&usqp=CAU"
    let profileUrl = "https://cdn.pixabay.com/photo/2023/08/11/12/41/capuchin-8183528_1280.jpg"
    
    let mainThumbImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let opacityView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.isOpaque = false
        return view
    }()
    
    static func containerView() -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    static func topButton(name: String) -> UIButton {
        let view = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .small)
        
        let img = UIImage(systemName: name, withConfiguration: config)
        view.setImage(img, for: .normal)
        view.tintColor = .white
        return view
    }
    
    static func bottomContentButton(name: String, title: String) -> UIButton {
        let view = UIButton()
        let symbolConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .small)
        
        let img = UIImage(systemName: name, withConfiguration: symbolConfig)
        view.setImage(img, for: .normal)
        view.tintColor = .white
        
        var attString = AttributedString(title)
        attString.font = .systemFont(ofSize: 12, weight: .light)
        attString.foregroundColor = .white
        var config = UIButton.Configuration.filled()
        config.attributedTitle = attString
        config.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        config.image = UIImage(systemName: name)
        config.imagePadding = 4
        config.imagePlacement = .top
        config.baseBackgroundColor = .clear
        view.configuration = config
        return view
    }
    
    static func dotView() -> UIView {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 5
        view.snp.makeConstraints { make in
                make.width.equalTo(10)
        }
        return view
    }
    
    let topContainerView = containerView()
    let bottomContainerView = containerView()
    
    let closeButton = topButton(name: "xmark")
    
    let leftButton = topButton(name: "heart.circle")
    let centerButton = topButton(name: "circle.grid.3x3.circle")
    let rightButton = topButton(name: "gearshape.circle")
    
    let profileImageView = {
        let view = UIImageView()
        //        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let nicknameLabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = .systemFont(ofSize: 16)
        view.numberOfLines = 1
        view.text = "Jack"
        return view
    }()
    
    let chatButton = bottomContentButton(name: "cloud.fill", title: "나와의 채팅")
    let editButton = bottomContentButton(name: "pencil", title: "프로필 편집")
    let storyButton = bottomContentButton(name: "point.3.filled.connected.trianglepath.dotted", title: "카카오스토리")
    
    let contentLineView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let chatDotView = dotView()
    let editDotView = dotView()
    let storyDotView = dotView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        closeButton.addTarget(self, action: #selector(closeButtonClicked), for: .touchUpInside)
        setBackgroundView()
        
        /**
         큰 뷰 2개로 나누기
         */
        setTopContainerView()
        setBottomContainerView()
        
        topContainerView.addSubview(closeButton)
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(topContainerView.snp.leading).offset(16)
        }
        
        setTopStackView()
        
        topContainerView.addSubview(nicknameLabel)
        nicknameLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        guard let profileUrl = URL(string: profileUrl) else { return }
        profileImageView.kf.setImage(
            with: profileUrl,
            options: [.processor(RoundCornerImageProcessor(cornerRadius: 50))])
        topContainerView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(nicknameLabel.snp.top).offset(-10)
            make.size.equalTo(100)
        }
        
        setBottomStackView()
        setBottomDotStackView()
        
        bottomContainerView.addSubview(contentLineView)
        contentLineView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
        }
        
    }
    
    @objc
    func closeButtonClicked() {
        print("닫기버튼 클릭")
    }
    
    func setBackgroundView() {
        guard let url = URL(string: bgUrl) else { return }
        mainThumbImageView.kf.setImage(with: url)
        view.addSubview(mainThumbImageView)
        mainThumbImageView.snp.makeConstraints { make in
            make.size.equalTo(view)
        }
        
        view.addSubview(opacityView)
        opacityView.snp.makeConstraints { make in
            make.size.equalTo(view)
        }
    }
    
    func setTopContainerView() {
//        topContainerView.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
        view.addSubview(topContainerView)
        topContainerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view)
            make.height.equalTo(view).multipliedBy(0.7)
        }
    }
    
    func setBottomContainerView() {
        view.addSubview(bottomContainerView)
        bottomContainerView.snp.makeConstraints { make in
            make.top.equalTo(topContainerView.snp.bottom)
            make.width.equalTo(view)
            make.bottom.equalTo(view)
        }
    }
    
    func setTopStackView() {
        let topBtnStackView = UIStackView(arrangedSubviews: [leftButton, centerButton, rightButton])
        
        topContainerView.addSubview(topBtnStackView)
        topBtnStackView.axis = .horizontal
        topBtnStackView.distribution = .equalSpacing
        topBtnStackView.alignment = .fill
        topBtnStackView.spacing = 8
        topBtnStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailingMargin.equalTo(-8)
        }
    }
    
    func setBottomStackView() {
        let stackView = UIStackView(arrangedSubviews: [chatButton, editButton, storyButton])
        
        bottomContainerView.addSubview(stackView)
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 30
        stackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-70)
            make.centerX.equalToSuperview()
        }
    }
    
    func setBottomDotStackView() {
        let stackView = UIStackView(arrangedSubviews: [chatDotView, editDotView, storyDotView])
        
        bottomContainerView.addSubview(stackView)
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 100
        stackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-120)
            make.leadingMargin.equalToSuperview().offset(90)
            
            make.height.equalTo(10)
        }
    }
}
