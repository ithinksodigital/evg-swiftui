import SwiftUI
import Evergage

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
      
                NavigationLink(destination: ItemView()) {
                    HStack {
                        Text("Go to Item")
                        Image(systemName: "arrow.right")

                    }
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)

                NavigationLink(destination: DemoScreenView()) {
                    HStack {
                        Text("Go to Demo Screen")
                        Image(systemName: "arrow.right")

                    }
                    .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
    
                
                NavigationLink(destination: CampaignView()) {
                    HStack {
                        Text("Go to Campaign View")
                        Image(systemName: "arrow.right")

                    }
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                Spacer()
                VStack {
                            Text("App created by Rafał Pawelec")
                                .font(.footnote)
                                .padding(.horizontal)
                            
                            Link("GitHub: @ithinksodigital", destination: URL(string: "https://github.com/ithinksodigital/evg-swiftui")!)
                                .font(.footnote)
                                .foregroundColor(.blue)
                                .padding(.top, 5)
                        }
                        .padding(.bottom, 20)
            }
            .onAppear() {
                Evergage.sharedInstance().globalContext?.trackAction("Viewed Content Screen")
            }
            .navigationTitle("SwiftUI + Evergage")
        }
    }
}
