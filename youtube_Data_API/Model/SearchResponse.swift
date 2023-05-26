//
//  SearchResponse.swift
//  youtube_Data_API
//
//  Created by Calvin Lee on 2023/4/6.
//

import Foundation

struct SearchResponse: Codable {
    let nextPageToken: String
    let items: [Item]

    struct Item: Codable {
        let snippet: Snippet
        
        struct Snippet: Codable {
            let title: String
            let thumbnails: Thumbnail
            let resourceId: ResourceId

            struct Thumbnail: Codable {
                let standard: ThumbnailImage
                //let maxres: ThumbnailImage
                
                struct ThumbnailImage: Codable{
                    let url: URL
                }
            }
            
            struct ResourceId: Codable{
                let videoId: String
            }
        }
    }
}
