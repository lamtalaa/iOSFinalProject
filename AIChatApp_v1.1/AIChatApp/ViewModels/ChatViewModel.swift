import Foundation
import CoreManager

@MainActor
class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var inputText: String = ""
    
    private let service: OpenAIService
    let mode: String

    init(mode: String, service: OpenAIService = OpenAIService()) {
        self.mode = mode
        self.service = service
    }

    func sendMessage() {
        guard !inputText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        let userMessage = Message(text: inputText, isUser: true)
        messages.append(userMessage)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            self.inputText = ""
        }

        let prompt = "\(mode): \(inputText)"
        service.sendMessage(prompt: prompt) { [weak self] response in
            guard let self = self, let response = response else { return }
            Task { @MainActor in
                let aiMessage = Message(text: response, isUser: false)
                self.messages.append(aiMessage)
            }
        }
    }
}
