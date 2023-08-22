//
//  LocationViewController.swift
//  week6
//
//  Created by 장혜성 on 2023/08/22.
//

import UIKit
import CoreLocation  // 1. 위치 임포트

class LocationViewController: UIViewController {

    // 2. 위치매니저 생성 : 위치에 대한 대부분을 담당
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // 3. 위치 프로토콜 연결
        locationManager.delegate = self
        
        /**
         Info.plist 에서 설정한 것과 같은 것을. 선택해야됨
         */
//        locationManager.requestWhenInUseAuthorization()
        
        checkDeviceLocationAuthorization()
        
    }
    
    
    func checkDeviceLocationAuthorization() {
        // 아이폰 설정에서 위치서비스 확인
        DispatchQueue.global().async {
            
            // 메인스레드에서 체크하면 안됨.
            if CLLocationManager.locationServicesEnabled() {
                let authorization: CLAuthorizationStatus
                
                if #available(iOS 14.0, *) {
                    authorization = self.locationManager.authorizationStatus
                } else {
                    authorization = CLLocationManager.authorizationStatus()
                }
                
                print("authorization = \(authorization)")
                self.checkCurrentLocationAuthorization(status: authorization)
            } else {
                print("아이폰 위치서비스가 꺼져있으면 위치 권한요청을 할 수 없음")
            }
        }
        
    }
    
    func checkCurrentLocationAuthorization(status: CLAuthorizationStatus) {
        print("stats =",status)
        switch status {
        case .notDetermined:
            print("최초로 앱을 유저가 실행했을 때")
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()  // 얼럿을 띄워주는 역할
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
        case .authorizedAlways:
            print("authorizedAlways")
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
            //didUpDateLocationr
            locationManager.startUpdatingLocation()
        case .authorized:
            print("authorized")
        }
    }
}

// 4. 프르토콜 선언
extension LocationViewController: CLLocationManagerDelegate {
    
    // 5. 사용자의 위치를 성공적으로 가지고 온 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }
    
    // 6. 사용자의 위치를 못가지고 왔을 경우 (사용자의 권한거부시에도 호출 됨)
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }

    // 7. 사용자의 권한 상태가 바뀔 때를 얄려줌 (iOS 14 이상)
    // 거부했다가 설정에서 변경을 했거나 ,notDetermained 상태에서 허용을 했거나
    // 허용해서 위치를 가지고 오는 도중에 설정에서 거부를 하고 앱으로 다시 돌아올 때
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // 어떤 권한인지는 모르고 권한이 바뀌는 것만 암,
        print(#function)
        checkDeviceLocationAuthorization()
    }
    
    // iOS14 - Deprecated
    // 7. 사용자의 권한 상태가 바뀔 때를 얄려줌 (iOS 14 미만)
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
}
