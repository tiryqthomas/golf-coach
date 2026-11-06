import Foundation
import SwiftData

/// One completed run of a drill. Each ball is stored as made (true) or
/// missed (false), in the order it was hit.
@Model
final class DrillAttempt {
    var date: Date = Date.now
    var results: [Bool] = []
    var groupsCleared: Int = 0
    var passed: Bool = false
    var xpEarned: Int = 0
    /// Drill review, 1 (Disliked) to 5 (Liked). 0 means not reviewed.
    var rating: Int = 0
    var note: String = ""
    var drill: Drill?

    init(date: Date = .now, results: [Bool] = [], groupsCleared: Int = 0,
         passed: Bool = false, xpEarned: Int = 0, rating: Int = 0,
         note: String = "", drill: Drill? = nil) {
        self.date = date
        self.results = results
        self.groupsCleared = groupsCleared
        self.passed = passed
        self.xpEarned = xpEarned
        self.rating = min(max(0, rating), 5)
        self.note = note
        self.drill = drill
    }
}

/// Running XP total for one skill area. The area's level is derived from it.
@Model
final class AreaProgress {
    var areaRaw: String = SkillArea.putting.rawValue
    var xp: Int = 0

    init(area: SkillArea, xp: Int = 0) {
        self.areaRaw = area.rawValue
        self.xp = max(0, xp)
    }

    var area: SkillArea { SkillArea(rawValue: areaRaw) ?? .putting }
}

/// A swing thought or reflection in the Journal tab.
@Model
final class JournalEntry {
    var date: Date = Date.now
    var title: String = ""
    var body: String = ""
    /// Empty when the entry isn't tied to an area.
    var areaRaw: String = ""
    var isPinned: Bool = false
    /// Slugs of drills this entry mentions.
    var linkedDrillSlugs: [String] = []

    init(date: Date = .now, title: String = "", body: String = "",
         area: SkillArea? = nil, isPinned: Bool = false, linkedDrillSlugs: [String] = []) {
        self.date = date
        self.title = title
        self.body = body
        self.areaRaw = area?.rawValue ?? ""
        self.isPinned = isPinned
        self.linkedDrillSlugs = linkedDrillSlugs
    }

    var area: SkillArea? { SkillArea(rawValue: areaRaw) }
}

/// Every model the app stores, in one place for the container and tests.
enum AppSchema {
    static let models: [any PersistentModel.Type] = [
        Drill.self, DrillAttempt.self, AreaProgress.self, JournalEntry.self,
    ]
}
