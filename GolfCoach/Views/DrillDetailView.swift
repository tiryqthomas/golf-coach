import SwiftUI
import SwiftData

struct DrillDetailView: View {
    @Bindable var drill: Drill

    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 6) {
                    Text("\(drill.area.displayName) · Level \(drill.level)\(drill.isKey ? " · Key drill" : "")")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(drill.area.color)
                    Text(drill.goal).font(.title3.weight(.semibold))
                }
                .padding(.vertical, 4)
                LabeledContent("Pass mark", value: drill.passMarkText)
                LabeledContent("Reps", value: repsText)
            }

            if !drill.materials.isEmpty {
                Section("You need") {
                    ForEach(drill.materials, id: \.self) { Text($0) }
                }
            }

            if !drill.warmUp.isEmpty {
                Section("Warm-up") { Text(drill.warmUp) }
            }

            if !drill.steps.isEmpty {
                Section("Steps") {
                    ForEach(Array(drill.steps.enumerated()), id: \.offset) { index, step in
                        HStack(alignment: .firstTextBaseline, spacing: 10) {
                            Text("\(index + 1)").font(.subheadline.weight(.semibold)).foregroundStyle(.secondary)
                            Text(step)
                        }
                    }
                }
            }

            if !drill.cue.isEmpty {
                Section("Swing cue") { Text(drill.cue) }
            }

            if !drill.harder.isEmpty || !drill.easier.isEmpty {
                Section("Adjust") {
                    if !drill.harder.isEmpty { LabeledContent("Harder", value: drill.harder) }
                    if !drill.easier.isEmpty { LabeledContent("Easier", value: drill.easier) }
                }
            }
        }
        .navigationTitle(drill.name)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) { KeyStarButton(drill: drill) }
        }
    }

    private var repsText: String {
        if drill.ballsPerGroup > 1 {
            let rule = drill.groupRule == .all ? "all must make" : "any one counts"
            return "\(drill.totalBalls) balls, \(drill.ballsPerGroup) per target, \(rule)"
        }
        return "\(drill.totalBalls) balls"
    }
}
