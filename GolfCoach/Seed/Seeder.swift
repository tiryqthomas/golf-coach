import Foundation
import SwiftData

/// Fills an empty store with the starter drills and one XP record per area.
/// Safe to call on every launch: it only adds what is missing.
enum Seeder {
    @MainActor
    static func seedIfNeeded(_ context: ModelContext) throws {
        let existing = try context.fetch(FetchDescriptor<Drill>())
        let existingSlugs = Set(existing.map(\.slug))
        for seed in SeedDrills.all where !existingSlugs.contains(seed.slug) {
            context.insert(seed.makeDrill())
        }

        let progress = try context.fetch(FetchDescriptor<AreaProgress>())
        let areasWithProgress = Set(progress.map(\.areaRaw))
        for area in SkillArea.allCases where !areasWithProgress.contains(area.rawValue) {
            context.insert(AreaProgress(area: area))
        }

        if context.hasChanges {
            try context.save()
        }
    }
}
