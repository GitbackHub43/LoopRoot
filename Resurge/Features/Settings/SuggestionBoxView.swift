import SwiftUI

struct SuggestionBoxView: View {

    @State private var messageText = ""
    @State private var showSent = false
    @State private var showCopied = false
    @State private var showNoMail = false

    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 24) {

                    // Welcome message
                    VStack(spacing: 12) {
                        Image(systemName: "hand.wave.fill")
                            .font(.system(size: 44))
                            .foregroundColor(.neonGold)

                        Text("Hey, it's the developer!")
                            .font(.title2.weight(.bold))
                            .foregroundColor(.appText)

                        Text("Thank you for using LoopRoot. This app was built with one goal — to help people like you take back control. Every feature exists because someone on this journey needed it.\n\nI'd love to hear from you. Whether it's a suggestion, a feature request, a kind word, or even just a hello — your voice matters. You're not just a user, you're part of this.")
                            .font(.body)
                            .foregroundColor(.textSecondary)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding()
                    .background(Color.cardBackground)
                    .cornerRadius(16)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.neonGold.opacity(0.2), lineWidth: 1)
                    )

                    // Message box
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Your Message")
                            .font(.headline)
                            .foregroundColor(.appText)

                        ZStack(alignment: .topLeading) {
                            if messageText.isEmpty {
                                Text("Share a suggestion, feedback, or just say hi...")
                                    .font(.body)
                                    .foregroundColor(.textSecondary.opacity(0.5))
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 12)
                            }
                            TextEditor(text: $messageText)
                                .font(.body)
                                .foregroundColor(.appText)
                                .frame(minHeight: 120)
                                .padding(4)
                                .background(Color.cardBackground)
                        }
                        .background(Color.cardBackground)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.cardBorder, lineWidth: 1)
                        )
                    }

                    // Send button
                    Button {
                        sendEmail()
                    } label: {
                        HStack {
                            Image(systemName: "paperplane.fill")
                            Text("Send Message")
                        }
                        .font(.headline.weight(.bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(
                                colors: [.neonCyan, .neonPurple, .neonMagenta],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(14)
                    }
                    .disabled(messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    .opacity(messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 0.5 : 1)

                    // Footer
                    Text("Your message opens your email app with our support address pre-filled. We read every single one.")
                        .font(.caption)
                        .foregroundColor(.textSecondary.opacity(0.6))
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal)
                .padding(.vertical, 20)
            }
        }
        .navigationTitle("Suggestion Box")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Message Copied!", isPresented: $showNoMail) {
            Button("OK", role: .cancel) {
                messageText = ""
            }
        } message: {
            Text("No email app found. Your message and our email (LoopRootAssist@gmail.com) have been copied to your clipboard. Paste it in any email app to send.")
        }
    }

    private func sendEmail() {
        let subject = "LoopRoot Feedback"
        let body = messageText
        let mailto = "mailto:LoopRootAssist@gmail.com?subject=\(subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&body=\(body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        if let url = URL(string: mailto), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            // No mail app — copy email + message to clipboard
            UIPasteboard.general.string = "To: LoopRootAssist@gmail.com\nSubject: LoopRoot Feedback\n\n\(messageText)"
            showNoMail = true
        }
    }
}
