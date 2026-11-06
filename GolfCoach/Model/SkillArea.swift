import SwiftUI

/// The six skill areas the app trains. Raw values are stored in SwiftData,
/// so never rename a case's raw value once data exists on a device.
enum SkillArea: String, Codable, CaseIterable, Identifiable, Sendable {
    case putting
    case chipping
    case wedges
    case irons
    case fairwayWoods
    case driver

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .putting: "Putting"
        case .chipping: "Chipping"
        case .wedges: "Wedges"
        case .irons: "Irons"
        case .fairwayWoods: "Fairway woods"
        case .driver: "Driver"
        }
    }

    /// Each area's colour, matching the skill radar in the prototype.
    var color: Color {
        switch self {
        case .putting: .green
        case .chipping: .blue
        case .wedges: .orange
        case .irons: .purple
        case .fairwayWoods: .pink
        case .driver: .cyan
        }
    }
}
