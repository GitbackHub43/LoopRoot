import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AppStyle.largeSpacing) {
                Text("Privacy Policy")
                    .font(Typography.largeTitle)
                    .rainbowText()

                Text("Last updated: March 19, 2026")
                    .font(Typography.caption)
                    .foregroundColor(.textSecondary)

                section(title: "Introduction", body: """
                This Privacy Policy describes how Thryvenex Holdings LLC ("we," "us," or "our") handles information in connection with the LoopRoot mobile application ("LoopRoot" or the "App"). We are committed to protecting your privacy, especially given the sensitive and deeply personal nature of addiction recovery. Please read this Privacy Policy carefully before using the App.

                By downloading, installing, or using LoopRoot, you acknowledge that you have read and understood this Privacy Policy. If you do not agree with this Privacy Policy, please do not use the App.
                """)

                section(title: "Our Core Privacy Principle: Zero Data Collection", body: """
                LoopRoot is built from the ground up as a fully offline, privacy-first application. We do not collect, transmit, store, process, or have access to any of your personal data. There are no servers, no cloud storage, no user accounts, no analytics, and no tracking of any kind. Your recovery journey is yours alone.
                """)

                section(title: "Information We Do NOT Collect", body: """
                To be explicit, LoopRoot does NOT collect, access, or transmit any of the following:

                - Personal identifiers (name, email, phone number, address)
                - Account credentials (there are no accounts)
                - Location data or GPS information
                - Device identifiers or fingerprints
                - Usage analytics or behavioral data
                - Health or medical information
                - Biometric data (Face ID/Touch ID is handled entirely by iOS)
                - Contacts, photos, or other device content
                - Browsing history or search queries
                - Advertising identifiers
                - Crash reports or diagnostic data
                - Any data whatsoever transmitted over the internet

                LoopRoot requires no internet connection to function. The App does not communicate with any server, API, or external service at any time.
                """)

                section(title: "Data Stored Locally on Your Device", body: """
                All data you create within LoopRoot is stored exclusively on your device using Apple's Core Data framework and UserDefaults. This includes, but is not limited to:

                - Recovery program selections and habit configurations
                - Daily check-in logs (morning, afternoon, evening)
                - Sobriety dates and streak information
                - Craving records and outcomes
                - Journal and gratitude entries
                - Achievement badges and progress milestones
                - Surge (in-app currency) balance and purchase history
                - Companion pet selections and accessories
                - Coaching plans and daily challenge progress
                - Notification preferences and schedules
                - Theme and display preferences
                - Stealth mode and privacy lock settings

                This data never leaves your device. We cannot access, view, retrieve, or recover this data under any circumstances.
                """)

                section(title: "Data Backup and Export", body: """
                LoopRoot provides an optional encrypted backup feature that allows you to export your data as an AES-256 encrypted file. This backup file is created and stored locally on your device. You control where this file goes (e.g., saving to Files, AirDrop, etc.). We have no access to your backup files or your encryption password. If you lose your encryption password, we cannot recover it or your data.
                """)

                section(title: "In-App Purchases and Apple", body: """
                LoopRoot offers optional premium subscriptions processed entirely by Apple through the App Store and StoreKit 2. We do not process, store, or have access to your payment information, Apple ID, or billing details.

                Apple may provide us with anonymized, aggregated sales data through App Store Connect. This data does not identify individual users. Apple's handling of your purchase data is governed by Apple's own Privacy Policy (https://www.apple.com/legal/privacy/).

                Our subscription options are:
                - Monthly: $4.99/month (auto-renewable)
                - Yearly: $39.99/year (auto-renewable)
                - Lifetime: $99.99 (one-time purchase)
                """)

                section(title: "Local Notifications", body: """
                If you enable notifications, they are scheduled entirely on your device using iOS local notification APIs. No notification data is sent to any server. We do not use push notifications, and there is no push notification server.

                LoopRoot offers a Stealth Mode feature that hides the content of notifications so that sensitive recovery information is not visible on your lock screen or in notification previews.
                """)

                section(title: "Biometric Authentication", body: """
                LoopRoot offers an optional privacy lock using Face ID or Touch ID. All biometric authentication is handled entirely by Apple's LocalAuthentication framework on your device. We never access, store, process, or transmit any biometric data. We only receive a success or failure result from iOS.
                """)

                section(title: "Third-Party Libraries", body: """
                LoopRoot uses the following open-source libraries, none of which collect, transmit, or process user data:

                - DGCharts: Local chart rendering for analytics displays
                - Lottie: Local animation rendering for visual effects
                - Swift Collections: Local data structure utilities

                These libraries operate entirely on-device and do not communicate with any external services.
                """)

                section(title: "Crisis Helpline Information", body: """
                LoopRoot displays publicly available crisis helpline numbers (such as SAMHSA National Helpline, National Gambling Helpline, 988 Suicide & Crisis Lifeline, and others) for informational purposes. Displaying these numbers does not involve any data collection or transmission. If you call a helpline, that interaction is between you and the helpline service, and is governed by their respective privacy policies. We have no affiliation with these services and receive no data from them.
                """)

                section(title: "Health Milestone Information", body: """
                LoopRoot displays health recovery milestones based on published medical research for informational and motivational purposes. These milestones are hard-coded into the App and do not involve any collection or processing of your actual health data. The App does not integrate with Apple Health, HealthKit, or any health data provider.
                """)

                section(title: "Children's Privacy", body: """
                LoopRoot is not directed at or intended for use by children under the age of 13. We do not knowingly collect any information from children under 13. Since LoopRoot collects no data from any user, there is no mechanism by which children's data could be collected.

                Given the nature of the App's content (addiction recovery), it is intended for users aged 13 and older. If you are under 18, we recommend using the App under the guidance of a parent or guardian.
                """)

                section(title: "Data Deletion", body: """
                Since all data is stored locally on your device, you have complete control over your data at all times. You may delete all LoopRoot data by:

                - Deleting the App from your device, which permanently removes all associated data
                - Using any in-app data reset features, if available

                Because we do not store your data on any server, deletion is immediate and permanent. We cannot recover deleted data. There is no "account" to delete because no account exists.
                """)

                section(title: "Data Security", body: """
                Your data is protected by the security measures built into your iOS device, including device encryption, passcode protection, and biometric locks. The optional backup export feature uses AES-256 encryption. We recommend that you keep your device updated, use a strong passcode, and enable Find My iPhone to protect your data.

                Since your data never leaves your device and is never transmitted over any network, there is no risk of server breaches, data leaks, or unauthorized remote access to your LoopRoot data through our systems (because no such systems exist).
                """)

                section(title: "International Users", body: """
                LoopRoot does not transfer data internationally or to any jurisdiction because LoopRoot does not transfer data at all. Your data remains on your device, in whatever jurisdiction you and your device are physically located.
                """)

                section(title: "CCPA, GDPR, and Other Privacy Regulations", body: """
                Because LoopRoot collects no personal information whatsoever, the data collection and processing provisions of the California Consumer Privacy Act (CCPA), the European Union General Data Protection Regulation (GDPR), and similar privacy regulations do not apply in the traditional sense. There is no data to access, delete, port, or restrict processing of, because no data is collected by us.

                Nonetheless, we support the principles underlying these regulations: transparency, user control, data minimization, and privacy by design. LoopRoot embodies these principles by collecting zero data.
                """)

                section(title: "Changes to This Privacy Policy", body: """
                We may update this Privacy Policy from time to time to reflect changes in the App or applicable laws. Any changes will be reflected within the App with an updated effective date. Your continued use of the App after any changes indicates your acceptance of the updated Privacy Policy. We encourage you to review this Privacy Policy periodically.
                """)

                section(title: "Contact Us", body: """
                If you have any questions, concerns, or requests regarding this Privacy Policy or our privacy practices, please contact us at:

                Thryvenex Holdings LLC
                Email: LoopRootAssist@gmail.com

                We will respond to your inquiry as soon as reasonably practicable.
                """)
            }
            .padding(AppStyle.screenPadding)
        }
        .background(Color.appBackground.ignoresSafeArea())
        .navigationTitle("Privacy Policy")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func section(title: String, body: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(Typography.headline)
                .foregroundColor(.textPrimary)

            Text(body)
                .font(Typography.body)
                .foregroundColor(.textSecondary)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}
