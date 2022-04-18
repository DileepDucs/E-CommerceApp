//
//  HomeViewControllerTests.swift
//  ArtiumTests
//
//  Created by Dileep Jaiswal on 18/04/22.
//

import XCTest
@testable import Artium

class HomeViewControllerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func makeSUT() -> HomeViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
        sut.loadViewIfNeeded()
        return sut
    }
    
    func testViewDidLoadCallsPresenter() {
        let sut = makeSUT()
        sut.viewDidLoad()
        XCTAssertEqual(sut.navigationItem.title, "TITLE")
        XCTAssertEqual(sut.fullNameLabel.text, "NAME")
        XCTAssertEqual(sut.numberOfAlbumsLabel.text, "1")
        XCTAssertEqual(sut.numberOfFollowersLabel.text, "2")
    }

    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
