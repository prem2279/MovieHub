//
//  MovieChatViewModel.swift
//  MovieHub
//
//  Created by Prem Kumar Gundu on 7/13/26.
//

import Foundation

// MARK: - Movie Chat Delegate Protocol

protocol MovieChatDelegate: AnyObject {
    func getItemsCount() -> Int
    func getItem(at index: Int) -> ChatItem?
    func prewarm()
    func send(userInput: String, onUpdate: @escaping () -> Void)
}

class MovieChatViewModel {

    // MARK: - Properties

    private var items: [ChatItem] = [
        .botMessage("Hi! I'm your movie assistant 🎬\nAsk me things like \"highly rated 90s action movies\" or just a movie name.")
    ]
    private var networkInstance: NetworkProtocol
    private let queryService = MovieQueryService()

    init(networkInstance: NetworkProtocol = NetworkManager.shared) {
        self.networkInstance = networkInstance
    }

    // MARK: - Methods

    private func removeTypingIndicator() {
        if case .typing = items.last {
            items.removeLast()
        }
    }

    private func fetchMovies(endpoint: APIEndPoints, replyPrefix: String, onUpdate: @escaping () -> Void) {
        networkInstance.request(endpoint: endpoint) {
            [weak self] (result: NetworkState<Movies>) in
            guard let self else { return }
            switch result {
            case .successful(let data):
                self.removeTypingIndicator()
                if data.results.isEmpty {
                    self.items.append(.botMessage("I couldn't find anything for \(replyPrefix). Try rephrasing your request."))
                } else {
                    self.items.append(.botMessage("Here's what I found for \(replyPrefix):"))
                    self.items.append(contentsOf: data.results.prefix(10).map { .movie($0) })
                }
                onUpdate()
            case .failure(let error):
                self.removeTypingIndicator()
                self.items.append(.botMessage("Something went wrong: \(error.rawValue). Please try again."))
                onUpdate()
            case .loading:
                break
            }
        }
    }
}

// MARK: - Chat Handling

extension MovieChatViewModel: MovieChatDelegate {

    func prewarm() {
        guard MovieQueryService.isModelAvailable else { return }
        queryService.prewarm()
    }

    func send(userInput: String, onUpdate: @escaping () -> Void) {

        items.append(.userMessage(userInput))
        items.append(.typing)
        onUpdate()

        Task { [weak self] in
            guard let self else { return }

            let endpoint: APIEndPoints
            let replyPrefix: String

            // Uses AFM to build a discover query, falls back to plain TMDB search
            if MovieQueryService.isModelAvailable {
                do {
                    let filters = try await queryService.extractFilters(from: userInput)
                    if let movieTitle = filters.movieTitle, !movieTitle.isEmpty {
                        // The user named a specific movie, search by title instead
                        endpoint = .searchMovies(query: movieTitle)
                    } else {
                        endpoint = .discoverMovies(queryItems: filters.queryItems)
                    }
                    replyPrefix = filters.summary
                } catch {
                    // Surfaces the model failure and still answers with a plain search
                    endpoint = .searchMovies(query: userInput)
                    replyPrefix = "\"\(userInput)\""
                }
            } else {
                endpoint = .searchMovies(query: userInput)
                replyPrefix = "\"\(userInput)\""
            }

            await MainActor.run {
                self.fetchMovies(endpoint: endpoint, replyPrefix: replyPrefix, onUpdate: onUpdate)
            }
        }
    }

    // MARK: - TableView Helpers

    func getItemsCount() -> Int {
        return items.count
    }

    func getItem(at index: Int) -> ChatItem? {

        if items.indices.contains(index) {
            return items[index]
        }

        return nil
    }
}
