protocol Bird {
    var name: String { get }
    var canFly: Bool { get }
}

protocol Flyable {
    var airSpeedVelocity: Double { get }
}

struct FlappyBird: Bird, Flyable {
    let name: String
    let flappyAmplitude: Double
    let flappyFrequency: Double
    let canFly = true

    var airSpeedVelocity: Double {
        return 3 * flappyFrequency + flappyAmplitude
    }
}

struct Penguin: Bird {
    let name: String
    let canFly = false
}

struct SwiftBird: Bird, Flyable {
    var name: String { return "Swift \(version)" }
    let version: Double
    let canFly = true

    var airSpeedVelocity: Double {
        return version * 1000.0
    }
}
