//
//  AddVideo.swift
//  Final
//
//  Created by Lin Bo Rong on 2021/1/19.
//

import SwiftUI

struct AddVideo: View {
    static let DefaultVideoTitle = "G.E.M Title"
    static let DefaultVideoSubtitle = "G.E.M Subtitle"
    
    @State var title = ""
    @State var subtitle = ""
    @State var releaseDate = Date()
    let onComplete: (String, String, Date) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Title")) {
                    TextField("Title", text: $title)
                }
                Section(header: Text("Subtitle")) {
                    TextField("Subtitle", text: $subtitle)
                }
                Section {
                    DatePicker(
                        selection: $releaseDate,
                        displayedComponents: .date) {
                        Text("Release Date").foregroundColor(Color(.gray))
                    }
                }
                Section {
                    Button(action: addMoveAction) {
                        Text("Add Video")
                    }
                }
            }
            .navigationBarTitle(Text("Add Video"), displayMode: .inline)
        }
    }
    
    private func addMoveAction() {
        onComplete(
            title.isEmpty ? AddVideo.DefaultVideoTitle : title,
            subtitle.isEmpty ? AddVideo.DefaultVideoSubtitle : subtitle,
            releaseDate)
    }
}
