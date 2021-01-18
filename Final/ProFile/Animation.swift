//
//  Animation.swift
//  Final
//
//  Created by Lin Bo Rong on 2021/1/15.
//

import SwiftUI

class IGViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            let InstagramImage = CAEmitterCell()
            InstagramImage.contents = UIImage(named: "instagram")?.cgImage
            InstagramImage.birthRate = 4
            InstagramImage.lifetime = 20
            InstagramImage.velocity = 100
            InstagramImage.scale = 0.02
            InstagramImage.scaleRange = 0.03
            InstagramImage.spin = 0.5
            InstagramImage.spinRange = 1
            InstagramImage.yAcceleration = 30
            let IGImageLayer = CAEmitterLayer()
            IGImageLayer.emitterCells = [InstagramImage]

            IGImageLayer.emitterPosition = CGPoint(x: view.bounds.width/2, y: -50)
            IGImageLayer.emitterSize = CGSize(width: view.bounds.width, height: 0)
            IGImageLayer.emitterShape = .line
            view.layer.addSublayer(IGImageLayer)
    }
}
struct IGViewControllerView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> IGViewController {
        IGViewController()
    }
    
    func updateUIViewController(_ uiViewController: IGViewController, context: Context) {
    }
    
    typealias UIViewControllerType = IGViewController
    
    
}
struct ViewController_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            IGViewControllerView()
            YTViewControllerView()
        }
    }
}

class YTViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            let InstagramImage = CAEmitterCell()
            InstagramImage.contents = UIImage(named: "youtube")?.cgImage
            InstagramImage.birthRate = 4
            InstagramImage.lifetime = 20
            InstagramImage.velocity = 100
            InstagramImage.scale = 0.02
            InstagramImage.scaleRange = 0.03
            InstagramImage.spin = 0.5
            InstagramImage.spinRange = 1
            InstagramImage.yAcceleration = 30
            let IGImageLayer = CAEmitterLayer()
            IGImageLayer.emitterCells = [InstagramImage]

            IGImageLayer.emitterPosition = CGPoint(x: view.bounds.width/2, y: -100)
            IGImageLayer.emitterSize = CGSize(width: view.bounds.width/2, height: -50)
            IGImageLayer.emitterShape = .line
            view.layer.addSublayer(IGImageLayer)
    }
}
struct YTViewControllerView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> YTViewController {
        YTViewController()
    }
    
    func updateUIViewController(_ uiViewController: YTViewController, context: Context) {
    }
    
    typealias UIViewControllerType = YTViewController
    
    
}
