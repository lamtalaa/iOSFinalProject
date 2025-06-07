//
//  ChatView.swift
//  AIChatApp
//
//  Created by Yassine Lamtalaa on 5/28/25.
//

import SwiftUI

struct ChatView: View {
    @StateObject var viewModel: ChatViewModel
    @FocusState private var isInputFocused: Bool

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
                                    .id(message.id)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 10)
                    }
                    .onChange(of: viewModel.messages) {
                        scrollToBottom(with: proxy)
                    }
                    .onChange(of: isInputFocused) {
                        if isInputFocused {
                            scrollToBottom(with: proxy)
                        }
                    }
                }

                HStack {
                    ZStack(alignment: .trailing) {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(.systemGray6))
                            .frame(height: 44)

                        HStack {
                            TextField("Type a message...", text: $viewModel.inputText)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 10)
                                .focused($isInputFocused)
                            
                            if !viewModel.inputText.isEmpty {
                                Button(action: {
                                    viewModel.sendMessage()
                                    isInputFocused = false
                                }) {
                                    Image(systemName: "paperplane.fill")
                                        .foregroundColor(.blue)
                                        .padding(.trailing, 10)
                                }
                                .transition(.opacity)
                            }
                        }
                    }
                    .animation(.easeInOut, value: viewModel.inputText)
                    .padding(.horizontal)
                }
                .padding(.bottom, 10)
            }
            .contentShape(Rectangle()) // Allows taps to register anywhere
            .onTapGesture {
                isInputFocused = false // Dismiss keyboard when tapped outside
            }
        }
        .navigationTitle(viewModel.mode)
    }
    
    private func scrollToBottom(with proxy: ScrollViewProxy) {
        if let lastId = viewModel.messages.last?.id {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.easeOut(duration: 0.2)) {
                    proxy.scrollTo(lastId, anchor: .bottom)
                }
            }
        }
    }
}
