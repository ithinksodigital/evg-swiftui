import SwiftUI
import Evergage

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                ForEach(MenuItem.allCases, id: \..self) { item in
                    NavigationLink(destination: item.destination) {
                        HStack {
                            Text(item.title)
                            Image(systemName: "arrow.right")
                        }
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                    .padding(.horizontal)
                }
                Spacer()
                FooterView()
            }
            .onAppear {
                Evergage.sharedInstance().globalContext?.trackAction("Viewed Content Screen")
            }
            .navigationTitle("SwiftUI + Evergage")
        }
    }
}

// Enum for Menu Items
enum MenuItem: CaseIterable {
    case item, demoScreen, campaign
    
    var title: String {
        switch self {
        case .item: return "Go to Items"
        case .demoScreen: return "Go to Demo Screen"
        case .campaign: return "Go to Campaign View"
        }
    }
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .item: ItemView()
        case .demoScreen: DemoScreenView()
        case .campaign: CampaignView()
        }
    }
}

// Footer View
struct FooterView: View {
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                Image(systemName: "bolt.fill")
                Text("App created by Rafał Pawelec")
                    .font(.footnote)
            }
            .padding(.horizontal)
            
            Link("GitHub: @ithinksodigital", destination: URL(string: "https://github.com/ithinksodigital/evg-swiftui")!)
                .font(.footnote)
                .foregroundColor(.blue)
                .padding(.top, 5)
        }
        .padding(.bottom, 20)
    }
}
