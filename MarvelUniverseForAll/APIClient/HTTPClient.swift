//
//  HTTPClient.swift
//  MarvelUniverseForAll
//
//  Created by Fernando Cardenas on 15.05.21.
//

import Foundation

public protocol HTTPClient {
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>
    
    func get(from url: URL, completion: @escaping (Result) -> Void)
}
