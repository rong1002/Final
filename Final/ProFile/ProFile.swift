//
//  LoginView.swift
//  Final
//
//  Created by Lin Bo Rong on 2021/1/6.
//

import SwiftUI
struct ProFile: View{
    @State private var username = ""
    @State private var email=""
    @State private var selectDate = Date()
    @State private var showSelectPhoto = false
    @State private var selectImage: UIImage?
    @EnvironmentObject var people: Peopledata
    @State private var showAlert = false
    @EnvironmentObject var photoData : PhotoData
    let today=Date()
    let startdate=Calendar.current.date(byAdding: .year,value: -100, to: Date())!
    var accentColor: Color = Color.blue
    var grayBackground: Color = Color.gray.opacity(0.2)
    
    var body: some View {
        ZStack {
            IGViewControllerView()
            YTViewControllerView()
            VStack{
                Text("個人資料")
                    .font(.largeTitle)
                    .foregroundColor(.accentColor)
                    .fontWeight(.semibold)
                    .padding(.bottom, 20)
                ImagePick(selectImage: $selectImage,showSelectPhoto: $showSelectPhoto)
                TextField("Username", text: $username)
                    .padding()
                    .background(grayBackground)
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                TextField("Email", text: $email)
                    .padding()
                    .background(grayBackground)
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                DatePicker("生日",selection: $selectDate,in: startdate...today, displayedComponents: .date)
                    .datePickerStyle(WheelDatePickerStyle())
                Button(action: {
                    people.people[0]=Person(username: username, email: email, birth: selectDate)
                    self.showAlert=true
                    if selectImage != nil {
                        let imageName = UUID().uuidString
                        let url = PhotoData.documentsDirectory.appendingPathComponent(imageName)
                        try? selectImage?.jpegData(compressionQuality: 0.9)?.write(to: url)
                        let photo = Photo(content: username, imageName: imageName)
                        photoData.photos.insert(photo, at: 0)
                    }
                }) {
                    Text("Save!")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.init(red: 74/255, green: 55/255, blue: 222/255), Color.init(red: 102/255, green: 191/255, blue: 244/255)]), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1)))
                        .cornerRadius(15.0)
                }
            }
            .alert(isPresented: self.$showAlert) { () -> Alert in
                return Alert(title: Text("儲存成功"))
            }
            .onAppear{
                if self.people.people.count>0{
                    self.username=self.people.people[0].username
                    self.email=self.people.people[0].email
                    self.selectDate=self.people.people[0].birth
                }
                if photoData.photos.count>0{ selectImage=UIImage(contentsOfFile: photoData.photos[0].imagePath)!}
        }
        }
    }
}

//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
