//
//  SafariView.swift
//  FinalProject
//
//  Created by Lin Bo Rong on 2020/12/27.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> SFSafariViewController {
         SFSafariViewController(url: url)
    }
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
            
    }
    
    let url: URL
}

