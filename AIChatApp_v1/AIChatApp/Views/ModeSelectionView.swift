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
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                                .padding(.horizontal)
                        }
                    }
                    Spacer()
                }
                .navigationTitle("Choose Mode")
            }
        }
    }
}
