//
//  HomeScreen.swift
//  SmartShop
//
//  Created by Luke on 10/21/25.
//

import SwiftUI

enum AppScreen: Hashable, Identifiable, CaseIterable {
    case home
    case myProducts
    case cart
    case profile
    
    var id: AppScreen {self}
}

extension AppScreen {
    
    @ViewBuilder
    var label: some View {
        switch self {
        case .home:
            Label("Home", systemImage: "house")
        case .myProducts:
            Label("My Products", systemImage: "book")
        case .cart:
            Label("Cart", systemImage: "cart")
        case .profile:
            Label("Profile", systemImage: "person")
            
        }
    }
    
    @ViewBuilder
    var destination: some View {
        switch self {
        case .home:
            Text("Home Screen")
        case .myProducts:
            Text("My Products").requiresAuthentication()
        case .cart:
            Text("Cart").requiresAuthentication()
        case .profile:
            ProfileScreen().requiresAuthentication()
        }
    }
}

struct HomeScreen: View {
    @State var selection: AppScreen?
    
    var body: some View {
        TabView(selection: $selection) {
            ForEach(AppScreen.allCases){ screen in
                NavigationStack {
                    screen.destination
                }
                    .tag(screen as AppScreen?)
                    .tabItem {screen.label}
            }
        }
    }
}

#Preview {
    HomeScreen()
}
