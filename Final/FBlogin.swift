//
//  FBlogin.swift
//  Final
//
//  Created by Lin Bo Rong on 2021/1/1.
//

import SwiftUI
import FacebookLogin

struct FBlogin: View {
    @Binding var login: Bool
    @State var showAlert = false
    
    var body: some View {
        ZStack{
            Image("FBBackground")
                .resizable()
                .scaledToFit()
            Button(action: {
                let manager = LoginManager()
                manager.logIn(permissions: [.email]) { (result) in
                    if case LoginResult.success(granted: _, declined: _, token: _) = result {
                        login = true
                        showAlert = true
                        print("login ok")
                    } else {
                        login = false
                        showAlert = false
                        print("login fail")
                    }
                }
                
            }) {
                Image("FBLogin")
                    .resizable()
                    .scaledToFit()
                    .frame(width:UIScreen.main.bounds.width/5,height: UIScreen.main.bounds.width/5)
            }
            .alert(isPresented: $showAlert) { () -> Alert in
                return Alert(title: Text("登入成功"))
            }
        }
    }
}

struct FBFirst:View {
    @State var login = false

    var body: some View{
        NavigationView{
            VStack{
                FBlogin(login: $login)
                if login == true{
                    NavigationLink(destination: FBSecond()){
                        Text("Enter")
                    }
                }
                else{
                    Text("請先登入成功")
                }
            }
            .navigationBarTitle("Facebook登入",displayMode: .inline)
            
        }
    }
}

struct FBSecond:View{
    @State var  peopledata=Peopledata()
    @State var photoData = PhotoData()
    
    var body: some View{
        TabView {
            IGUIView().tabItem {
                Text("Instagram")
                Image(systemName: "camera.fill")
            }
            youtubeUIView()
                .tabItem {
                    Text("Youtube")
                    Image(systemName: "film.fill")
            }
            VideoList()
                .tabItem {
                    Text("favorite")
                    Image(systemName: "heart.circle")
            }
            ProFile()
                .tabItem {
                    Text("Profile")
                    Image(systemName: "person.crop.circle.fill")
                }
                .environmentObject(peopledata)
                .environmentObject(photoData)
        }
    }
}
