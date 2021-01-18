//
//  YoutubeUIView.swift
//  Final
//
//  Created by Lin Bo Rong on 2021/1/6.
//
import SwiftUI
import SwiftyJSON
import SDWebImageSwiftUI
import SwiftUIPullToRefresh

struct youtubeUIView: View {
    @State private var selectedIndex = 0
    @State var showRefreshView = false

    var body: some View {
        RefreshableList(showRefreshView: $showRefreshView, action:{
            // Remember to set the showRefreshView to false
            self.showRefreshView = false
        }){
            ScrollView(.vertical){
                VStack{
                    youtubeProFile()
                    YoutubePicker(selectedIndex: $selectedIndex)
                    youtubeMovie(selectedIndex: $selectedIndex)
                }
                .navigationBarItems(leading: HStack{Image("Youtube-Logo").resizable().scaledToFit().frame(width:UIScreen.main.bounds.width/4)})
                .navigationBarTitle("Youtube",displayMode: .inline)
            }
        }

    }
}

struct youtubeProFile: View{
    @ObservedObject var channels = getyoutubeChannelData()
    
    var body: some View {
        VStack{
            channels.data.map { (user) in
                ForEach(user.items) { channel  in
                    VStack{
                        WebImage(url: URL(string: channel.brandingSettings.image.bannerExternalUrl )!)
                            .resizable()
                            .scaledToFit()
                            .frame(minWidth: 0, maxWidth: .infinity)
                        HStack(alignment: .center, spacing: 20){
                            ZStack{
                                Circle()
                                    .fill(LinearGradient(gradient: Gradient(colors: [Color.init(red: 102/255, green: 191/255, blue: 244/255), Color.init(red: 74/255, green: 55/255, blue: 222/255)]), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1)))
                                    .frame(width:UIScreen.main.bounds.width/5+8.5,height:UIScreen.main.bounds.width/5+8.5)
                                WebImage(url: URL(string: channel.snippet.thumbnails.high.url)!)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:UIScreen.main.bounds.width/5,height: UIScreen.main.bounds.width/5)
                                    .cornerRadius(UIScreen.main.bounds.width/5)
                            }
                            VStack(alignment: .leading, spacing: 5){
                                Text(channel.snippet.title)
                                    .fontWeight(.bold)
                                    .font(.system(size: 20))
                                Text(channel.statistics.subscriberCount + " 位訂閱者")
                                    .foregroundColor(Color(.gray))
                                    .font(.system(size: 15))
                            }
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        .onAppear(perform: {
            channels.fetchYT()
        })
    }
}
struct YoutubePicker: View{
    var segmentedControl = ["影片","簡介"]
    @Binding var selectedIndex : Int
    var body: some View {
        Picker(selection: $selectedIndex, label: Text("")) {
            ForEach(0..<segmentedControl.count) { (index) in
                Text(self.segmentedControl[index])
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .background(LinearGradient(gradient: Gradient(colors: [Color.init(red: 102/255, green: 191/255, blue: 244/255), Color.init(red: 74/255, green: 55/255, blue: 222/255)]), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1)))
    }
}

struct youtubeMovie: View{
    @Binding var selectedIndex : Int
    @ObservedObject var results = getyoutubePlaylistData()
    @ObservedObject var channels = getyoutubeChannelData()

    var body: some View {
        if selectedIndex == 0 {
            VStack{
                results.data.map { (user) in
                    ForEach(user.items) { (result)  in
                        HStack(alignment: .top, spacing: 10){
                            WebImage(url: URL(string: result.snippet.thumbnails.high.url)!)
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFit()
                                .frame(width:UIScreen.main.bounds.width/3)
                            NavigationLink(destination: youtubeVideoUIView(videoId: result.snippet.resourceId.videoId)){
                                VStack(alignment: .leading){
                                    Text(result.snippet.title)
                                        .fontWeight(.medium)
                                        .font(.system(size: 15))
                                    Text(result.snippet.channelTitle)
                                        .foregroundColor(Color(.gray))
                                        .font(.system(size: 13))
                                    HStack{
                                        Text(result.snippet.publishedAt, style: .date)
                                            .foregroundColor(Color(.gray))
                                            .font(.system(size: 13))
                                        Text(result.snippet.publishedAt, style: .time)
                                            .foregroundColor(Color(.gray))
                                            .font(.system(size: 13))
                                    }
                                }
                                Spacer()
                            }.padding(.horizontal)
                        }
                    }
                }
            }
            .onAppear(perform: {
                results.fetchYT()
            })
        }
        else if selectedIndex == 1 {
            VStack{
                channels.data.map { (user) in
                    ForEach(user.items) { channel  in
                        HStack{
                            VStack(alignment: .leading, spacing: 10){
                                Text(channel.snippet.description)
                                    .font(.system(size: 13))
                                HStack{
                                    Text(channel.snippet.publishedAt, style: .date)
                                        .foregroundColor(Color(.gray))
                                        .font(.system(size: 13))
                                    Text(channel.snippet.publishedAt, style: .time)
                                        .foregroundColor(Color(.gray))
                                        .font(.system(size: 13))
                                }
                                HStack(spacing:1){
                                    Text("觀看次數：")
                                        .foregroundColor(Color(.gray))
                                        .font(.system(size: 13))
                                    Text(channel.statistics.viewCount)
                                        .foregroundColor(Color(.gray))
                                        .fontWeight(.bold)
                                        .font(.system(size: 13))
                                }
                                Text(channel.statistics.videoCount + "部影片")
                                    .foregroundColor(Color(.gray))
                                    .font(.system(size: 13))
                            }
                            Spacer()
                        }.padding(.horizontal)
                    }
                }
            }
            .onAppear(perform: {
                channels.fetchYT()
            })
        }
    }
}


struct youtubeUIView_Previews: PreviewProvider {
    static var previews: some View {
        youtubeUIView()
    }
}

class getyoutubePlaylistData: ObservableObject {
    @Published var data: YTPlaylistData?
    func fetchYT() {
        if let urlStr = "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet,contentDetails,status&playlistId=UUsLWG2t7n9LFsvH0wR2rtpw&key=AIzaSyA3aE1DeZN02R_cSphit-dMzt6r7aBZtwY&maxResults=50".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { (data, response , error) in
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                if let data = data {
                    do {
                        let json = try decoder.decode(YTPlaylistData.self, from: data)
                        DispatchQueue.main.async {
                            self.data = json
                        }
                    } catch  {
                        print(error)
                    }
                }
                
            }.resume()
            
        }
        
    }
}

class getyoutubeChannelData: ObservableObject {
    @Published var data: YTChannelData?
    func fetchYT() {
        if let urlStr = "https://www.googleapis.com/youtube/v3/channels?part=brandingSettings,snippet,contentDetails,statistics,status&id=UCsLWG2t7n9LFsvH0wR2rtpw&key=AIzaSyA3aE1DeZN02R_cSphit-dMzt6r7aBZtwY".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { (data, response , error) in
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                if let data = data {
                    do {
                        let json = try decoder.decode(YTChannelData.self, from: data)
                        DispatchQueue.main.async {
                            self.data = json
                        }
                    } catch  {
                        print(error)
                    }
                }
                
            }.resume()
            
        }
        
    }
}


//上傳影片清單的 playlists ID
//https://www.googleapis.com/youtube/v3/channels?part=contentDetails&id=UCsLWG2t7n9LFsvH0wR2rtpw&key=AIzaSyA3aE1DeZN02R_cSphit-dMzt6r7aBZtwY

// playlist 的影片清單
//https://www.googleapis.com/youtube/v3/playlistItems?part=snippet,contentDetails,status&playlistId=UUsLWG2t7n9LFsvH0wR2rtpw&key=AIzaSyA3aE1DeZN02R_cSphit-dMzt6r7aBZtwY&maxResults=50

//取得下一頁的影片
//https://www.googleapis.com/youtube/v3/playlistItems?part=snippet,contentDetails,status&playlistId=UUsLWG2t7n9LFsvH0wR2rtpw&key=AIzaSyA3aE1DeZN02R_cSphit-dMzt6r7aBZtwY&maxResults=50&pageToken=CDIQAA
