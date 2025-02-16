import SwiftUI

struct CampaignView: View {
    @ObservedObject var evergageManager = EvergageManager.shared
    
    var body: some View {
        VStack(spacing: 20) {
            if !evergageManager.campaignMessage.isEmpty {
                Text(evergageManager.campaignMessage)
                    .font(.title)
                    .padding()
                Button(action: {
                    evergageManager.campaignTrackClickthrough(campaign: evergageManager.activeCampaign!)
                }) {
                    Label("Campaign Click", systemImage: "cursorarrow.click")
                }.buttonStyle(.bordered)

       
      
            } else {
                Text("No campaign")
                    .foregroundColor(.gray)
            }
        }
        .navigationTitle("Campaign View")
        .onAppear {
            // Register a campaign handler for the demo target
            EvergageManager.shared.registerCampaignHandler(forTarget: "demo")
            evergageManager.trackAction("Viewed Campaign Screen")
        }
    }
}

struct CampaignView_Previews: PreviewProvider {
    static var previews: some View {
        CampaignView()
    }
}
