//
//  GojekAssignmentTests.swift
//  GojekAssignmentTests
//
//  Created by Pankaj Raghav on 26/09/20.
//

import XCTest
@testable import GojekAssignment

class GojekAssignmentTests: XCTestCase {
   
  
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testGetRepository() {
        let urlString = Constants.Base_Url + Constants.Api_EndPoint
        let exception =  self.expectation(description: "")
        ServiceManager.shared.performRequest(request: APIRequest(url: urlString)) {(result : Result< RepositoryResponse , NetworkError>) in
          
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
                exception.fulfill()
            case .failure(let error) :
            XCTFail(error.localizedDescription)
            }
        }
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testGetDataFromDatabase(){
        let viewModel =  RepositoryViewModel()
        viewModel.repositoryList.bind { (list) in
            XCTAssertNotNil(list)
        }
        viewModel.fetchData()
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
