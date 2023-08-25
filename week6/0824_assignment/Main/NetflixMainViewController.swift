//
//  NetflixMainViewController.swift
//  week6
//
//  Created by 장혜성 on 2023/08/24.
//

import UIKit
import SnapKit

class NetflixMainViewController: UIViewController {
    
    //MARK: - 디자인 Start
    let topContainerView = {
        let view = UIView()
        return view
    }()
    
    let mainBackgroundImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "어벤져스엔드게임")
        return view
    }()
    
    let mainOpacityView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        return view
    }()
    
    let logoImageView = {
        let view = UIImageView()
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .medium, scale: .large)
        let img = UIImage(systemName: "n.circle.fill", withConfiguration: config)
        view.tintColor = .white
        view.image = img
        return view
    }()
    
    let tvCategoryLabel = {
        let view = NetflixMainCategoryLabel()
        view.text = "TV프로그램"
        return view
    }()
    
    let movieCategoryLabel = {
        let view = NetflixMainCategoryLabel()
        view.text = "영화"
        return view
    }()
    
    let myCategoryLabel = {
        let view = NetflixMainCategoryLabel()
        view.text = "내가 찜한 콘텐츠"
        return view
    }()
    
    let favoriteButton = {
        let view = UIButton()
        var attString = AttributedString("내가 찜한 컨텐츠")
        attString.font = .systemFont(ofSize: 12, weight: .light)
        attString.foregroundColor = .white
        var config = UIButton.Configuration.filled()
        config.attributedTitle = attString
        config.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        config.image = UIImage(systemName: "checkmark")
        config.imagePadding = 8
        config.imagePlacement = .top
        config.baseBackgroundColor = .clear
        view.configuration = config
        return view
    }()
    
    let infoButton = {
        let view = UIButton()
        var attString = AttributedString("정보")
        attString.font = .systemFont(ofSize: 12, weight: .light)
        attString.foregroundColor = .white
        var config = UIButton.Configuration.filled()
        config.attributedTitle = attString
        config.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        config.image = UIImage(systemName: "info.circle")
        config.imagePadding = 8
        config.imagePlacement = .top
        config.baseBackgroundColor = .clear
        view.configuration = config
        return view
    }()
    
    let playButton = {
        let view = UIButton()
        view.tintColor = .white
        var attString = AttributedString("재생")
        attString.font = .systemFont(ofSize: 12, weight: .medium)
        attString.foregroundColor = .black
        var config = UIButton.Configuration.filled()
        config.attributedTitle = attString
        config.contentInsets = .init(top: 6, leading: 0, bottom: 6, trailing: 0)
        config.image = UIImage(systemName: "play.fill")
        config.imagePadding = 4
        config.imagePlacement = .leading
        view.configuration = config
        view.snp.makeConstraints { make in
                make.width.equalTo(100).priority(999)
                }
        return view
    }()
    // 상단 컨테이너 뷰 end
    
    let bottomContainerView = {
        let view = UIView()
        return view
    }()
    
    let previewLabel = {
        let view = UILabel()
        view.text = "미리보기"
        view.textColor = .white
        view.font = .systemFont(ofSize: 16, weight: .bold)
        return view
    }()
    
    let circleImageView = {
        let view = NetflixMainCircleImageView(frame: .zero)
        view.image = UIImage(named: "1")
        return view
    }()
    
    let circleImageView2 = {
        let view = NetflixMainCircleImageView(frame: .zero)
        view.image = UIImage(named: "2")
        return view
    }()
    
    let circleImageView3 = {
        let view = NetflixMainCircleImageView(frame: .zero)
        view.image = UIImage(named: "3")
        return view
    }()
    
    //MARK: - 디자인 End
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setTopContainerView()
        setBottomContainerView()
    }
    
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        DispatchQueue.main.async {
//            self.circleImageView.layer.cornerRadius = min(self.circleImageView.frame.width / 2, self.circleImageView.frame.height / 2)
//            self.circleImageView2.layer.cornerRadius = min(self.circleImageView2.frame.width / 2, self.circleImageView2.frame.height / 2)
//            self.circleImageView3.layer.cornerRadius = min(self.circleImageView3.frame.width / 2, self.circleImageView3.frame.height / 2)
//        }
//    }
    
    func setTopContainerView(){
        // 상단영역
        topContainerView.backgroundColor = .yellow
        view.addSubview(topContainerView)
        topContainerView.snp.makeConstraints { make in
            make.width.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.8)
        }
        
        // 백그라운드 메인 이미지 추가
        topContainerView.addSubview(mainBackgroundImageView)
        mainBackgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // opacity 뷰 추가
        topContainerView.addSubview(mainOpacityView)
        mainOpacityView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // 로고 이미지 추가
        topContainerView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(16)
        }
        
        // 상단 스택뷰 추가
        let categoryStackView = UIStackView(arrangedSubviews: [tvCategoryLabel, movieCategoryLabel, myCategoryLabel])
        
        topContainerView.addSubview(categoryStackView)
        categoryStackView.axis = .horizontal
        categoryStackView.distribution = .equalSpacing
        categoryStackView.alignment = .center
        categoryStackView.spacing = 8
        categoryStackView.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView).offset(4)
            make.leading.equalTo(logoImageView.snp.trailing).offset(28)
            make.trailing.equalToSuperview().offset(-28)
        }
        
        
        let buttonStackView = UIStackView(arrangedSubviews: [favoriteButton, playButton, infoButton])
        
        // 버튼 스택뷰
        topContainerView.addSubview(buttonStackView)
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fill
        buttonStackView.alignment = .center
        buttonStackView.spacing = 8
        buttonStackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(50)
        }
    }
    
    func setBottomContainerView() {
        // 하단 컨테이너뷰
        bottomContainerView.backgroundColor = .black
        view.addSubview(bottomContainerView)
        bottomContainerView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(topContainerView.snp.bottom)
            make.bottom.equalToSuperview()
        }
        
        // 미리보기
        previewLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        bottomContainerView.addSubview(previewLabel)
        previewLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(8)
        }
        
        let circleImageStackView = UIStackView(arrangedSubviews: [circleImageView, circleImageView2, circleImageView3])
        
        // 스택뷰
        bottomContainerView.addSubview(circleImageStackView)
        circleImageStackView.axis = .horizontal
        circleImageStackView.distribution = .fillEqually
        circleImageStackView.alignment = .fill
        circleImageStackView.spacing = 4
        circleImageStackView.snp.makeConstraints { make in
            make.top.equalTo(previewLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(4)
            make.height.equalToSuperview().multipliedBy(0.7)
            make.bottom.equalToSuperview().inset(16)
        }
    }

}
