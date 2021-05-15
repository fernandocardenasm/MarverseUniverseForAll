//
//  RemoteCharactersLoader.swift
//  MarvelUniverseForAll
//
//  Created by Fernando Cardenas on 15.05.21.
//

import Combine
import Foundation

public protocol CharacterLoader {
    func loadCharacters() -> AnyPublisher<[Character], Error>
}

public class RemoteCharacterLoader: CharacterLoader {
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
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
    
    public func loadCharacters() -> AnyPublisher<[Character], Swift.Error> {
        Deferred {
            Future { [self] promise in
                client.get(from: url) { result in
                    
                    switch result {
                    case let .success((data, response)):
                        promise(Self.map(data, response))
                    case .failure:
                        promise(.failure(Error.connectivity))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
    
    private static func map(_ data: Data, _ response: HTTPURLResponse) -> Result<[Character], Swift.Error> {
        do {
            let characters = try CharactersMapper.map(data, response)
            return .success(characters.toModels())
        } catch {
            return .failure(error)
        }
    }
}

private struct RemoteContainerRoot: Decodable {
    var code: Int
    var status: String
    var data: ContainerData
    
    struct ContainerData: Decodable {
        var results: [RemoteCharacter]
    }
}

private struct RemoteCharacter: Decodable {
    let name: String
    let thumbnail: Thumbnail
    
    struct Thumbnail: Decodable {
        let path: String
        let `extension`: String
    }
    
    var thumbnailURL: String {
        thumbnail.path + "." + thumbnail.extension
    }
}

private struct CharactersMapper {
    static func map(_ data: Data, _ response: HTTPURLResponse) throws -> [RemoteCharacter] {
        guard response.statusCode == 200,
              let root = try? JSONDecoder().decode(RemoteContainerRoot.self, from: data) else {
            throw RemoteCharacterLoader.Error.invalidData
        }
        
        return root.data.results
    }
}

private extension Array where Element == RemoteCharacter {
    func toModels() -> [Character] {
        map { Character(name: $0.name,
                        thumbnailURL: URL(string: $0.thumbnailURL)) }
    }
}

public struct Character {
    let name: String
    let thumbnailURL: URL?
}
