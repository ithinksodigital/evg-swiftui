import SwiftUI
import Evergage

class EvergageManager: ObservableObject {
    static let shared = EvergageManager()
    private let evergage = Evergage.sharedInstance()
    
    // Campaign handling properties
    @Published var activeCampaign: EVGCampaign?
    @Published var campaignMessage: String = ""
    
    private init() {}
    
    // Initializing Evergage SDK
    func initialize() -> Bool {
        guard let evergageFilePath = Bundle.main.path(forResource: "Evergage", ofType: "plist") else {
            fatalError("evergage.plist not found in the main bundle")
        }

        guard let evergagePlist = NSDictionary(contentsOfFile: evergageFilePath) else {
            fatalError("Failed to load evergage.plist")
        }

        print("🔵 [EvergageManager] Initializing Evergage...")
        #if DEBUG
        evergage.logLevel = EVGLogLevel.all
        #endif
        
        evergage.userId = evergagePlist["userId"] as? String
        
        evergage.start { config in
            config.account = evergagePlist["account"] as! String
            config.dataset =  evergagePlist["dataset"] as! String
            config.usePushNotifications = evergagePlist["usePushNotifications"] as! Bool
            config.useDesignMode = false
        }
        
        print("✅ [EvergageManager] Evergage initialization started!")
        evergage.globalContext?.trackAction("EvergageManager initialized")
        return true
    }
    
    func trackAction(_ action: String) {
        DispatchQueue.main.async {
            self.evergage.globalContext?.trackAction(action)
            print("📍 [EvergageManager] Tracked action: \(action)")
        }
    }
    
    func viewItem(_ itemId: String) {
        DispatchQueue.main.async {
            self.evergage.globalContext?.viewItem(EVGProduct(id: itemId))
            print("📍 [EvergageManager] ViewItem action: \(itemId)")
        }
    }
    
    // MARK: - Campaign Handling
    
    func registerCampaignHandler(forTarget target: String) {
        print("📍 Handler registration for: \(target)")
        let handler: (EVGCampaign) -> Void = { [weak self] campaign in
            self?.handleCampaign(campaign: campaign)
        }
        evergage.globalContext?.setCampaignHandler(handler, forTarget: target)
    }
    
    func campaignTrackClickthrough(campaign: EVGCampaign) {
        evergage.globalContext?.trackClickthrough(campaign)
    }
    
    func campaignTrackDismissal(campaign: EVGCampaign) {
        evergage.globalContext?.trackDismissal(campaign)
    }
    
    func evgAddToCart(item: EVGLineItem) {
        evergage.globalContext?.add(toCart: item)
    }
    
    /// Processes the received campaign and sets the message to display
    func handleCampaign(campaign: EVGCampaign) {
        print("Received campaign: \(campaign)")
        print("Campaign data: \(campaign.data)")
        
        if let camapignData = campaign.data["foo"] as? String, !camapignData.isEmpty {
            if let active = activeCampaign, active.isEqual(to: campaign) {
                NSLog("Ignoring campaign %@ since equivalent content is already active", campaign.campaignName)
                return
            }
            evergage.globalContext?.trackImpression(campaign)
            if !campaign.isControlGroup {
                activeCampaign = campaign
                NSLog("New active campaign %@ for target %@ with data %@", campaign.campaignName, campaign.target, campaign.data)
                DispatchQueue.main.async {
                    self.campaignMessage = "foo: \(camapignData)!"
                }
            }
        } else {
            DispatchQueue.main.async {
                self.campaignMessage = "Received campaign: \(campaign.campaignName)"
            }
        }
    }
}

// Extension for comparing campaigns
extension EVGCampaign {
    func isEqual(to other: EVGCampaign) -> Bool {
        return self.campaignName == other.campaignName && self.target == other.target
    }
}
