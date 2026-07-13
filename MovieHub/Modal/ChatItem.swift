//
//  ChatItem.swift
//  MovieHub
//
//  Created by Prem Kumar Gundu on 7/13/26.
//

// A single entry in the movie chat conversation
enum ChatItem {
    case userMessage(String)
    case botMessage(String)
    case typing
    case movie(Movie)
}
