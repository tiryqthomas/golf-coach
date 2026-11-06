import Testing
import SwiftData
@testable import GolfCoach

@MainActor
struct DataFoundationTests {
    /// A fresh in-memory store for each test. Kept as a property so the
    /// container outlives the context used in the test.
    private let container: ModelContainer

    init() throws {
        let schema = Schema(AppSchema.models)
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true, cloudKitDatabase: .none)
        container = try ModelContainer(for: schema, configurations: [config])
    }

    private func makeContext() throws -> ModelContext {
        container.mainContext
    }

    // MARK: Seed content

    @Test func seedLibraryIsValid() {
        let seeds = SeedDrills.all
        #expect(seeds.count == 16)
        #expect(Set(seeds.map(\.slug)).count == seeds.count, "Slugs must be unique")
        for seed in seeds {
            #expect(!seed.name.isEmpty)
            #expect(!seed.goal.isEmpty, "\(seed.slug) needs a goal")
            #expect(seed.passMark >= 1 && seed.passMark <= seed.groupCount, "\(seed.slug) pass mark out of range")
            #expect(!seed.steps.isEmpty, "\(seed.slug) needs steps")
            #expect(!seed.materials.isEmpty, "\(seed.slug) needs materials")
        }
    }

    @Test func everyAreaHasDrills() {
        for area in SkillArea.allCases {
            #expect(SeedDrills.all.contains { $0.area == area }, "No drills for \(area.displayName)")
        }
    }

    @Test func defaultKeyDrills() {
        let keys = Set(SeedDrills.all.filter(\.isKey).map(\.slug))
        #expect(keys == ["chip-two", "putt-gate"])
    }

    @Test func twoBallWorstBallScoresPerTarget() throws {
        let seed = try #require(SeedDrills.all.first { $0.slug == "chip-two" })
        let drill = seed.makeDrill()
        #expect(drill.ballsPerGroup == 2)
        #expect(drill.groupRule == .all)
        #expect(drill.groupCount == 6)
        #expect(drill.passMark == 4)
        #expect(drill.totalBalls == 12)
        #expect(drill.passMarkText == "4 of 6 targets")
    }

    // MARK: Seeding the store

    @Test func seedingFillsAnEmptyStore() throws {
        let context = try makeContext()
        try Seeder.seedIfNeeded(context)
        #expect(try context.fetchCount(FetchDescriptor<Drill>()) == 16)
        let progress = try context.fetch(FetchDescriptor<AreaProgress>())
        #expect(progress.count == SkillArea.allCases.count)
        #expect(progress.allSatisfy { $0.xp == 0 })
    }

    @Test func seedingTwiceDoesNotDuplicate() throws {
        let context = try makeContext()
        try Seeder.seedIfNeeded(context)
        try Seeder.seedIfNeeded(context)
        #expect(try context.fetchCount(FetchDescriptor<Drill>()) == 16)
        #expect(try context.fetchCount(FetchDescriptor<AreaProgress>()) == 6)
    }

    @Test func seedingKeepsPlayerChanges() throws {
        let context = try makeContext()
        try Seeder.seedIfNeeded(context)
        let gate = try #require(try context.fetch(FetchDescriptor<Drill>(predicate: #Predicate<Drill> { $0.slug == "putt-gate" })).first)
        gate.isKey = false
        try context.save()
        try Seeder.seedIfNeeded(context)
        #expect(gate.isKey == false, "Re-seeding must not undo the player's choice")
    }

    // MARK: Models

    @Test func passMarkIsClampedToGroupCount() {
        let drill = Drill(slug: "x", name: "X", area: .irons, level: 1, goal: "Hit it", groupCount: 5, passMark: 9)
        #expect(drill.passMark == 5)
        let low = Drill(slug: "y", name: "Y", area: .irons, level: 1, goal: "Hit it", groupCount: 5, passMark: 0)
        #expect(low.passMark == 1)
    }

    @Test func attemptsAreDeletedWithTheirDrill() throws {
        let context = try makeContext()
        let drill = Drill(slug: "t", name: "Test", area: .putting, level: 1, goal: "Hole it", groupCount: 4, passMark: 3)
        context.insert(drill)
        let attempt = DrillAttempt(results: [true, true, false, true], groupsCleared: 3, passed: true, xpEarned: 5, rating: 4, drill: drill)
        context.insert(attempt)
        try context.save()
        #expect(drill.attempts?.count == 1)

        context.delete(drill)
        try context.save()
        #expect(try context.fetchCount(FetchDescriptor<DrillAttempt>()) == 0)
    }

    @Test func ratingIsClampedToOneToFive() {
        #expect(DrillAttempt(rating: 9).rating == 5)
        #expect(DrillAttempt(rating: -2).rating == 0)
    }

    @Test func journalEntryArea() {
        #expect(JournalEntry(title: "Soft hands", area: .chipping).area == .chipping)
        #expect(JournalEntry(title: "General").area == nil)
    }
}
