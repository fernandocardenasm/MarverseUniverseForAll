//
//  RemoteCharactersLoader.swift
//  MarvelUniverseForAll
//
//  Created by Fernando Cardenas on 15.05.21.
//

import Combine
import Foundation

public protocol CharacterLoader {
    func loadCharacters() -> AnyPublisher<[Character], Never>
}

public class RemoteCharacterLoader: CharacterLoader {
    
    private let url: URL
    private let client: HTTPClient
    
    
    public init(url: URL,client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    let seedCharacters: [Character] = [
        Character(name: "3-D Man",
                  thumbnailURL: URL(string: "https://s29843.pcdn.co/blog/wp-content/uploads/sites/2/2019/06/YouTube-Thumbnail-Sizes.png")!),
        Character(name: "A-Bomb (HAS)",
                  thumbnailURL: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16.jpg")!),
        Character(name: "Aaron Stack",
                  thumbnailURL: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg")!),
        Character(name: "Abomination (Emil Blonsky)",
                  thumbnailURL: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/9/50/4ce18691cbf04.jpg")!),
        Character(name: "Abomination (Ultimate)",
                  thumbnailURL: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg")!),
        Character(name: "Absorbing Man",
                  thumbnailURL: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/1/b0/5269678709fb7.jpg")!)
    ]
    
    public func loadCharacters() -> AnyPublisher<[Character], Never> {
        Deferred {
            Future { [self] promise in
                client.get(from: url) { result in
                    promise(.success(seedCharacters))
                }
            }
        }.eraseToAnyPublisher()
    }
}

public struct Character {
    let name: String
    let thumbnailURL: URL
}
