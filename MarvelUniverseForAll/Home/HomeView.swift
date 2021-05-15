//
//  HomeView.swift
//  MarvelUniverseForAll
//
//  Created by Fernando Cardenas on 27.04.21.
//

import Combine
import SwiftUI

public class HomeViewModel: ObservableObject {
    
    @Published public var characters: [Character] = []
    @Published public var images: [String: UIImage?] = [:]
    
    private let characterLoader: CharacterLoader
    private let imageLoader: ImageLoader
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    public init(characterLoader: CharacterLoader,
                imageLoader: ImageLoader) {
        self.characterLoader = characterLoader
        self.imageLoader = imageLoader
    }
    
    public func loadCharacters() {
        characterLoader.loadCharacters()
            .receive(on: RunLoop.main)
            .replaceError(with: [])
            .assign(to: &$characters)
    }
    
    public func loadImage(name: String, forUrl url: URL) {
        imageLoader.load(url: url)
            .receive(on: RunLoop.main)
            .map { UIImage(data: $0) }
            .replaceError(with: UIImage(systemName: "heart"))
            .replaceEmpty(with: UIImage(systemName: "book"))
            .sink { [weak self] image in
                self?.images[name] = image
            }.store(in: &cancellableSet)
    }
}

public struct HomeView: View {
    
    @ObservedObject public var viewModel: HomeViewModel
    
    public init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(viewModel.characters, id: \.name) { character in
                    
                    VStack {
                        Text(character.name)
                        Image(uiImage: (viewModel.images[character.name] ?? UIImage()) ?? UIImage())
                            .resizable()
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .frame(width: 200, height: 200)
                            .background(Color.red)
                            .onAppear {
                                viewModel.loadImage(name: character.name,
                                                    forUrl: character.thumbnailURL!)
                            }
                    }
                }
            }
        }
        .frame(height: 150)
        .onAppear {
            viewModel.loadCharacters()
        }
    }
}

//public struct HomeCharacterItem: View {
//
//    @ObservedObject public var viewModel: HomeCharacterItemViewModel
//
//    public var body: some View {
//        VStack {
//            Image(uiImage: viewModel.image ?? UIImage())
//                .frame(width: 200, height: 200)
//        }
//    }
//}
//
//public class HomeCharacterItemViewModel: ObservableObject {
//    @Published var name: String = ""
//    @Published var image: UIImage? = nil
//
//    private let imageLoader: ImageLoader
//
//    public init(imageLoader: ImageLoader) {
//        self.imageLoader = imageLoader
//    }
//
//    func loadImage(url: URL) {
//        imageLoader.load(url: url)
//            .receive(on: RunLoop.main)
//            .map { UIImage(data: $0) }
//            .replaceError(with: nil)
//            .assign(to: &$image)
//    }
//}
