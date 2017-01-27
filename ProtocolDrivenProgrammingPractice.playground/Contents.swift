protocol Bird {
    var name: String { get }
    var canFly: Bool { get }
}

extension Bird {
    var canFly: Bool {
        return self is Flyable
    }
}

protocol Flyable {
    var airSpeedVelocity: Double { get }
}

struct FlappyBird: Bird, Flyable {
    let name: String
    let flappyAmplitude: Double
    let flappyFrequency: Double

    var airSpeedVelocity: Double {
        return 3 * flappyFrequency + flappyAmplitude
    }
}

struct Penguin: Bird {
    let name: String
}

struct SwiftBird: Bird, Flyable {
    var name: String { return "Swift \(version)" }
    let version: Double

    var airSpeedVelocity: Double {
        return version * 1000.0
    }
}
