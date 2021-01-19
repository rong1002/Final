//
//  YoutubeData.swift
//  Final
//
//  Created by Lin Bo Rong on 2021/1/6.
//

import SwiftUI
import Foundation
import Combine

struct YTPlaylistData: Codable , Identifiable{
    let id = UUID()
    var items: [ItemsYTPlaylistData]
}

struct ItemsYTPlaylistData: Codable, Identifiable{
    let id : String
    var snippet: Snippet
}
struct Snippet: Codable, Identifiable{
    let id = UUID()
    var title : String
    var thumbnails: Thumbnails
    var channelTitle: String
    var publishedAt: Date
    var resourceId: ResourceId
}
struct Thumbnails: Codable {
    var high: Url
}
struct Url: Codable {
    var url: String
}
struct ResourceId: Codable {
    var videoId: String
}


struct YTChannelData: Codable {
    var items: [ItemsYTChannelData]
}
struct ItemsYTChannelData: Codable, Identifiable{
    let id : String
    var snippet: SnippetChannel
    var statistics: Statistics
    var brandingSettings: BrandingSettings
}
struct SnippetChannel: Codable{
    var publishedAt : Date
    var title :String
    var description : String
    var thumbnails: ThumbnailsSnippetChannel
    
}
struct ThumbnailsSnippetChannel: Codable {
    var high: highThumbnailsSnippetChannel
}
struct highThumbnailsSnippetChannel: Codable {
    var url: String
}
struct Statistics: Codable {
    var subscriberCount: String
    var viewCount: String
    var videoCount: String
}
struct BrandingSettings: Codable {
    var image: ImageBrandingSettings
}
struct ImageBrandingSettings: Codable{
    var bannerExternalUrl: String
}

//個人資料
//https://www.googleapis.com/youtube/v3/channels?part=brandingSettings,snippet,contentDetails,statistics,status&id=UCsLWG2t7n9LFsvH0wR2rtpw&key=AIzaSyA3aE1DeZN02R_cSphit-dMzt6r7aBZtwY

//上傳影片清單的 playlists ID
//https://www.googleapis.com/youtube/v3/channels?part=contentDetails&id=UCsLWG2t7n9LFsvH0wR2rtpw&key=AIzaSyA3aE1DeZN02R_cSphit-dMzt6r7aBZtwY

// playlist 的影片清單
//https://www.googleapis.com/youtube/v3/playlistItems?part=snippet,contentDetails,status&playlistId=UUsLWG2t7n9LFsvH0wR2rtpw&key=AIzaSyA3aE1DeZN02R_cSphit-dMzt6r7aBZtwY&maxResults=50

//取得下一頁的影片
//https://www.googleapis.com/youtube/v3/playlistItems?part=snippet,contentDetails,status&playlistId=UUsLWG2t7n9LFsvH0wR2rtpw&key=AIzaSyA3aE1DeZN02R_cSphit-dMzt6r7aBZtwY&maxResults=50&pageToken=CDIQAA
