import SwiftUI
import CoreData

struct GoalCompleteView: View {
    @ObservedObject var habit: CDHabit
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    @State private var showExtend = false
    @State private var celebrate = false

    private let extendOptions: [(label: String, days: Int)] = [
        ("1 Week", 7),
        ("1 Month", 30),
        ("3 Months", 90),
        ("6 Months", 180),
        ("1 Year", 365),
    ]

    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 24) {
                    Spacer().frame(height: 20)

                    // Trophy
                    ZStack {
                        Circle()
                            .fill(Color.neonGold.opacity(0.1))
                            .frame(width: 140, height: 140)
                        Circle()
                            .stroke(
                                AngularGradient(
                                    colors: [.neonCyan, .neonBlue, .neonPurple, .neonMagenta, .neonOrange, .neonGold, .neonCyan],
                                    center: .center
                                ),
                                lineWidth: 3
                            )
                            .frame(width: 130, height: 130)
                            .rotationEffect(.degrees(celebrate ? 360 : 0))

                        Image(systemName: "trophy.fill")
                            .font(.system(size: 56))
                            .foregroundColor(.neonGold)
                            .shadow(color: .neonGold.opacity(0.6), radius: 16)
                            .scaleEffect(celebrate ? 1.1 : 0.9)
                    }

                    // Congrats
                    VStack(spacing: 8) {
                        Text("You Did It!")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .rainbowText()

                        Text("\(Int(habit.goalDays))-Day Goal Complete")
                            .font(Typography.title)
                            .foregroundColor(.neonGold)
                    }

                    // Message
                    VStack(spacing: 12) {
                        Text("You set out to go \(Int(habit.goalDays)) days and you made it. That took real discipline, real courage, and real strength.")
                            .font(Typography.body)
                            .foregroundColor(.subtleText)
                            .multilineTextAlignment(.center)

                        Text("Every single day you chose yourself over the habit. That's not small — that's everything.")
                            .font(Typography.body)
                            .foregroundColor(.appText)
                            .multilineTextAlignment(.center)

                        Text("You've proven you can do this. Now the question is — how far do you want to go?")
                            .font(Font.callout.italic())
                            .foregroundColor(.neonCyan)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal, 24)

                    // Extend options
                    if showExtend {
                        VStack(spacing: 12) {
                            Text("Set your next goal")
                                .font(Typography.headline)
                                .foregroundColor(.appText)

                            ForEach(extendOptions, id: \.days) { option in
                                Button {
                                    extendGoal(days: option.days)
                                } label: {
                                    HStack {
                                        Text(option.label)
                                            .font(Typography.headline)
                                            .foregroundColor(.appText)
                                        Spacer()
                                        Text("+\(option.days) days")
                                            .font(Typography.caption)
                                            .foregroundColor(.subtleText)
                                        Image(systemName: "chevron.right")
                                            .font(.system(size: 12))
                                            .foregroundColor(.subtleText)
                                    }
                                    .padding(14)
                                    .background(Color.cardBackground)
                                    .cornerRadius(12)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.cardBorder, lineWidth: 1)
                                    )
                                }
                            }
                        }
                        .padding(.horizontal, AppStyle.screenPadding)
                        .transition(.opacity.combined(with: .move(edge: .bottom)))
                    } else {
                        // Initial buttons
                        VStack(spacing: 12) {
                            Button {
                                withAnimation(.spring(response: 0.4)) {
                                    showExtend = true
                                }
                            } label: {
                                HStack {
                                    Image(systemName: "arrow.up.circle.fill")
                                    Text("Extend My Goal")
                                }
                            }
                            .buttonStyle(RainbowButtonStyle())
                            .padding(.horizontal, AppStyle.screenPadding)

                            Button {
                                dismiss()
                            } label: {
                                Text("I'm good for now")
                                    .font(Typography.callout)
                                    .foregroundColor(.subtleText)
                            }
                        }
                    }

                    Spacer().frame(height: 30)
                }
            }
        }
        .onAppear {
            withAnimation(.linear(duration: 3).repeatForever(autoreverses: false)) {
                celebrate = true
            }
        }
    }

    private func extendGoal(days: Int) {
        habit.goalDays = Int32(habit.daysSoberCount + days)
        habit.updatedAt = Date()
        try? viewContext.save()

        // Reset the "shown" flag so it can trigger again at the new goal
        let oldKey = "goalComplete_\(habit.id.uuidString)_\(Int(habit.goalDays) - days)"
        // No need to clear — new goal has a different key

        dismiss()
    }
}
