//
//  VideoRow.swift
//  Final
//
//  Created by Lin Bo Rong on 2021/1/19.
//

import SwiftUI

struct VideoRow: View {
  let video: Video
  static let releaseFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    return formatter
  }()
  var body: some View {
    VStack(alignment: .leading) {
        video.title.map(Text.init)
        .font(.title)
      HStack {
        video.subtitle.map(Text.init)
          .font(.caption)
        Spacer()
        video.releaseDate.map { Text(Self.releaseFormatter.string(from: $0)) }
          .font(.caption)
      }
    }
  }
}
