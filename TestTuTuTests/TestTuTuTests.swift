//
//  TestTuTuTests.swift
//  TestTuTuTests
//
//  Created by Alexander Novikov on 06.10.2021.
//

import XCTest
@testable import TestTuTu

class TestTuTuTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testParseWeather() throws {
        let json = "{\"cod\":\"200\",\"message\":0,\"cnt\":3,\"list\":[{\"dt\":1633640400,\"main\":{\"temp\":4.92,\"feels_like\":3.64,\"temp_min\":4.92,\"temp_max\":5.84,\"pressure\":1041,\"sea_level\":1041,\"grnd_level\":1023,\"humidity\":64,\"temp_kf\":-0.92},\"weather\":[{\"id\":800,\"main\":\"Clear\",\"description\":\"clear sky\",\"icon\":\"01n\"}],\"clouds\":{\"all\":1},\"wind\":{\"speed\":1.67,\"deg\":190,\"gust\":2.58},\"visibility\":10000,\"pop\":0,\"sys\":{\"pod\":\"n\"},\"dt_txt\":\"2021-10-07 21:00:00\"},{\"dt\":1633651200,\"main\":{\"temp\":4.77,\"feels_like\":4.77,\"temp_min\":4.77,\"temp_max\":4.92,\"pressure\":1042,\"sea_level\":1042,\"grnd_level\":1023,\"humidity\":68,\"temp_kf\":-0.15},\"weather\":[{\"id\":800,\"main\":\"Clear\",\"description\":\"clear sky\",\"icon\":\"01n\"}],\"clouds\":{\"all\":0},\"wind\":{\"speed\":1.31,\"deg\":229,\"gust\":1.41},\"visibility\":10000,\"pop\":0,\"sys\":{\"pod\":\"n\"},\"dt_txt\":\"2021-10-08 00:00:00\"},{\"dt\":1633662000,\"main\":{\"temp\":4.23,\"feels_like\":4.23,\"temp_min\":4.23,\"temp_max\":4.23,\"pressure\":1042,\"sea_level\":1042,\"grnd_level\":1023,\"humidity\":71,\"temp_kf\":0},\"weather\":[{\"id\":800,\"main\":\"Clear\",\"description\":\"clear sky\",\"icon\":\"01n\"}],\"clouds\":{\"all\":0},\"wind\":{\"speed\":0.96,\"deg\":253,\"gust\":0.97},\"visibility\":10000,\"pop\":0,\"sys\":{\"pod\":\"n\"},\"dt_txt\":\"2021-10-08 03:00:00\"}],\"city\":{\"id\":524901,\"name\":\"Moscow\",\"coord\":{\"lat\":55.7522,\"lon\":37.6156},\"country\":\"RU\",\"population\":1000000,\"timezone\":10800,\"sunrise\":1633578239,\"sunset\":1633618229}}"
        let data = json.data(using: String.Encoding.utf8)
        let weathers = WeatherManager.shared.parseWeather(data!, "Moscow")
        XCTAssertEqual(weathers.count, 3)
        weathers.forEach { XCTAssertEqual($0.city, "Moscow") }
        
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
