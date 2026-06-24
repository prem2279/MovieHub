//
//  MoviesMockData.swift
//  Programatic UI
//
//  Created by Prem Kumar Gundu on 6/23/26.
//
import UIKit

func getMoviesData()->Movies?{
    
    let jsonString = """
    {
      "page": 1,
      "results": [
        {
          "adult": false,
          "backdrop_path": "/6tROOVmV5vRymO2g52aR8kWlfoT.jpg",
          "genre_ids": [10749, 35],
          "id": 1392469,
          "title": "Cocktail 2",
          "original_language": "hi",
          "original_title": "कॉकटेल २",
          "overview": "After a decade together...",
          "popularity": 600.4605,
          "poster_path": "/oIQmtByV1LtEQSwM4EpdLTyoSlM.jpg",
          "release_date": "2026-06-19",
          "softcore": false,
          "video": false,
          "vote_average": 5.7,
          "vote_count": 7
        }
      ],
      "total_pages": 57589,
      "total_results": 1151780
    }
    """

    // Step 1: Convert String → Data
    let data = Data(jsonString.utf8)

    // Step 2: Decode
    do {
        let decoded = try JSONDecoder().decode(Movies.self, from: data)
        return decoded
    } catch {
        print("Decoding failed:", error)
    }
    
    return nil
}


