import SwiftUI

struct MoreView: View {
    @EnvironmentObject var environment: AppEnvironment
    @AppStorage("selectedTheme") private var selectedTheme: String = "default"
    @AppStorage("showPetOnScreens") private var showPetOnScreens: Bool = true
    @AppStorage("showWatchSkin") private var showWatchSkin: Bool = true

    private var appVersion: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
        return "v\(version) (\(build))"
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color.appBackground.ignoresSafeArea()
                    .id("bg_\(selectedTheme)")

                List {
                    // MARK: - Preferences
                    Section {
                        NavigationLink {
                            NotificationSettingsView()
                                .environmentObject(environment)
                        } label: {
                            settingsRow(icon: "bell.fill", title: "Notifications", color: .neonOrange)
                        }

                        NavigationLink {
                            PrivacyLockSettingsView()
                                .environmentObject(environment)
                        } label: {
                            settingsRow(icon: "lock.fill", title: "Privacy Lock", color: .neonCyan)
                        }

                        NavigationLink {
                            StealthSettingsView()
                                .environmentObject(environment)
                        } label: {
                            settingsRow(icon: "eye.slash.fill", title: "Stealth Mode", color: .neonPurple)
                        }

                    } header: {
                        Text("Preferences")
                    }
                    .listRowBackground(Color.cardBackground)

                    // MARK: - Premium
                    Section {
                        NavigationLink {
                            SubscriptionStatusView()
                                .environmentObject(environment)
                        } label: {
                            settingsRow(icon: "crown.fill", title: "Subscription", color: .neonGold)
                        }

                        NavigationLink {
                            RestorePurchasesView()
                                .environmentObject(environment)
                        } label: {
                            settingsRow(icon: "arrow.clockwise", title: "Restore Purchases", color: .neonPurple)
                        }
                    } header: {
                        Text("Premium")
                    }
                    .listRowBackground(Color.cardBackground)

                    // MARK: - Safety
                    Section {
                        NavigationLink {
                            EmergencyContactsView()
                        } label: {
                            settingsRow(icon: "phone.fill", title: "Emergency Contacts", color: .neonMagenta)
                        }
                    } header: {
                        Text("Safety")
                    }
                    .listRowBackground(Color.cardBackground)

                    // MARK: - Data
                    Section {
                        NavigationLink {
                            BackupView()
                        } label: {
                            settingsRow(icon: "lock.shield.fill", title: "Encrypted Backup", color: .neonCyan)
                        }
                    } header: {
                        Text("Data")
                    }
                    .listRowBackground(Color.cardBackground)

                    // MARK: - About
                    // MARK: - Feedback
                    Section {
                        NavigationLink {
                            SuggestionBoxView()
                        } label: {
                            settingsRow(icon: "envelope.fill", title: "Suggestion Box", color: .neonGreen)
                        }
                    } header: {
                        Text("Feedback")
                    }
                    .listRowBackground(Color.cardBackground)

                    Section {
                        HStack {
                            settingsRow(icon: "info.circle.fill", title: "App Version", color: .neonCyan)
                            Spacer()
                            Text(appVersion)
                                .font(.subheadline)
                                .foregroundColor(.subtleText)
                        }

                        NavigationLink {
                            PrivacyPolicyView()
                        } label: {
                            settingsRow(icon: "hand.raised.fill", title: "Privacy Policy", color: .neonBlue)
                        }

                        NavigationLink {
                            TermsOfServiceView()
                        } label: {
                            settingsRow(icon: "doc.text.fill", title: "Terms of Service", color: .neonPurple)
                        }
                    } header: {
                        Text("About")
                    }
                    .listRowBackground(Color.cardBackground)

                    // MARK: - Debug (UNCOMMENT to re-enable Time Travel)
                    // Section {
                    //     NavigationLink {
                    //         DebugTimeTravelView()
                    //             .environmentObject(environment)
                    //     } label: {
                    //         settingsRow(icon: "clock.arrow.circlepath", title: "Time Travel (Debug)", color: .neonOrange)
                    //     }
                    // } header: {
                    //     Text("Developer")
                    // }
                    // .listRowBackground(Color.cardBackground)
                }
                .listStyle(.insetGrouped)
                .id("settings_\(selectedTheme)")
                .onAppear {
                    UITableView.appearance().backgroundColor = .clear
                    UICollectionView.appearance().backgroundColor = .clear
                    ThemeColors.shared.refresh()
                }
                .onChange(of: selectedTheme) { _ in
                    UITableView.appearance().backgroundColor = .clear
                    UICollectionView.appearance().backgroundColor = .clear
                    ThemeColors.shared.refresh()
                }
            }
            .navigationTitle("More")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    ActivePetView()
                }
            }
        }
    }

    @ViewBuilder
    private func settingsRow(icon: String, title: String, color: Color) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.body)
                .foregroundColor(.white)
                .frame(width: 30, height: 30)
                .background(color)
                .cornerRadius(7)

            Text(title)
                .font(.body)
                .foregroundColor(.appText)
        }
    }
}

struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        let env = AppEnvironment.preview
        MoreView()
            .environmentObject(env)
    }
}
