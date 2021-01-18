//
//  VideoList'.swift
//  Final
//
//  Created by Lin Bo Rong on 2021/1/19.
//

import SwiftUI

struct VideoList: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: Video.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Video.title, ascending: true)])
    var videos: FetchedResults<Video>
    @State var isPresented = false
    
    var body: some View {
        NavigationView {
            VStack{
                List {
                    ForEach(videos, id: \.title) {
                        VideoRow(video: $0)
                    }
                    .onDelete(perform: deleteVideo)
                }
                
                Button(action: {
                    isPresented = true
                }) {
                    Text("Add!")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.init(red: 74/255, green: 55/255, blue: 222/255), Color.init(red: 102/255, green: 191/255, blue: 244/255)]), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1)))
                        .cornerRadius(15.0)
                }
            }

            .sheet(isPresented: $isPresented) {
                AddVideo { title, subtitle, release in
                    addVideo(title: title, subtitle: subtitle, releaseDate: release)
                    isPresented = false
                }
            }
            .navigationBarTitle(Text("Favorite"))
            
        }
    }
    
    func deleteVideo(at offsets: IndexSet) {
        // 1.
        offsets.forEach { index in
            let video = videos[index]

            managedObjectContext.delete(video)
        }

        saveContext()
    }
    
    
    func addVideo(title: String, subtitle: String, releaseDate: Date) {
        
        let newVideo = Video(context: managedObjectContext)

        newVideo.title = title
        newVideo.subtitle = subtitle
        newVideo.releaseDate = releaseDate
        
        // 3
        saveContext()
    }
    
    
    func saveContext() {
        do {
            try managedObjectContext.save()
        } catch {
            print("Error saving managed object context: \(error)")
        }
    }
}

struct VideoList_Previews: PreviewProvider {
    static var previews: some View {
        VideoList()
    }
}
