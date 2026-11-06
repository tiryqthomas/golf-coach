import SwiftUI
import SwiftData

/// First screen for feature 1: the drill library, grouped by skill area.
/// Lets you check on a phone that the seeded data loads and saves.
struct DrillLibraryView: View {
    @Query(sort: \Drill.name) private var drills: [Drill]
    @State private var filter: SkillArea?
    @State private var keyOnly = false

    private struct AreaSection: Identifiable {
        let area: SkillArea
        let drills: [Drill]
        var id: SkillArea { area }
    }

    private var sections: [AreaSection] {
        SkillArea.allCases.compactMap { area in
            guard filter == nil || filter == area else { return nil }
            let items = drills
                .filter { $0.area == area && (!keyOnly || $0.isKey) }
                .sorted { lhs, rhs in
                    if lhs.isKey != rhs.isKey { return lhs.isKey }
                    return lhs.name < rhs.name
                }
            return items.isEmpty ? nil : AreaSection(area: area, drills: items)
        }
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(sections) { section in
                    Section {
                        ForEach(Array(section.drills.enumerated()), id: \.element.persistentModelID) { index, drill in
                            NavigationLink(value: drill) {
                                DrillRow(number: index + 1, drill: drill)
                            }
                        }
                    } header: {
                        Label(section.area.displayName, systemImage: "circle.fill")
                            .labelStyle(AreaLabelStyle(color: section.area.color))
                    }
                }
                if sections.isEmpty {
                    ContentUnavailableView("No drills", systemImage: "star",
                                           description: Text("Star a drill to make it a key drill."))
                }
            }
            .navigationTitle("Drills")
            .navigationDestination(for: Drill.self) { DrillDetailView(drill: $0) }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("Area", selection: $filter) {
                            Text("All areas").tag(SkillArea?.none)
                            ForEach(SkillArea.allCases) { Text($0.displayName).tag(SkillArea?.some($0)) }
                        }
                        Toggle("Key drills only", systemImage: "star", isOn: $keyOnly)
                    } label: {
                        Label("Filter", systemImage: filter == nil && !keyOnly
                              ? "line.3.horizontal.decrease.circle"
                              : "line.3.horizontal.decrease.circle.fill")
                    }
                }
            }
        }
    }
}

/// Small coloured dot before the area name, so colour is never the only cue.
private struct AreaLabelStyle: LabelStyle {
    let color: Color
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 6) {
            configuration.icon.font(.system(size: 8)).foregroundStyle(color)
            configuration.title
        }
    }
}

private struct DrillRow: View {
    let number: Int
    let drill: Drill

    var body: some View {
        HStack(spacing: 12) {
            Text("\(number)")
                .font(.footnote.weight(.semibold).monospacedDigit())
                .frame(width: 28, height: 28)
                .background(Circle().fill(drill.isKey ? Color.accentColor : Color(.tertiarySystemFill)))
                .foregroundStyle(drill.isKey ? Color.white : Color.primary)
            VStack(alignment: .leading, spacing: 2) {
                Text(drill.name).font(.body.weight(.semibold))
                Text("\(drill.summary) · Pass \(drill.passMark)/\(drill.groupCount)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer(minLength: 8)
            KeyStarButton(drill: drill)
        }
        .padding(.vertical, 4)
    }
}

/// Star toggle for key drills, with a spring bounce and a light haptic tap.
struct KeyStarButton: View {
    @Bindable var drill: Drill
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        Button {
            withAnimation(reduceMotion ? nil : .spring(response: 0.35, dampingFraction: 0.6)) {
                drill.isKey.toggle()
            }
        } label: {
            Image(systemName: drill.isKey ? "star.fill" : "star")
                .font(.title3)
                .foregroundStyle(drill.isKey ? Color.orange : Color.secondary)
                .contentTransition(.symbolEffect(.replace))
                .symbolEffect(.bounce, value: drill.isKey)
                .frame(width: 44, height: 44)
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .sensoryFeedback(.selection, trigger: drill.isKey)
        .accessibilityLabel(drill.isKey ? "Remove from key drills" : "Mark as key drill")
    }
}
