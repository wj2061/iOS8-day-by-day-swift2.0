//
//  HorseRaceTests.swift
//  HorseRaceTests
//
//  Created by WJ on 15/10/31.
//  Copyright © 2015年 wj. All rights reserved.
//

import XCTest
import HorseRace
import UIKit


class HorseRaceTests: XCTestCase {
    var viewController:ViewController!
    var raceController:TwoHorseRaceController!
    
    
    override func setUp() {
        super.setUp()
        let window = UIApplication.sharedApplication().delegate?.window!
        viewController = window?.rootViewController as? ViewController
        raceController = viewController.raceController
        
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        viewController.raceController.reset()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBasicAsyncMethod(){
        let expectation = expectationWithDescription("Async method")
        
        raceController.someKindOfAsyncMethod { () -> () in
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5, handler: nil)
    }
    
    func testRaceCallbacks(){
        let h1Expection = expectationWithDescription("Horse 1 should complete")
        let h2Expection = expectationWithDescription("Horse 2 should complete")
        
        raceController.startRace(3) { (horse ) -> Void in
            switch horse.horseView{
            case self.viewController.horse1:
                h1Expection.fulfill()
            case self.viewController.horse2:
                h2Expection.fulfill()
            default:
                XCTFail("Compeletion called with unknown horse")
            }
        }
        waitForExpectationsWithTimeout(5, handler: nil)
    }
    
    func testResetButtonEnableOnceRaceComplete(){
        let expection = keyValueObservingExpectationForObject(viewController.resetButton, keyPath: "enabled", expectedValue: true)

        viewController.start(viewController.startRaceButton)
        
        waitForExpectationsWithTimeout(5, handler: nil)
    }
    
    
    

}
