//
//  IGUIView.swift
//  FinalProject
//
//  Created by Lin Bo Rong on 2020/12/27.
//

import SwiftUI
import SDWebImageSwiftUI

struct IGUIView: View {
    @State var showRefreshView = false

    var body: some View {
//        RefreshableList(showRefreshView: $showRefreshView, action:{
//            // Remember to set the showRefreshView to false
//            self.showRefreshView = false
//        }){
            IGProfileDataView()
//        }
            
    }
}

struct IGProfileDataView: View {
    @StateObject var results = getinstagramProfileData()
    @State private var show = false
    
    var body: some View {
        ScrollView(.vertical){
            VStack(alignment: .leading, spacing: 10){
                HStack(alignment: .center, spacing: 30){
                    ZStack{
                        Circle()
                            .fill(LinearGradient(gradient: Gradient(colors: [Color.init(red: 102/255, green: 191/255, blue: 244/255), Color.init(red: 74/255, green: 55/255, blue: 222/255)]), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1)))
                            .frame(width:UIScreen.main.bounds.width/5+8.5,height:UIScreen.main.bounds.width/5+8.5)
                        WebImage(url: URL(string: results.data?.profilePicUrlHd ?? "https://picsum.photos/200/300")!)
                            .resizable()
                            .scaledToFit()
                            .frame(width:UIScreen.main.bounds.width/5,height: UIScreen.main.bounds.width/5)
                            .cornerRadius(UIScreen.main.bounds.width/5)
                    }
                    VStack(alignment: .leading, spacing: 10){
                        HStack(alignment: .center, spacing: 5){
                            Text(results.data?.username ?? "")
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                            if results.data?.isVerified == true{
                                Image("verified")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:UIScreen.main.bounds.width/25,height: UIScreen.main.bounds.width/25)
                            }
                        }
                        HStack(spacing: 20){
                            VStack(alignment: .center){
                                Text(String(results.data?.edgeOwnerToTimelineMedia.count ?? 0))
                                    .fontWeight(.bold)
                                    .font(.system(size: 15))
                                Text("貼文數")
                                    .font(.system(size: 13))
                            }
                            VStack(alignment: .center){
                                Text(String(results.data?.edgeFollowedBy.count ?? 0))
                                    .fontWeight(.bold)
                                    .font(.system(size: 15))
                                Text("粉絲人數")
                                    .font(.system(size: 13))
                            }
                            VStack(alignment: .center){
                                Text(String(results.data?.edgeFollow.count ?? 0))
                                    .fontWeight(.bold)
                                    .font(.system(size: 15))
                                Text("追蹤中")
                                    .font(.system(size: 13))
                            }
                        }
                    }
                }
                .padding(.horizontal)
                VStack(alignment: .leading, spacing: 5){
                    Text(results.data?.fullName ?? "")
                        .fontWeight(.bold)
                    Text(results.data?.biography ?? "")
                        .font(.system(size: 13))
                    Text(results.data?.externalUrl ?? "")
                        .font(.system(size: 13))
                        .foregroundColor(Color(red: 0.108, green: 0.586, blue: 0.881))
                        .onTapGesture {
                            show.toggle()
                            
                        }.sheet(isPresented: self.$show){
                            SafariView(url: URL(string: results.data?.externalUrl ?? "https://youtu.be/OiN5f7DT1Og")!)
                        }
                }.padding(.horizontal)
            }
            .padding(.vertical)
            .onAppear(perform: {
                results.fetchIG()
            })
            
            IGDataView()

        }
        
    }
}

struct IGDataView: View {
    @StateObject var posts = getinstagramPostData()

    var body: some View {

        ScrollView(.vertical) {
            let columns = [
                GridItem(),
                GridItem(),
                GridItem()
            ]
            LazyVGrid(columns: columns) {
                posts.post.map { (user) in
                    ForEach(user.edge_owner_to_timeline_media.edges) { (edge)  in
                        ForEach(edge.node.edge_media_to_caption.edges){ (nodes) in
                            NavigationLink(destination: IGPostUIView(profilePicUrlHd: user.profile_pic_url_hd, username: user.username, isVerified: user.is_verified, __typename: edge.node.__typename, shortcode: edge.node.shortcode, text: nodes.node.text, display_url: edge.node.display_url, edge_media_to_comment: edge.node.edge_media_to_comment.count, edge_liked_by: edge.node.edge_liked_by.count)) {
                                
                                VStack{
                                    AnimatedImage(url: URL(string: edge.node.thumbnail_src)!)
                                        .renderingMode(.original)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width:UIScreen.main.bounds.width/3,height: UIScreen.main.bounds.width/3)
                                        .contextMenu {
                                            Button(action: {
                                                SDWebImageDownloader()
                                                    .downloadImage(with: URL(string: edge.node.thumbnail_src)!) { (image, _, _, _) in
                                                        DispatchQueue.main.async{
                                                            UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
                                                        }
                                                }
                                            }) {
                                                HStack{
                                                    Text("儲存")
                                                    Spacer()
                                                    Image(systemName: "square.and.arrow.down.fill")
                                                }
                                                .foregroundColor(.black)
                                            }
                                        }
                                }
                            }
                        }
                    }
                }
            }
            .onAppear(perform: {
                if posts.post == nil {
                    posts.fetchIG()
                    
                }
            })
        }
    }
}


class getinstagramProfileData : ObservableObject {
    @Published var data: UserIGProfileData?
    
    func fetchIG() {
        if let urlStr = "https://www.instagram.com/gem0816/?__a=1".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { (data, response , error) in
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                if let data = data {
                    do {
                        let json = try decoder.decode(IGProfileData.self, from: data)
//                            print(json.graphql.user.username)
                        DispatchQueue.main.async {
                            self.data = json.graphql.user
                        }
                    } catch  {
                        print(error)
                    }
                }
                
            }.resume()
            
        }
        
    }
}

class getinstagramPostData: ObservableObject {
    @Published var post: UserIGPostData?
    
    func fetchIG() {
        if let urlStr = "https://www.instagram.com/gem0816/?__a=1".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { (data, response , error) in
                let decoder = JSONDecoder()
                if let data = data {
                    do {
                        let json = try decoder.decode(IGPostData.self, from: data)
                        DispatchQueue.main.async {
                        self.post = json.graphql.user
                        }
                    } catch  {
                        print(error)
                    }
                }
                
            }.resume()
            
        }
        
    }
}

struct IGUIView_Previews: PreviewProvider {
    static var previews: some View {
        IGUIView()
    }
}
