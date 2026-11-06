# Golf Coach

An iPhone app that coaches your golf practice: it prescribes today's drills,
logs every rep as made or missed, turns scores into XP per skill area, and
shows whether your practice is working.

Built with SwiftUI and SwiftData. No account or server; data stays on the
phone (iCloud sync comes later).

## Run it on your iPhone

You need a Mac with Xcode 16 or later. No paid developer account is needed
for this.

1. Clone this repo and open `GolfCoach.xcodeproj` in Xcode.
2. Click the **GolfCoach** project in the left sidebar, choose the
   **GolfCoach** target, and open **Signing & Capabilities**.
3. Under **Team**, choose your Apple ID (add it with **Add an Account…**
   if it's not listed). This creates a free "Personal Team".
4. If Xcode says the bundle identifier is taken, change
   `com.tiryqthomas.golfcoach` to something unique, such as
   `com.yourname.golfcoach`.
5. Plug in your iPhone (or pair it over Wi-Fi), pick it in the device menu
   at the top of Xcode, and press **Run** (⌘R).
6. The first time, your iPhone will block the app. Go to **Settings →
   General → VPN & Device Management**, tap your Apple ID and choose
   **Trust**. You may also need to turn on **Developer Mode** in
   **Settings → Privacy & Security**.

Apps installed with a free Personal Team stop opening after 7 days. Run it
from Xcode again to refresh it.

## Run the tests

In Xcode press ⌘U (Product → Test). The tests use an in-memory store, so
they never touch the data on your phone.

## Build order

Built one feature at a time, each in its own pull request with tests:

1. **Data foundation**: drill, attempt, area XP and journal models, plus the
   16 starter drills
2. Scoring engine
3. Session logging
4. Results
5. Levels and XP
6. Prescription
7. Home screen
8. History

The clickable design prototype these screens follow is linked in the
project notes.
