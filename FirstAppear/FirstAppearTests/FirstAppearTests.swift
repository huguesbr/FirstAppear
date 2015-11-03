//
//  FirstAppearTests.swift
//  FirstAppear
//
//  Created by Hugues Bernet-Rollande on 3/11/15.
//  Copyright © 2015 Hugues Bernet-Rollande. All rights reserved.
//

import XCTest

//protocol Fullfillable {
//    var expectation:XCTestExpectation { get set }
//}
//extension Fullfillable {
//    var expectation:XCTestExpectation
//}

class ExpectationViewController: UIViewController {
    var e:XCTestExpectation?
}

class FirstAppearTests: XCTestCase {
    
    func testViewWillFirstAppear() {
        let expectation = self.expectationWithDescription("will first appear");
        class dummyController: ExpectationViewController {
            var count = 0
            @objc func viewWillFirstAppear(animated: Bool) {
                e?.fulfill()
                if(count++ > 1) {
                    XCTFail("will first appear should be called once only")
                }
            }
        }
        let c = dummyController()
        c.e = expectation
        c.viewWillAppear(true);
        c.viewWillAppear(true);
        self.waitForExpectationsWithTimeout(1, handler: nil)
    }
    
    func testViewDidFirstAppearOnce() {
        let expectation = self.expectationWithDescription("did first appear");
        class dummyController: ExpectationViewController {
            var count = 0
            @objc func viewDidFirstAppear(animated: Bool) {
                e?.fulfill()
                if(count++ > 1) {
                    XCTFail("did first appear should be called once only")
                }
            }
        }
        let c = dummyController()
        c.e = expectation
        c.viewDidAppear(true);
        c.viewDidAppear(true);
        self.waitForExpectationsWithTimeout(1, handler: nil)
    }
    
}
