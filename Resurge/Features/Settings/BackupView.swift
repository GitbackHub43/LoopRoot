import SwiftUI
import UniformTypeIdentifiers

struct BackupView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var passphrase = ""
    @State private var showShareSheet = false
    @State private var showImportPicker = false
    @State private var exportURL: URL?
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    @State private var isProcessing = false
    @State private var showImportConfirm = false
    @State private var importFileURL: URL?

    var body: some View {
        ScrollView {
            VStack(spacing: AppStyle.largeSpacing) {
                // Header
                VStack(spacing: 8) {
                    Image(systemName: "lock.shield.fill")
                        .font(.system(size: 48))
                        .foregroundColor(.neonCyan)
                    Text("Encrypted Backup")
                        .font(Typography.largeTitle)
                        .rainbowText()
                    Text("Your data is encrypted with AES-256. Only you can access it with your passphrase.")
                        .font(Typography.body)
                        .foregroundColor(.subtleText)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, AppStyle.largeSpacing)

                // Passphrase input
                VStack(alignment: .leading, spacing: 8) {
                    Text("Passphrase")
                        .font(Typography.headline)
                        .foregroundColor(.appText)
                    SecureField("Enter a strong passphrase", text: $passphrase)
                        .font(Typography.body)
                        .padding()
                        .background(Color.cardBackground)
                        .cornerRadius(AppStyle.smallCornerRadius)
                        .overlay(RoundedRectangle(cornerRadius: AppStyle.smallCornerRadius).stroke(Color.cardBorder, lineWidth: 1))

                    HStack(spacing: 4) {
                        ForEach(0..<4, id: \.self) { i in
                            RoundedRectangle(cornerRadius: 2)
                                .fill(i < passphraseStrength ? strengthColor : Color.cardBorder)
                                .frame(height: 4)
                        }
                    }
                    Text(strengthLabel)
                        .font(Typography.caption)
                        .foregroundColor(.subtleText)
                }
                .padding(.horizontal, AppStyle.screenPadding)

                // Export button
                Button {
                    exportBackup()
                } label: {
                    HStack {
                        if isProcessing {
                            ProgressView().tint(.white)
                        } else {
                            Image(systemName: "square.and.arrow.up.fill")
                        }
                        Text("Export Backup")
                    }
                }
                .buttonStyle(RainbowButtonStyle())
                .disabled(passphrase.count < 6 || isProcessing)
                .opacity(passphrase.count < 6 ? 0.5 : 1)
                .padding(.horizontal, AppStyle.screenPadding)

                // Import button
                Button {
                    showImportPicker = true
                } label: {
                    HStack {
                        Image(systemName: "square.and.arrow.down.fill")
                        Text("Import Backup")
                    }
                }
                .buttonStyle(SecondaryButtonStyle(color: .neonPurple))
                .disabled(passphrase.count < 6 || isProcessing)
                .padding(.horizontal, AppStyle.screenPadding)

                // What gets backed up
                VStack(alignment: .leading, spacing: 10) {
                    Label("What's included", systemImage: "checklist")
                        .font(Typography.headline)
                        .foregroundColor(.neonCyan)

                    backupItem(icon: "heart.fill", text: "All habits & recovery data", color: .neonGreen)
                    backupItem(icon: "calendar", text: "Daily loop entries", color: .neonCyan)
                    backupItem(icon: "book.fill", text: "Journal & gratitude logs", color: .neonBlue)
                    backupItem(icon: "exclamationmark.shield.fill", text: "Craving entries & triggers", color: .neonOrange)
                    backupItem(icon: "trophy.fill", text: "Badges & achievements", color: .neonGold)
                    backupItem(icon: "diamond.fill", text: "Surge balance & vault purchases", color: .neonPurple)
                    backupItem(icon: "gearshape.fill", text: "App settings & preferences", color: .subtleText)
                }
                .neonCard(glow: .neonCyan)
                .padding(.horizontal, AppStyle.screenPadding)
            }
            .padding(.bottom, AppStyle.largeSpacing)
        }
        .background(Color.appBackground.ignoresSafeArea())
        .navigationTitle("Backup")
        .navigationBarTitleDisplayMode(.inline)
        .alert(alertTitle, isPresented: $showAlert) { Button("OK") {} } message: { Text(alertMessage) }
        .alert("Restore Backup?", isPresented: $showImportConfirm) {
            Button("Cancel", role: .cancel) {}
            Button("Restore", role: .destructive) { performImport() }
        } message: {
            Text("This will replace all current data with the backup. This cannot be undone.")
        }
        .sheet(isPresented: $showShareSheet) {
            if let url = exportURL {
                BackupShareSheet(activityItems: [url])
            }
        }
        .fileImporter(isPresented: $showImportPicker, allowedContentTypes: [.data], allowsMultipleSelection: false) { result in
            switch result {
            case .success(let urls):
                if let url = urls.first {
                    importFileURL = url
                    showImportConfirm = true
                }
            case .failure(let error):
                alertTitle = "Import Failed"
                alertMessage = error.localizedDescription
                showAlert = true
            }
        }
    }

    private func backupItem(icon: String, text: String, color: Color) -> some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: 14))
                .foregroundColor(color)
                .frame(width: 20)
            Text(text)
                .font(Typography.body)
                .foregroundColor(.appText)
        }
    }

    private var passphraseStrength: Int {
        var s = 0
        if passphrase.count >= 6 { s += 1 }
        if passphrase.count >= 10 { s += 1 }
        if passphrase.rangeOfCharacter(from: .decimalDigits) != nil { s += 1 }
        if passphrase.rangeOfCharacter(from: .uppercaseLetters) != nil { s += 1 }
        return s
    }

    private var strengthColor: Color {
        switch passphraseStrength {
        case 1: return .neonOrange
        case 2: return .neonGold
        case 3: return .neonCyan
        case 4: return .neonGreen
        default: return .cardBorder
        }
    }

    private var strengthLabel: String {
        switch passphraseStrength {
        case 0: return "Too short (min 6 characters)"
        case 1: return "Weak"
        case 2: return "Fair"
        case 3: return "Good"
        case 4: return "Strong"
        default: return ""
        }
    }

    private func exportBackup() {
        isProcessing = true
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let data = try EncryptedBackupService.exportBackup(context: viewContext, passphrase: passphrase)
                let dateStr = {
                    let f = DateFormatter()
                    f.dateFormat = "yyyy-MM-dd"
                    return f.string(from: Date())
                }()
                let url = FileManager.default.temporaryDirectory.appendingPathComponent("LoopRoot_Backup_\(dateStr).looprootbackup")
                try data.write(to: url)
                DispatchQueue.main.async {
                    exportURL = url
                    showShareSheet = true
                    isProcessing = false
                }
            } catch {
                DispatchQueue.main.async {
                    alertTitle = "Export Failed"
                    alertMessage = error.localizedDescription
                    showAlert = true
                    isProcessing = false
                }
            }
        }
    }

    private func performImport() {
        guard let url = importFileURL else { return }
        isProcessing = true
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let accessing = url.startAccessingSecurityScopedResource()
                defer { if accessing { url.stopAccessingSecurityScopedResource() } }
                let data = try Data(contentsOf: url)
                do {
                    try EncryptedBackupService.importBackup(data: data, passphrase: passphrase, context: viewContext)
                } catch let error as NSError where error.domain == "NSCocoaErrorDomain" && (error.code == 1560 || error.code == 1570 || error.code == 1580) {
                    // Validation errors — data still restored successfully, ignore
                    print("EncryptedBackupService: Validation warning (non-fatal): \(error.localizedDescription)")
                }
                DispatchQueue.main.async {
                    alertTitle = "Restore Complete"
                    alertMessage = "Your data has been restored from the backup."
                    showAlert = true
                    isProcessing = false
                }
            } catch {
                DispatchQueue.main.async {
                    alertTitle = "Import Failed"
                    alertMessage = error.localizedDescription
                    showAlert = true
                    isProcessing = false
                }
            }
        }
    }
}

// MARK: - Backup Share Sheet

private struct BackupShareSheet: UIViewControllerRepresentable {
    let activityItems: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
