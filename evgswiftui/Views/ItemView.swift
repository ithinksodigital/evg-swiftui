import SwiftUI

struct ItemView: View {
    var body: some View {
        VStack {
            Text("Viewed Item")
                .font(.largeTitle)
        }
        .onAppear() {
            EvergageManager.shared.viewItem("1")
        }
    }
}

