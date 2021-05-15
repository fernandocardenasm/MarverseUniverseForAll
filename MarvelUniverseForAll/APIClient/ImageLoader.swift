//
//  ImageLoader.swift
//  MarvelUniverseForAll
//
//  Created by Fernando Cardenas on 15.05.21.
//

import Combine
import Foundation
import Kingfisher

public protocol ImageLoader {
    typealias Result = AnyPublisher<Data, Error>
    
    func load(url: URL) -> Result
}

public class RemoteImageLoader: ImageLoader {
    private let imageClient: ImageClient
    public init(imageClient: ImageClient) {
        self.imageClient = imageClient
    }
    
    public func load(url: URL) -> ImageLoader.Result {
        Deferred {
            Future { [weak self] promise in
                self?.imageClient.get(from: url) { result in
                    switch result {
                    case let .success(data):
                        promise(.success(data))
                    case let .failure(error):
                        promise(.failure(error))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

public protocol ImageClient {
    typealias Result = Swift.Result<Data, Error>
    
    func get(from url: URL, completion: @escaping (Result) -> Void)
}

public class KingfisherImageClient: ImageClient {
    
    typealias Result = Swift.Result<Data, Error>
    
    private struct EmptyImageDataError: Error {}
    
    public func get(from url: URL, completion: @escaping (ImageClient.Result) -> Void) {
        KingfisherManager.shared.retrieveImage(with: url) { result in
            switch result {
            case let .success(imageResult):
                guard let data = imageResult.image.pngData() else {
                    return completion(.failure(EmptyImageDataError()))
                }
                completion(.success(data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
