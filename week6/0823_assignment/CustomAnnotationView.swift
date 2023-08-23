//
//  CustomAnnotationView.swift
//  week6
//
//  Created by 장혜성 on 2023/08/23.
//

import UIKit
import MapKit

class CustomAnnotationView: MKAnnotationView {
    
    static let identifier = "CustomAnnotationView"
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        centerOffset = CGPoint(x: 0, y: -frame.size.height / 2)
        setUI()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init coder: 이 implemented 되지 않았음")
    }
    
    private func setUI() {
        backgroundColor = .clear
    }
}
