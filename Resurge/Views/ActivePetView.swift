import SwiftUI

/// Shows the user's active pet with equipped accessories.
/// Place this next to navigation titles on each tab.
struct ActivePetView: View {
    @AppStorage("activePet") private var activePet: String = ""
    @AppStorage("equippedAccessories") private var equippedAccessories: String = ""
    @AppStorage("showPetOnScreens") private var showPetOnScreens: Bool = true
    var size: CGFloat = 32

    private var accessories: Set<String> {
        Set(equippedAccessories.components(separatedBy: ",").filter { !$0.isEmpty })
    }

    var body: some View {
        if !activePet.isEmpty && showPetOnScreens {
            ZStack {
                petView
                accessoryOverlays
            }
            .frame(width: size * 1.3, height: size * 1.3)
        }
    }

    @ViewBuilder
    private var petView: some View {
        switch activePet {
        case "pet_dog": DogPetView(size: size)
        case "pet_cat": CatPetView(size: size)
        case "pet_hamster": HamsterPetView(size: size)
        case "pet_owl": OwlPetView(size: size)
        default: EmptyView()
        }
    }

    // MARK: - Accessory Overlays

    @ViewBuilder
    private var accessoryOverlays: some View {
        // Hat — sits on top of the head
        if accessories.contains("companion_hat") {
            Text("🎩")
                .font(.system(size: size * 0.35))
                .offset(x: hatOffset.x, y: hatOffset.y)
        }

        // Crown — sits on top of the head (slightly different position than hat)
        if accessories.contains("companion_crown") {
            Text("👑")
                .font(.system(size: size * 0.3))
                .offset(x: crownOffset.x, y: crownOffset.y)
        }

        // Glasses — on the eyes
        if accessories.contains("companion_glasses") {
            Text("🕶️")
                .font(.system(size: size * 0.3))
                .offset(x: glassesOffset.x, y: glassesOffset.y)
        }

        // Bowtie — below the chin/neck area
        if accessories.contains("companion_bowtie") {
            Text("🎀")
                .font(.system(size: size * 0.25))
                .offset(x: bowtieOffset.x, y: bowtieOffset.y)
        }
    }

    // MARK: - Per-Pet Accessory Positions

    private var hatOffset: CGPoint {
        switch activePet {
        case "pet_dog": return CGPoint(x: 0, y: -size * 0.42)
        case "pet_cat": return CGPoint(x: 0, y: -size * 0.45)
        case "pet_hamster": return CGPoint(x: 0, y: -size * 0.38)
        case "pet_owl": return CGPoint(x: 0, y: -size * 0.48)
        default: return CGPoint(x: 0, y: -size * 0.4)
        }
    }

    private var crownOffset: CGPoint {
        switch activePet {
        case "pet_dog": return CGPoint(x: 0, y: -size * 0.4)
        case "pet_cat": return CGPoint(x: 0, y: -size * 0.43)
        case "pet_hamster": return CGPoint(x: 0, y: -size * 0.35)
        case "pet_owl": return CGPoint(x: 0, y: -size * 0.46)
        default: return CGPoint(x: 0, y: -size * 0.38)
        }
    }

    private var glassesOffset: CGPoint {
        switch activePet {
        case "pet_dog": return CGPoint(x: size * 0.03, y: -size * 0.18)
        case "pet_cat": return CGPoint(x: size * 0.02, y: -size * 0.17)
        case "pet_hamster": return CGPoint(x: 0, y: -size * 0.08)
        case "pet_owl": return CGPoint(x: 0, y: -size * 0.2)
        default: return CGPoint(x: 0, y: -size * 0.15)
        }
    }

    private var bowtieOffset: CGPoint {
        switch activePet {
        case "pet_dog": return CGPoint(x: size * 0.03, y: size * 0.05)
        case "pet_cat": return CGPoint(x: size * 0.02, y: size * 0.05)
        case "pet_hamster": return CGPoint(x: 0, y: size * 0.12)
        case "pet_owl": return CGPoint(x: 0, y: size * 0.08)
        default: return CGPoint(x: 0, y: size * 0.08)
        }
    }
}
