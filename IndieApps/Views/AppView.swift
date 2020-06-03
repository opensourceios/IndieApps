//
//  Copyright © 2020 An Tran. All rights reserved.
//

import SwiftUI

struct AppView: View {
    var app: App
    
    var body: some View {
        HStack {
            Image("icon\(Int.random(in: 1...4))")
                .resizable()
                .frame(width: 80, height: 80, alignment: .leading)
                .cornerRadius(14)
                .overlay(RoundedRectangle(cornerRadius: 14)
                    .stroke(Color.gray.opacity(0.4), lineWidth: 0.5))
            VStack(alignment: .leading) {
                Text(app.name)
                Spacer()
            }
        }
    }
}

#if DEBUG
struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        let app = App(
            name: "Twitter",
            shortDescription: "Twitter is cool",
            description: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet.",
            releaseNotes: [
                ReleaseNote(version: "1.0.0 (1)", note: "Fix a lot of bugs"),
                ReleaseNote(version: "1.0.0 (2)", note: "Fix a lot of bugs"),
            ]
        )
        return AppView(app: app)
    }
}
#endif
