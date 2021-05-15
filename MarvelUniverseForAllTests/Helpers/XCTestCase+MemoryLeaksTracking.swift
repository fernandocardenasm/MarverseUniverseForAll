//
//  XCTestCase+MemoryLeaksTracking.swift
//  MarvelUniverseForAllTests
//
//  Created by Fernando Cardenas on 15.05.21.
//

import Foundation

import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential Memory leak.", file: file, line: line)
        }
    }
}
