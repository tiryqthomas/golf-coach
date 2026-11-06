import Foundation

/// A drill as shipped with the app. Converted to a `Drill` model on first launch.
struct SeedDrill: Sendable {
    let slug: String
    let name: String
    let area: SkillArea
    let level: Int
    let goal: String
    let summary: String
    let ballsPerGroup: Int
    let groupRule: GroupRule
    let groupCount: Int
    let passMark: Int
    let steps: [String]
    let materials: [String]
    let warmUp: String
    let cue: String
    let harder: String
    let easier: String
    let isKey: Bool

    func makeDrill() -> Drill {
        Drill(slug: slug, name: name, area: area, level: level, goal: goal, summary: summary,
              ballsPerGroup: ballsPerGroup, groupRule: groupRule, groupCount: groupCount, passMark: passMark,
              steps: steps, materials: materials, warmUp: warmUp, cue: cue, harder: harder, easier: easier,
              isKey: isKey)
    }
}

/// The starter drill library (16 drills across six areas).
/// "Two ball, worst ball" and "Gate drill" start as key drills.
enum SeedDrills {
    static let all: [SeedDrill] = [
        SeedDrill(
            slug: "putt-clock", name: "Around the clock", area: .putting, level: 3,
            goal: "Hole the putt from 4 ft",
            summary: "8 balls at 4 ft",
            ballsPerGroup: 1, groupRule: .all, groupCount: 8, passMark: 6,
            steps: ["Place eight balls in a circle 4 ft from the hole.", "Putt each ball in turn.", "Start again after any miss if you want a streak."],
            materials: ["8 balls", "Putter", "Tees or coins to mark the circle"],
            warmUp: "Roll five 10 ft putts for pace only, then five from 4 ft.",
            cue: "Quiet hands through impact.",
            harder: "Move the circle to 5 ft.",
            easier: "Move the circle to 3 ft.",
            isKey: false
        ),
        SeedDrill(
            slug: "putt-gate", name: "Gate drill", area: .putting, level: 3,
            goal: "Roll the ball through the gate",
            summary: "10 balls, 3 ft",
            ballsPerGroup: 1, groupRule: .all, groupCount: 10, passMark: 8,
            steps: ["Set two tees a ball-width plus a hair apart.", "Putt through the gate from 3 ft.", "Count only clean passes."],
            materials: ["10 balls", "2 tees", "Putter"],
            warmUp: "Roll five putts through the gate from 2 ft.",
            cue: "Roll it through the middle.",
            harder: "Narrow the gate.",
            easier: "Widen the gate.",
            isKey: true
        ),
        SeedDrill(
            slug: "putt-ladder", name: "Lag ladder", area: .putting, level: 3,
            goal: "Finish within 3 ft of the hole",
            summary: "9 balls at 20, 30 and 40 ft",
            ballsPerGroup: 1, groupRule: .all, groupCount: 9, passMark: 6,
            steps: ["Mark stations at 20, 30 and 40 ft.", "Putt three balls from each station.", "Count a ball only if it finishes within 3 ft."],
            materials: ["9 balls", "Putter", "Tees to mark 20, 30 and 40 ft"],
            warmUp: "Roll three putts from each station for pace only.",
            cue: "Feel the distance, not the line.",
            harder: "Reduce the circle to 2 ft.",
            easier: "Increase the circle to 4 ft.",
            isKey: false
        ),
        SeedDrill(
            slug: "putt-369", name: "Three, six, nine", area: .putting, level: 3,
            goal: "Hole the putt",
            summary: "9 putts at 3, 6 and 9 ft",
            ballsPerGroup: 1, groupRule: .all, groupCount: 9, passMark: 6,
            steps: ["Place three balls each at 3, 6 and 9 ft.", "Putt closest first, then farther out.", "A putt counts only if it drops."],
            materials: ["9 balls", "Putter", "Tees to mark 3, 6 and 9 ft"],
            warmUp: "Make five putts from 2 ft, then roll three from 9 ft.",
            cue: "Same routine on every putt.",
            harder: "Start at 4 ft.",
            easier: "Start at 2 ft.",
            isKey: false
        ),
        SeedDrill(
            slug: "chip-two", name: "Two ball, worst ball", area: .chipping, level: 2,
            goal: "Finish within 5 ft of the target",
            summary: "Six targets, two balls each",
            ballsPerGroup: 2, groupRule: .all, groupCount: 6, passMark: 4,
            steps: ["Place six targets around the green at different distances.", "Hit two balls to the first target, then move to the next.", "A target clears only if both balls finish within 5 ft."],
            materials: ["6 targets (towels or tees)", "12 balls", "Wedge"],
            warmUp: "Chip five easy balls to one target for landing spot only. Not scored.",
            cue: "Pick the landing spot, then let it roll.",
            harder: "Move two targets 3 ft farther away.",
            easier: "Move two targets 3 ft closer.",
            isKey: true
        ),
        SeedDrill(
            slug: "chip-scales", name: "Scales", area: .chipping, level: 2,
            goal: "Finish within 6 ft of the hole",
            summary: "10 balls, mixed trajectory",
            ballsPerGroup: 1, groupRule: .all, groupCount: 10, passMark: 6,
            steps: ["Pick a hole 12 yd away.", "Alternate low, medium and high chips.", "Change the shot before every ball."],
            materials: ["10 balls", "1 hole or flag", "Pitching wedge and sand wedge"],
            warmUp: "Hit three low chips and three high chips to find your landing spots.",
            cue: "Match the shot to the landing spot.",
            harder: "Reduce the circle to 5 ft.",
            easier: "Increase the circle to 8 ft.",
            isKey: false
        ),
        SeedDrill(
            slug: "chip-zone", name: "Landing zone", area: .chipping, level: 2,
            goal: "Land inside the towel, then roll out",
            summary: "8 balls, one towel",
            ballsPerGroup: 1, groupRule: .all, groupCount: 8, passMark: 5,
            steps: ["Lay a towel 6 ft in front of the ball.", "Chip so the ball lands on the towel.", "Note how far it rolls out."],
            materials: ["8 balls", "1 towel", "1 hole or flag"],
            warmUp: "Chip four balls to a bare spot, then four to the towel.",
            cue: "Land it on the towel.",
            harder: "Use a smaller towel.",
            easier: "Use a larger towel.",
            isKey: false
        ),
        SeedDrill(
            slug: "chip-bump", name: "Bump and run ladder", area: .chipping, level: 2,
            goal: "Finish within 6 ft of the hole",
            summary: "8 balls, three clubs",
            ballsPerGroup: 1, groupRule: .all, groupCount: 8, passMark: 5,
            steps: ["Stand 8 yd off the green with a hole 15 yd away.", "Hit two balls each with an 8 iron, a pitching wedge and a sand wedge.", "Pick the club before every ball and say why."],
            materials: ["8 balls", "8 iron, pitching wedge, sand wedge", "1 hole or flag"],
            warmUp: "Hit three bump and runs with each club, no target.",
            cue: "Low and running when you can.",
            harder: "Move the hole to 20 yd.",
            easier: "Move the hole to 12 yd.",
            isKey: false
        ),
        SeedDrill(
            slug: "wedge-ladder", name: "Distance ladder", area: .wedges, level: 3,
            goal: "Finish within 10 yd of the target",
            summary: "9 balls, three distances",
            ballsPerGroup: 1, groupRule: .all, groupCount: 9, passMark: 6,
            steps: ["Pick targets at 50, 70 and 90 yd.", "Hit three balls to each, nearest first.", "Use the same tempo for every shot."],
            materials: ["9 balls", "Targets at 50, 70 and 90 yd", "Range finder"],
            warmUp: "Hit five half swings to 40 yd, then five three-quarter swings.",
            cue: "Same tempo, different length.",
            harder: "Reduce the zone to 8 yd.",
            easier: "Increase the zone to 12 yd.",
            isKey: false
        ),
        SeedDrill(
            slug: "wedge-clock", name: "Clock system", area: .wedges, level: 3,
            goal: "Carry to within 8 yd of the number",
            summary: "8 balls, four swing lengths",
            ballsPerGroup: 1, groupRule: .all, groupCount: 8, passMark: 5,
            steps: ["Choose hip-high, belt-high, chest-high and full swings.", "Hit two balls at each length and note the carry.", "Call the distance before each ball."],
            materials: ["8 balls", "Sand wedge or lob wedge", "Range finder"],
            warmUp: "Hit six easy hip-high swings, then six belt-high swings.",
            cue: "Length of swing sets the distance.",
            harder: "Reduce the zone to 6 yd.",
            easier: "Increase the zone to 10 yd.",
            isKey: false
        ),
        SeedDrill(
            slug: "iron-target", name: "Target dispersion", area: .irons, level: 3,
            goal: "Finish within 15 yd of the target",
            summary: "10 balls, one target",
            ballsPerGroup: 1, groupRule: .all, groupCount: 10, passMark: 6,
            steps: ["Pick a target 150 yd away.", "Pick a new line before each ball.", "Mark each result before the next shot."],
            materials: ["10 balls", "1 target at 150 yd", "Range finder"],
            warmUp: "Hit five easy wedges, then five 8 irons at 80% effort.",
            cue: "Finish tall, belt buckle to target.",
            harder: "Reduce the zone to 12 yd.",
            easier: "Increase the zone to 18 yd.",
            isKey: false
        ),
        SeedDrill(
            slug: "iron-gap", name: "Gapping check", area: .irons, level: 3,
            goal: "Carry within 5 yd of your club number",
            summary: "10 balls, 7 iron to pitching wedge",
            ballsPerGroup: 1, groupRule: .all, groupCount: 10, passMark: 6,
            steps: ["Pick a club and write down its expected carry.", "Hit two balls with each of five clubs.", "Count balls that carry within 5 yd of the number."],
            materials: ["10 balls", "7 iron to pitching wedge", "Range finder"],
            warmUp: "Hit six half swings with a wedge, then four with a 7 iron.",
            cue: "Smooth tempo, same strike.",
            harder: "Reduce the window to 4 yd.",
            easier: "Increase the window to 7 yd.",
            isKey: false
        ),
        SeedDrill(
            slug: "fw-finder", name: "Fairway wood finder", area: .fairwayWoods, level: 3,
            goal: "Finish in a 40 yd fairway",
            summary: "10 balls, 40 yd fairway",
            ballsPerGroup: 1, groupRule: .all, groupCount: 10, passMark: 6,
            steps: ["Mark a 40 yd wide fairway.", "Hit from a tee, then from the turf.", "Count balls that finish in the fairway."],
            materials: ["10 balls", "Markers for a 40 yd fairway", "Fairway wood and tee"],
            warmUp: "Hit five easy 7 irons, then five fairway woods at 70% effort.",
            cue: "Sweep it, don’t lift it.",
            harder: "Narrow the fairway to 35 yd.",
            easier: "Widen the fairway to 45 yd.",
            isKey: false
        ),
        SeedDrill(
            slug: "fw-turf", name: "Turf contact", area: .fairwayWoods, level: 3,
            goal: "Brush the turf just after the ball",
            summary: "8 balls from the turf",
            ballsPerGroup: 1, groupRule: .all, groupCount: 8, passMark: 5,
            steps: ["Draw a line on the turf 1 in. behind each ball.", "Hit from the turf with a fairway wood.", "Count shots where the club marks the turf at or just after the ball."],
            materials: ["8 balls", "Fairway wood", "Chalk or a tee to mark the line"],
            warmUp: "Brush the turf with five easy practice swings, then hit three at 70%.",
            cue: "Sweep it low and long.",
            harder: "Use a tighter lie.",
            easier: "Tee the ball low.",
            isKey: false
        ),
        SeedDrill(
            slug: "drv-fairway", name: "Fairway finder", area: .driver, level: 3,
            goal: "Finish in a 30 yd fairway",
            summary: "14 balls, 30 yd fairway",
            ballsPerGroup: 1, groupRule: .all, groupCount: 14, passMark: 9,
            steps: ["Mark a 30 yd wide fairway at 230 yd.", "Pick a start line before every ball.", "Count balls that finish in the fairway."],
            materials: ["14 balls", "Markers for a 30 yd fairway", "Driver and tees", "Range finder"],
            warmUp: "Take six easy swings, then hit five drivers at 70% effort.",
            cue: "Pick the start line, then swing through it.",
            harder: "Narrow the fairway to 27 yd.",
            easier: "Widen the fairway to 33 yd.",
            isKey: false
        ),
        SeedDrill(
            slug: "drv-line", name: "Start line gate", area: .driver, level: 3,
            goal: "Start the ball through the gate",
            summary: "10 balls, gate at 20 yd",
            ballsPerGroup: 1, groupRule: .all, groupCount: 10, passMark: 6,
            steps: ["Place two markers 6 yd apart, 20 yd ahead.", "Pick a start line through the gate.", "Count balls that start through the gate."],
            materials: ["10 balls", "2 markers", "Driver and tees"],
            warmUp: "Take six easy swings, then hit four drivers at 70% effort.",
            cue: "Commit to the start line.",
            harder: "Narrow the gate to 5 yd.",
            easier: "Widen the gate to 8 yd.",
            isKey: false
        ),
    ]
}
