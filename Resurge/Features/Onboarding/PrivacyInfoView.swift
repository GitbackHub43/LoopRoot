import SwiftUI

struct PrivacyInfoView: View {
    let onNext: () -> Void

    @State private var appeared = false

    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()

            VStack(spacing: 24) {
                Spacer()

                // Shield icon
                ZStack {
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [Color.neonCyan.opacity(0.2), Color.clear],
                                center: .center,
                                startRadius: 20,
                                endRadius: 80
                            )
                        )
                        .frame(width: 140, height: 140)

                    Image(systemName: "lock.shield.fill")
                        .font(.system(size: 64))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.neonCyan, .neonBlue, .neonPurple],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                }
                .scaleEffect(appeared ? 1 : 0.5)
                .opacity(appeared ? 1 : 0)

                // Title
                Text("Your Data Stays\nWith You")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .rainbowText()
                    .opacity(appeared ? 1 : 0)

                // Privacy points
                VStack(alignment: .leading, spacing: 16) {
                    privacyPoint(
                        icon: "iphone",
                        title: "100% Offline",
                        description: "Everything lives on your device. No servers, no cloud, no internet required.",
                        color: .neonCyan
                    )

                    privacyPoint(
                        icon: "person.slash.fill",
                        title: "No Accounts",
                        description: "No sign-ups, no emails, no personal information collected.",
                        color: .neonPurple
                    )

                    privacyPoint(
                        icon: "eye.slash.fill",
                        title: "No Tracking",
                        description: "Zero analytics, zero ads, zero data shared with anyone.",
                        color: .neonMagenta
                    )

                    privacyPoint(
                        icon: "lock.shield.fill",
                        title: "Encrypted Backup",
                        description: "Export your data anytime with AES-256 encryption from Settings.",
                        color: .neonGreen
                    )
                }
                .padding(.horizontal, 24)
                .opacity(appeared ? 1 : 0)

                Spacer()

                // Continue button
                Button {
                    onNext()
                } label: {
                    Text("Continue")
                        .font(.headline.weight(.bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            LinearGradient(
                                colors: [.neonCyan, .neonBlue, .neonPurple],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(16)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 30)
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.8)) {
                appeared = true
            }
        }
    }

    private func privacyPoint(icon: String, title: String, description: String, color: Color) -> some View {
        HStack(alignment: .top, spacing: 14) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.15))
                    .frame(width: 36, height: 36)
                Image(systemName: icon)
                    .font(.system(size: 16))
                    .foregroundColor(color)
            }

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.appText)
                Text(description)
                    .font(.system(size: 13))
                    .foregroundColor(.subtleText)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}
