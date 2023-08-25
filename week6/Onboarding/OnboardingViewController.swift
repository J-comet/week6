//
//  OnboardingViewController.swift
//  week6
//
//  Created by 장혜성 on 2023/08/25.
//

import UIKit

class FirstViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
}

class SecondViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
    }
}

class ThirdViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
    }
}

class OnboardingViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    // 인트로 배열
    var list: [UIViewController] = []
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        list = [FirstViewController(), SecondViewController(), ThirdViewController()]
        
        view.backgroundColor = .purple
        
        delegate = self
        dataSource = self
        
        // 첫번째 인트로 설정
        guard let first = list.first else { return }
        setViewControllers([first], direction: .forward, animated: true)
        
        // 기본 PageControl에 대한 위치는 커스텀 불가능, 색상은 가능
        // PageControl 위치를 커스텀하고 싶으면 직접 pageControl 를 올려서 사용
        
        // 페이지컨트롤러를 다룰 때 언제 인스턴스가 제거되는지 확인이 필요할 듯
    }
    
    // 이전화면 미리 준비
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = list.firstIndex(of: viewController) else { return nil }
        let previousIndex = currentIndex - 1
        return previousIndex < 0 ? nil : list[previousIndex]
    }
    
    // 다음화면 미리 준비
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = list.firstIndex(of: viewController) else { return nil }
        let afterIndex = currentIndex + 1
        return afterIndex >= list.count ? nil : list[afterIndex]
    }

    // pageControl 갯수
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return list.count
    }
    
    // 현재 선택된 pageControl 결정?
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let first = viewControllers?.first, let index = list.firstIndex(of: first) else { return 0 }
        return index
    }
}
