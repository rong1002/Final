//
//  G_E_M.swift
//  G.E.M
//
//  Created by Lin Bo Rong on 2021/1/12.
//

import WidgetKit
import SwiftUI
import Intents
import SafariServices

struct Provider: IntentTimelineProvider {
    var results = getinstagramProfileData()
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), username: "Username", isVerified: true, edgeFollowedBy: 0, edgeFollow: 0, edgeOwnerToTimelineMedia: 0, fullName: "G_E_M", biography: "萬國覺醒", externalUrl: "https://www.instagram.com/gem0816/?__a=1")
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), username: "Username", isVerified: true, edgeFollowedBy: 0, edgeFollow: 0, edgeOwnerToTimelineMedia: 0, fullName: "G_E_M", biography: "萬國覺醒", externalUrl: "https://www.instagram.com/gem0816/?__a=1")
        completion(entry)
    }
    
    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        results.fetchIG{ result in
            let entries = [SimpleEntry(date: Date(), username: result.username, isVerified: result.isVerified, edgeFollowedBy: result.edgeFollowedBy.count, edgeFollow: result.edgeFollow.count, edgeOwnerToTimelineMedia: result.edgeOwnerToTimelineMedia.count, fullName: result.fullName, biography: result.biography, externalUrl: result.externalUrl)]
            
            let timeline = Timeline(entries: entries, policy: .never)
            completion(timeline)
        }
    }
}

struct SimpleEntry: TimelineEntry {
        let date: Date
    let username: String
    let isVerified: Bool
    let edgeFollowedBy : Int
    let edgeFollow : Int
    let edgeOwnerToTimelineMedia : Int
    let fullName : String
    let biography : String
    let externalUrl : String
}

struct G_E_MEntryView : View {
    @Environment(\.widgetFamily) private var widgetFamily
    var entry: Provider.Entry

    var body: some View {
        if widgetFamily == .systemSmall {
            WidgetSmall()
        } else if widgetFamily == .systemMedium{
            WidgetMedium(entry: entry)
        }else if widgetFamily == .systemLarge{
            WidgetLarge(entry: entry)
        }
    }
}

struct WidgetSmall: View {
    var body: some View {
        ZStack{
            Circle()
                .fill(LinearGradient(gradient: Gradient(colors: [Color.init(red: 102/255, green: 191/255, blue: 244/255), Color.init(red: 74/255, green: 55/255, blue: 222/255)]), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1)))
                .frame(width:UIScreen.main.bounds.width/5+8.5,height:UIScreen.main.bounds.height/5+8.5)
            Image("G.E.M")
                .resizable()
                .scaledToFit()
                .frame(width:UIScreen.main.bounds.width/5,height: UIScreen.main.bounds.height/5)
                .clipShape(Circle())
        }
    }
}

