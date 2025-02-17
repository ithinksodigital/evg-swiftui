import SwiftUI
import Evergage

// Example product model
struct Product: Identifiable {
    let id: String
    let name: String
    let description: String
    let imageName: String
}

struct ToastView: View {
    let message: String
    
    var body: some View {
        Text(message)
            .font(.subheadline)
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(Color.black.opacity(0.8))
            .cornerRadius(8)
            .shadow(radius: 4)
            .padding(.top, 80) 
    }
}

struct ProductCardView: View {
    let product: Product
    @State private var showToast = false
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                // Product Image
                Image(product.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .cornerRadius(10)
                
                // Product Name
                Text(product.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                // Product Description
                Text(product.description)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Spacer()
                
                // Add to Cart Button
                Button(action: {
                    EvergageManager.shared.evgAddToCart(
                        item: EVGLineItem(productId: product.id, productName: nil, price: nil, quantity: 1)
                    )
                    withAnimation {
                        showToast = true
                    }
                    // Hide toast after 2 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            showToast = false
                        }
                    }
                }) {
                    HStack {
                        Image(systemName: "cart.badge.plus")
                        Text("Add to Cart")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
            .onAppear {
                EvergageManager.shared.viewItem(product.id)
            }
            
            // Toast Overlay
            if showToast {
                VStack {
                    ToastView(message: "\(product.name) was added to your cart.")
                    Spacer()
                }
                .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
    }
}

struct ItemView: View {
    // Sample data: an array of products
    let products = [
        Product(id: "1",
                name: "Product One",
                description: "This is an amazing product that you will love.",
                imageName: "product"),
        Product(id: "2",
                name: "Product Two",
                description: "Experience the quality and innovation in this product.",
                imageName: "product"),
        Product(id: "3",
                name: "Product Three",
                description: "A top choice for anyone looking for great value.",
                imageName: "product")
    ]
    
    var body: some View {
        TabView {
            ForEach(products) { product in
                ProductCardView(product: product)
            }
        }
        .tabViewStyle(PageTabViewStyle())
    }
}
