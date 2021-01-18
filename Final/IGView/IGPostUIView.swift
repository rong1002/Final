//
//  IGPostUIView.swift
//  Final
//
//  Created by Lin Bo Rong on 2020/12/31.
//

import SwiftUI
import SDWebImageSwiftUI
import AVKit

struct IGPostUIView: View {
    @State private var showingSheet = false
    @State private var scale: CGFloat = 1
    @State var duration: Double = 1
    
    var profilePicUrlHd: String
    var username: String
    var isVerified: Bool
    var __typename : String
    var shortcode : String
    var text : String
    var display_url : String
    var edge_media_to_comment : Int
    var edge_liked_by : Int
        
    var body: some View {
        ScrollView(.vertical){
            VStack(alignment: .leading, spacing: 10){
                HStack(alignment: .center, spacing: 10){
                    ZStack{
                        Circle()
                            .fill(LinearGradient(gradient: Gradient(colors: [Color.init(red: 74/255, green: 55/255, blue: 222/255), Color.init(red: 244/255, green: 191/255, blue: 102/255)]), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1)))
                            .frame(width:UIScreen.main.bounds.width/10+3,height:UIScreen.main.bounds.width/10+3)
                        WebImage(url: URL(string: profilePicUrlHd)!)
                            .resizable()
                            .scaledToFit()
                            .frame(width:UIScreen.main.bounds.width/10,height: UIScreen.main.bounds.width/10)
                            .cornerRadius(UIScreen.main.bounds.width/10)
                    }
                    HStack(alignment: .center, spacing: 5){
                        Text(username)
                            .fontWeight(.bold)
                            .font(.system(size: 15))
                        if isVerified == true{
                            Image("verified")
                                .resizable()
                                .scaledToFit()
                                .frame(width:UIScreen.main.bounds.width/25,height: UIScreen.main.bounds.width/25)
                        }
                    }
                    Spacer()
                }
                .padding(.horizontal)
            }
            .padding(.vertical)

            WebImage(url: URL(string: display_url)!)
                .resizable()
                .scaledToFit()
                .frame(width:UIScreen.main.bounds.width)
                .animation(.easeInOut(duration: duration))
                .scaleEffect(scale)
                .gesture(MagnificationGesture()
                            .onChanged { value in
                                scale = value.magnitude
                            })
            HStack(spacing: 20){
                Image("liked")
                    .resizable()
                    .scaledToFit()
                    .frame(width:UIScreen.main.bounds.width/15)
                Image("comment")
                    .resizable()
                    .scaledToFit()
                    .frame(width:UIScreen.main.bounds.width/15)
                Button(action: {
                    self.showingSheet = true
                }) {
                    Image("send")
                        .resizable()
                        .scaledToFit()
                        .frame(width:UIScreen.main.bounds.width/15)
                }
                .sheet(isPresented: $showingSheet,
                       content: {
                        ActivityView(activityItems: [URL(string: display_url)!], applicationActivities: nil) })
                Spacer()
                Image("bookmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width:UIScreen.main.bounds.width/15)
            }.padding(.horizontal)

            HStack{
                VStack(alignment: .leading, spacing: 5){
                    Text("\(edge_liked_by)個讚")
                        .fontWeight(.bold)
                        .font(.system(size: 15))
                    Text(text)
                        .font(.system(size: 15))
                    Text("\(edge_media_to_comment)則留言")
                        .foregroundColor(Color(.gray))
                        .font(.system(size: 15))
                }
                Spacer()
            }.padding(.horizontal)
            
        }
    }
}

struct IGPostUIView_Previews: PreviewProvider {
    static var previews: some View {
        IGPostUIView(profilePicUrlHd: "", username: "", isVerified: true, __typename: "", shortcode: "", text: "", display_url: "", edge_media_to_comment: 0, edge_liked_by: 0)
    }
}

struct ActivityView: UIViewControllerRepresentable {

    let activityItems: [Any]
    let applicationActivities: [UIActivity]?

    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityView>) -> UIActivityViewController {
        return UIActivityViewController(activityItems: activityItems,
                                        applicationActivities: applicationActivities)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController,
                                context: UIViewControllerRepresentableContext<ActivityView>) {

    }
}
