//
//  CustomSession.swift
//  TestTuTu
//
//  Created by Alexander Novikov on 06.10.2021.
//

import Foundation
import Alamofire

extension Session {
    static let custom: Session = {
        let configuration = URLSessionConfiguration.default
        let sessionManager = Session(configuration: configuration)
        return sessionManager
    }()
}
