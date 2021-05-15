//
//  SharedTestHelpers.swift
//  MarvelUniverseForAllTests
//
//  Created by Fernando Cardenas on 15.05.21.
//

import Foundation

func anyURL() -> URL {
    URL(string: "http://any-url.com")!
}

func anyNSError() -> NSError {
    NSError(domain: "any", code: 200)
}
