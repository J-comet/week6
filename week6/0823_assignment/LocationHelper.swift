//
//  LocationHelper.swift
//  week6
//
//  Created by 장혜성 on 2023/08/23.
//

import CoreLocation
import Foundation

class LocationHelper {
    static let shared = LocationHelper()
    private init() {}
    let locationManager = CLLocationManager()
    
    enum DeviceGPS {
        case on, off
    }
    
    func deviceLoactionStatus(completion: @escaping (DeviceGPS, CLAuthorizationStatus?) -> ()) {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                let authorization: CLAuthorizationStatus
                
                if #available(iOS 14.0, *) {
                    authorization = self.locationManager.authorizationStatus
                } else {
                    authorization = CLLocationManager.authorizationStatus()
                }
                completion(DeviceGPS.on, authorization)

            } else {
                print("아이폰 위치서비스가 꺼져있으면 위치 권한요청을 할 수 없음")
                completion(DeviceGPS.off, nil)
            }
        }
    }
}
