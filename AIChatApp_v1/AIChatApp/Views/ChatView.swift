//
//  ChatView.swift
//  AIChatApp
//
//  Created by Yassine Lamtalaa on 5/28/25.
//

import SwiftUI

struct ChatView: View {
    @StateObject var viewModel: ChatViewModel

    var body: some View {
        ZStack {
            Image(viewModel.mode)
                .resizable()
                .ignoresSafeArea()
            VStack {
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack {
                            ForEach(viewModel.messages) { message in
                                MessageBubbleView(message: message)
                            }
                        }
                    }
                    .onChange(of: viewModel.messages.count) {
                        withAnimation {
                            proxy.scrollTo(viewModel.messages.last?.id, anchor: .bottom)
                        }
                    }
                }
                
                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(.systemGray6))

                        HStack {
                            TextField("Type a message...", text: $viewModel.inputText)
                                .padding(12)
                            
                            if !viewModel.inputText.isEmpty {
                                Button(action: {
                                    viewModel.sendMessage()
                                }) {
                                    Image(systemName: "paperplane.fill")
                                        .foregroundColor(.blue)
                                        .padding(.trailing, 12)
                                }
                                .transition(.scale)
                            }
                        }
                    }
                    .frame(height: 40)
                    .padding(.horizontal)
                    .animation(.easeInOut, value: viewModel.inputText)
                }
                .padding()
            }
        }
        .navigationTitle(viewModel.mode)
    }
}

