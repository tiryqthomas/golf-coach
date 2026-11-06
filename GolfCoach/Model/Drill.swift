import Foundation
import SwiftData

/// How a group of balls (for example, two balls to one target) clears.
enum GroupRule: String, Codable, CaseIterable, Sendable {
    /// Every ball in the group must make it ("worst ball").
    case all
    /// Any one ball in the group is enough ("best ball").
    case any
}

/// A practice drill. Every rep is logged as made or missed against one goal.
///
/// Scoring counts groups, not balls: a drill has `groupCount` groups of
/// `ballsPerGroup` balls each. Single-ball drills simply use groups of one.
/// The pass mark is the minimum number of cleared groups needed to earn XP.
///
/// All stored properties have defaults and the relationship is optional so the
/// model stays compatible with iCloud (CloudKit) sync when that is switched on.
@Model
final class Drill {
    /// Stable identifier for seeded drills (for example "putt-gate").
    var slug: String = ""
    var name: String = ""
    var areaRaw: String = SkillArea.putting.rawValue
    /// Difficulty level the drill is pitched at (1 = Foundation).
    var level: Int = 1
    /// The one goal every rep is judged against.
    var goal: String = ""
    /// One-line summary, for example "10 balls, 3 ft".
    var summary: String = ""
    var ballsPerGroup: Int = 1
    var groupRuleRaw: String = GroupRule.all.rawValue
    var groupCount: Int = 10
    var passMark: Int = 6
    var steps: [String] = []
    var materials: [String] = []
    var warmUp: String = ""
    var cue: String = ""
    var harder: String = ""
    var easier: String = ""
    /// Marked by the player as a key drill (prioritised, x1.5 XP).
    var isKey: Bool = false
    var isCustom: Bool = false
    var createdAt: Date = Date.now

    @Relationship(deleteRule: .cascade, inverse: \DrillAttempt.drill)
    var attempts: [DrillAttempt]? = []

    init(
        slug: String,
        name: String,
        area: SkillArea,
        level: Int,
        goal: String,
        summary: String = "",
        ballsPerGroup: Int = 1,
        groupRule: GroupRule = .all,
        groupCount: Int,
        passMark: Int,
        steps: [String] = [],
        materials: [String] = [],
        warmUp: String = "",
        cue: String = "",
        harder: String = "",
        easier: String = "",
        isKey: Bool = false,
        isCustom: Bool = false
    ) {
        self.slug = slug
        self.name = name
        self.areaRaw = area.rawValue
        self.level = level
        self.goal = goal
        self.summary = summary
        self.ballsPerGroup = max(1, ballsPerGroup)
        self.groupRuleRaw = groupRule.rawValue
        self.groupCount = max(1, groupCount)
        self.passMark = min(max(1, passMark), max(1, groupCount))
        self.steps = steps
        self.materials = materials
        self.warmUp = warmUp
        self.cue = cue
        self.harder = harder
        self.easier = easier
        self.isKey = isKey
        self.isCustom = isCustom
    }

    var area: SkillArea {
        get { SkillArea(rawValue: areaRaw) ?? .putting }
        set { areaRaw = newValue.rawValue }
    }

    var groupRule: GroupRule {
        get { GroupRule(rawValue: groupRuleRaw) ?? .all }
        set { groupRuleRaw = newValue.rawValue }
    }

    /// Total balls hit in one run of the drill.
    var totalBalls: Int { groupCount * ballsPerGroup }

    /// What the pass mark counts: "targets" for multi-ball groups, else "balls".
    var unitLabel: String { ballsPerGroup > 1 ? "targets" : "balls" }

    /// For example "8 of 10 balls".
    var passMarkText: String { "\(passMark) of \(groupCount) \(unitLabel)" }
}
