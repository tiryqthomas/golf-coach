import SwiftUI
import SwiftData

@main
struct GolfCoachApp: App {
    let container: ModelContainer

    init() {
        let schema = Schema(AppSchema.models)
        // Local storage for now. iCloud sync is switched on later, once there is
        // a paid Apple Developer account (CloudKit needs one).
        let config = ModelConfiguration(schema: schema, cloudKitDatabase: .none)
        do {
            container = try ModelContainer(for: schema, configurations: [config])
            try Seeder.seedIfNeeded(container.mainContext)
        } catch {
            fatalError("Could not open the data store: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            DrillLibraryView()
                .preferredColorScheme(.dark)
        }
        .modelContainer(container)
    }
}
