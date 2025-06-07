//
//  ModeSelectionView.swift
//  AIChatApp
//
//  Created by Yassine Lamtalaa on 5/28/25.
//

import SwiftUI

struct ModeSelectionView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("mainScreenArt")
                    .resizable()
                    .ignoresSafeArea()
                VStack(spacing: 20) {
                    Spacer()
                    Text("Tip: Sharing a bit about yourself makes the experience even better!")
                        .font(.headline)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .padding(.top)
                    ForEach(["Roast Me", "Compliment Me", "Surprise Me"], id: \.self) { mode in
                        NavigationLink(destination: ChatView(viewModel: ChatViewModel(mode: mode))) {
                            Text(mode)
                                .font(.headline)
                                .fontWeight(.bold)
                                .padding()
                                .frame(maxWidth: .infinity)
                                //.background(Color.blue)
                                .background(gradientForMode(mode))
                                .foregroundColor(.white)
                                .cornerRadius(16)
                                .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)
                                .padding(.horizontal)
                        }
                    }
                    Spacer()
                }
                .navigationTitle("Choose Mode")
            }
        }
    }
    
    func gradientForMode(_ mode: String) -> LinearGradient {
        switch mode {
        case "Roast Me":
            return LinearGradient(
                colors: [Color(red: 0.85, green: 0.2, blue: 0.2), Color.orange],
                startPoint: .topLeading, endPoint: .bottomTrailing
            )
        case "Compliment Me":
            return LinearGradient(
                colors: [Color(red: 1.0, green: 0.6, blue: 0.8), Color(red: 1.0, green: 0.85, blue: 0.6)],
                startPoint: .topLeading, endPoint: .bottomTrailing
            )
        case "Surprise Me":
            return LinearGradient(
                colors: [Color.purple, Color.blue],
                startPoint: .topLeading, endPoint: .bottomTrailing
            )
        default:
            return LinearGradient(
                colors: [Color.gray.opacity(0.5), Color.gray.opacity(0.3)],
                startPoint: .topLeading, endPoint: .bottomTrailing
            )
        }
    }
}
