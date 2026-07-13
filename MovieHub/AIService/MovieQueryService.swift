//
//  MovieQueryService.swift
//  MovieHub
//
//  Created by Prem Kumar Gundu on 7/13/26.
//

import Foundation
import FoundationModels

final class MovieQueryService {

    // Keeps a single session alive so follow-up messages retain the conversation context
    private let session: LanguageModelSession

    init() {
        session = LanguageModelSession(instructions: """
            You convert a user's natural language movie requests into structured movie search filters.
            This is an ongoing conversation, follow-up messages refine or change the earlier request.
            Always produce the complete set of filters for the latest request, carrying over earlier
            filters that still apply.
            Only extract filters the user explicitly mentions or clearly implies.
            Do not invent genres, years, or ratings that are not part of the request.
            """)
    }

    // The on-device model needs Apple Intelligence to be supported and turned on
    static var isModelAvailable: Bool {
        if case .available = SystemLanguageModel.default.availability {
            return true
        }
        return false
    }

    // Loads the model resources ahead of the first message to reduce latency
    func prewarm() {
        session.prewarm()
    }

    func extractFilters(from userInput: String) async throws -> MovieDiscoveryFilters {

        let response = try await session.respond(
            to: "Extract the movie search filters from this request: \(userInput)",
            generating: MovieDiscoveryFilters.self
        )

        return response.content
    }
}
