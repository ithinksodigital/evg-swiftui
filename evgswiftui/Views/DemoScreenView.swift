import SwiftUI

struct DemoScreenView: View {
    var body: some View {
        VStack {
            Text("Demo Screen")
                .font(.largeTitle)
        }
        .onAppear() {
            EvergageManager.shared.trackAction("Viewed Demo Screen")
        }
        
    }
}

