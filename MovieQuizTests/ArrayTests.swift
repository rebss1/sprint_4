//
//  ArrayTests.swift
//  MovieQuizTests
//
//  Created by Илья Лощилов on 11.12.2023.
//

import Foundation
import XCTest

@testable import MovieQuiz

class ArrayTests: XCTestCase {
    func getValueInRanhge() throws {
        //Given
        let array = [1, 1, 2, 3, 5]
        
        //When
        let value = array[safe: 2]
        
        //Then
        XCTAssertNotNil(value)
        XCTAssertEqual(value, 2)
        
    }
    
    func getValueOutOfRanhge() throws {
        //Given
        let array = [1, 1, 2, 3, 5]

        //When
        let value = array[safe: 20]

        //Then
        XCTAssertNil(value)
    }
}