struct WidgetMedium : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack{
            HStack(alignment: .center, spacing: 30){
                ZStack{
                    Circle()
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.init(red: 102/255, green: 191/255, blue: 244/255), Color.init(red: 74/255, green: 55/255, blue: 222/255)]), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1)))
                        .frame(width:UIScreen.main.bounds.width/5+8.5,height:UIScreen.main.bounds.height/5+8.5)
                    Image("G.E.M")
                        .resizable()
                        .scaledToFit()
                        .frame(width:UIScreen.main.bounds.width/5,height: UIScreen.main.bounds.height/5)
                        .clipShape(Circle())
                }
                VStack(alignment: .leading, spacing: 10){
                    HStack(alignment: .center, spacing: 5){
                        Text(entry.username)
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                        if entry.isVerified == true{
                            Image("verified")
                                .resizable()
                                .scaledToFit()
                                .frame(width:UIScreen.main.bounds.width/25,height: UIScreen.main.bounds.width/25)
                        }
                    }
                    HStack(spacing: 20){
                        VStack(alignment: .center){
                            Text(String(entry.edgeOwnerToTimelineMedia))
                                .fontWeight(.bold)
                                .font(.system(size: 15))
                            Text("貼文數")
                                .font(.system(size: 13))
                        }
                        VStack(alignment: .center){
                            Text(String(entry.edgeFollowedBy))
                                .fontWeight(.bold)
                                .font(.system(size: 15))
                            Text("粉絲人數")
                                .font(.system(size: 13))
                        }
                        VStack(alignment: .center){
                            Text(String(entry.edgeFollow))
                                .fontWeight(.bold)
                                .font(.system(size: 15))
                            Text("追蹤中")
                                .font(.system(size: 13))
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}
struct WidgetLarge : View {
    var entry: Provider.Entry
    @State private var show = false

    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            HStack(alignment: .center, spacing: 30){
                ZStack{
                    Circle()
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.init(red: 102/255, green: 191/255, blue: 244/255), Color.init(red: 74/255, green: 55/255, blue: 222/255)]), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1)))
                        .frame(width:UIScreen.main.bounds.width/5+8.5,height:UIScreen.main.bounds.height/5+8.5)
                    Image("G.E.M")
                        .resizable()
                        .scaledToFit()
                        .frame(width:UIScreen.main.bounds.width/5,height: UIScreen.main.bounds.height/5)
                        .clipShape(Circle())
                }
                VStack(alignment: .leading, spacing: 10){
                    HStack(alignment: .center, spacing: 5){
                        Text(entry.username)
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                        if entry.isVerified == true{
                            Image("verified")
                                .resizable()
                                .scaledToFit()
                                .frame(width:UIScreen.main.bounds.width/25,height: UIScreen.main.bounds.width/25)
                        }
                    }
                    HStack(spacing: 20){
                        VStack(alignment: .center){
                            Text(String(entry.edgeOwnerToTimelineMedia))
                                .fontWeight(.bold)
                                .font(.system(size: 15))
                            Text("貼文數")
                                .font(.system(size: 13))
                        }
                        VStack(alignment: .center){
                            Text(String(entry.edgeFollowedBy))
                                .fontWeight(.bold)
                                .font(.system(size: 15))
                            Text("粉絲人數")
                                .font(.system(size: 13))
                        }
                        VStack(alignment: .center){
                            Text(String(entry.edgeFollow))
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
                Text(entry.fullName)
                    .fontWeight(.bold)
                Text(entry.biography)
                    .font(.system(size: 13))
                Text(entry.externalUrl)
                    .font(.system(size: 13))
                    .foregroundColor(Color(red: 0.108, green: 0.586, blue: 0.881))
                    .onTapGesture {
                        show.toggle()
                        
                    }.sheet(isPresented: self.$show){
                        SafariView(url: URL(string: entry.externalUrl)!)
                    }
            }.padding(.horizontal)
        }
    }
}
@main
struct G_E_M: Widget {
    let kind: String = "G_E_M"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            G_E_MEntryView(entry: entry)
        }
        .configurationDisplayName("G.E.M")
        .description("G.E.M 小資訊")
    }
}


struct IGProfileData: Decodable {
    var graphql: GraphqlIGProfileData
}
struct GraphqlIGProfileData: Decodable{
    var user: UserIGProfileData
}
struct UserIGProfileData : Decodable{
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

class getinstagramProfileData {
    
    func fetchIG(completion: @escaping (UserIGProfileData) -> Void) {
        if let urlStr = "https://www.instagram.com/gem0816/?__a=1".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { (data, response , error) in
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                if let data = data {
                    do {
                        let json = try decoder.decode(IGProfileData.self, from: data)
                        completion(json.graphql.user)
//                            print(json.graphql.user.username)
//                        DispatchQueue.main.async {
//                            self.data = json.graphql.user
//                        }
                    } catch  {
                        print(error)
                    }
                }
                
            }.resume()
            
        }
        
    }
}
struct SafariView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> SFSafariViewController {
         SFSafariViewController(url: url)
    }
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
            
    }
    
    let url: URL
}
