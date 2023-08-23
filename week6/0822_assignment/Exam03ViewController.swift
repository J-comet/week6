//
//  Exam03ViewController.swift
//  week6
//
//  Created by 장혜성 on 2023/08/22.
//

import UIKit
import SnapKit
import Kingfisher

class Exam03ViewController: UIViewController {
    
    let bgUrl = "https://t3.ftcdn.net/jpg/06/01/27/40/240_F_601274042_Jfx6WyGTitUYJBYbTGMv9O6WE16Dh2JZ.jpg"
    
    let bgView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let topContainerView = {
        let view = UIView()
        view.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
        return view
    }()
    
    let bottomContainerView = {
        let view = UIView()
        view.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        return view
    }()
    
    let dateLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 13, weight: .light)
        view.textColor = .white
        view.numberOfLines = 1
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setBgView()
        setTopContainerView()
        setBottomContainerView()
    }

    func setBgView() {
        view.addSubview(bgView)
        guard let url = URL(string: bgUrl) else { return }
        bgView.kf.setImage(with: url)
        bgView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }

    func setTopContainerView() {
        view.addSubview(topContainerView)
        topContainerView.snp.makeConstraints { make in
            make.top.equalTo(view)
            make.width.equalTo(view)
            make.height.equalTo(view).multipliedBy(0.3)
        }
    }
    
    //MARK: -
    func setBottomContainerView() {
        view.addSubview(bottomContainerView)
        bottomContainerView.snp.makeConstraints { make in
            make.top.equalTo(topContainerView.snp.bottom)
            make.width.equalTo(view)
            make.bottom.equalTo(view)
        }
    }
    
    func setDateLabel() {
        
    }
}
