//
//  UIViewController+Extension.swift
//  week6
//
//  Created by 장혜성 on 2023/08/24.
//

import UIKit

extension UIViewController {
    
    enum TransitionStyle {
        case present                    // 기본 present
        case prensentNavigation           // 네이바 임베디드 된 present
        case presentFulllNavigation         // 네비바 풀스크린, fullscreen present
        case push
    }
    
    // Generic: 타입에 유연하게 대응하기 위한 요소
    // 코드 중복과 재사용에 대응하기가 좋아서 추상적인 표현 가능
    
    /**
     "고래밥 "     >    String
     String       >  String.self    > String.Type
     */
    
    // 스토리보드 화면 전환
    func transition<T: UIViewController>(viewController: T.Type, style: TransitionStyle, storyboard: String) {
        let sb = UIStoryboard(name: storyboard, bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: String(describing: viewController)) as? T else { return }
        
        switch style {
        case .present:
            present(vc, animated: true)
        case .prensentNavigation:
            let nav = UINavigationController(rootViewController: vc)
            present(nav, animated: true)
        case .presentFulllNavigation:
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        case .push:
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // Type Parameter: 타입의 종류는 알려주지 않지만, 모두 같은 타입이 들어갈 것을 암시
    // UpperCased
    func configureBorder<T>(view: T) where T: UIView {
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.clipsToBounds = true
    }
    
    // AdditiveArithmetic, + 기능을 사용가능하도록 해주는 프로토콜이 포함된 요소만 Wow 값이 될 수 있도록 제약
    // T: UIView , Type Constraints: 클래스 제약, 프로토콜 제약
    func sum<T: AdditiveArithmetic>(a: T, b: T) -> T {
        return a + b
    }
    
    func sumInt(a: Int, b: Int) -> Int {
        return a + b
    }
    
    func sumDouble(a: Double, b: Double) -> Double {
        return a + b
    }
    
    func sumFloat(a: Float, b: Float) -> Float {
        return a + b
    }
}
