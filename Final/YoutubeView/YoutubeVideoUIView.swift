//
//  YoutubeVideoUIView.swift
//  Final
//
//  Created by Lin Bo Rong on 2021/1/6.
//
import SwiftUI
import SwiftyJSON
import SDWebImageSwiftUI
import WebKit
struct youtubeVideoUIView: View {
    var videoId : String
    var body: some View {
            wkWebView(url: "https://www.youtube.com/watch?v="+videoId)
                .frame(width: UIScreen.main.bounds.width)
        
    }
}

struct youtubeVideoUIView_Previews: PreviewProvider {
    static var previews: some View {
        youtubeVideoUIView(videoId: "")
    }
}

struct wkWebView : UIViewRepresentable{
    var url : String
    func makeUIView(context: UIViewRepresentableContext<wkWebView>) -> WKWebView{
        let webview = WKWebView()
        webview.load(URLRequest(url: URL(string: url)!))
        return webview
    }
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<wkWebView>) {
        
    }
}
/*
 https://www.googleapis.com/youtube/v3/videos?id=Fc2qWBIToKU&part=snippet&key=AIzaSyA2zjS7yzt4mgfHruaa-pnWCGi9xHf5KTw
 */
