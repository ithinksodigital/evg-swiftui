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
                    if let campaign = evergageManager.activeCampaign {
                        evergageManager.campaignTrackClickthrough(campaign: campaign)
                    }
                }) {
                    HStack {
                        Text("Campaign Click")
                        Image(systemName: "cursorarrow.click")
                    }
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
                .padding(.horizontal)
                Button(action: {
                    if let campaign = evergageManager.activeCampaign {
                        evergageManager.campaignTrackDismissal(campaign: campaign)
                    }
                    
                }) {
                    HStack {
                        Text("Campaign Dismissal")
                        Image(systemName: "xmark.circle")
                    }
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(12)

                }
                .padding(.horizontal)
            
            
            
            } else {
                Button(action: {
                    evergageManager.trackAction("Viewed Campaign Screen")
                }) {
                    HStack {
                        Text("Trigger Campaign")
                        Image(systemName: "bolt")
                    }
                    .font(.title2)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
                .padding(.horizontal)
                Text("No campaign")
                    .foregroundColor(.gray)
            }
        }
        .onAppear {
            // Register a campaign handler for the demo target
            evergageManager.registerCampaignHandler(forTarget: "demo")
        }
    }
}

struct CampaignView_Previews: PreviewProvider {
    static var previews: some View {
        CampaignView()
    }
}
