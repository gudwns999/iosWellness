//
//  CheckCookie.swift
//  wellness
//
//  Created by Kim's_PC on 2016. 5. 14..
//  Copyright © 2016년 kim. All rights reserved.
//

import Foundation
import UIKit

class CheckCookie: UIViewController{
    @IBOutlet weak var CCMainLabel: UILabel!
    override func viewDidLoad() {
        CCMainLabel.numberOfLines = 0
        CCMainLabel.text = "로그인한 경험이 있다면 메인화면\n로그인한 경험이 없다면 로긴화면\n근데 기능 구현 안했으니 일단 버튼클릭!"
        
    }
}