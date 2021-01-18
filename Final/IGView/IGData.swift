//
//  IGData.swift
//  FinalProject
//
//  Created by Lin Bo Rong on 2020/12/27.
//

import SwiftUI
struct IGProfileData: Codable {
    var graphql: GraphqlIGProfileData
}
struct GraphqlIGProfileData: Codable{
    var user: UserIGProfileData
}
struct UserIGProfileData : Codable{
    var id: String
    var profilePicUrlHd: String
    var username : String
    var isVerified : Bool
    var edgeFollowedBy : edgeFollowedByIGProfileData
    var edgeFollow : edgeFollowIGProfileData
    var fullName : String
    var biography : String
    var externalUrl : String
    var edgeOwnerToTimelineMedia : edgeOwnerToTimelineMediaIGProfileData
    struct edgeFollowedByIGProfileData: Codable{
        var count: Int
    }
    struct edgeFollowIGProfileData: Codable {
        var count: Int
    }
    struct edgeOwnerToTimelineMediaIGProfileData: Codable {
        var count: Int
        
    }
}

struct IGPostData: Codable, Identifiable{
    let id = UUID()
    var graphql: GraphqlIGPostData
}
struct GraphqlIGPostData: Codable, Identifiable{
    let id = UUID()
    var user: UserIGPostData
}
struct UserIGPostData: Codable, Identifiable{
    let id = UUID()
    var edge_owner_to_timeline_media: EdgeOwnerToTimelineMediaIGPostData
    var profile_pic_url_hd: String
    var username : String
    var is_verified : Bool
}

struct EdgeOwnerToTimelineMediaIGPostData: Codable {
    let edges: [EdgeEdgeOwnerToTimelineMediaIGPostData]
    
    struct EdgeEdgeOwnerToTimelineMediaIGPostData: Codable, Identifiable {
        let node: NodeEdgeOwnerToTimelineMediaIGPostData
        let id = UUID()
    }
    
    struct NodeEdgeOwnerToTimelineMediaIGPostData: Codable {
        var id : String
        var display_url : String
        var edge_media_to_caption : edgesedge_media_to_caption
        var edge_media_to_comment : edge_media_to_commentInstagramPostData
        var edge_liked_by : edge_liked_byInstagramPostData
        var thumbnail_src : String
        var __typename : String
        var shortcode : String
        
        struct edgesedge_media_to_caption: Codable {
            var edges: [nodeedge_media_to_caption]
        }
        struct nodeedge_media_to_caption: Codable, Identifiable {
            var node: textedge_media_to_caption
            let id = UUID()

        }
        struct textedge_media_to_caption: Codable {
            var text: String
        }

        struct edge_media_to_commentInstagramPostData: Codable {
            var count: Int
        }
        struct edge_liked_byInstagramPostData: Codable {
            var count: Int
        }
    }
}
