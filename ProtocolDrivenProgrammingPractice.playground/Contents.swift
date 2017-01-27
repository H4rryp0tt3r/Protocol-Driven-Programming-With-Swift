protocol Bird: CustomStringConvertible {
    var name: String { get }
    var canFly: Bool { get }
}

extension Bird {
    var canFly: Bool {
        return self is Flyable
    }
}

extension CustomStringConvertible where Self: Bird {
    var description: String {
        return canFly ? "I can fly" : "Guess I'll just sit here :["
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

let parrot = FlappyBird(name: "Parrot", flappyAmplitude: 10, flappyFrequency: 8)
parrot.canFly

let penguin = Penguin(name: "Kowalski")
penguin.canFly

let swiftBird = SwiftBird(version: 10)
swiftBird.canFly


enum UnladenSwallow: Bird, Flyable {
    case african
    case european
    case unknown

    var name: String {
        switch self {
            case .african:
                return "african"
            case .european:
                return "european"
            case .unknown:
                return "What do you mean? African or European?"
        }
    }

    var airSpeedVelocity: Double {
        switch self {
            case .african:
                return 10.0
            case .european:
                return 9.9
            case .unknown:
                return 0
        }
    }
}

extension UnladenSwallow {
    var canFly: Bool {
        return self != .unknown
    }
}

UnladenSwallow.african.canFly
UnladenSwallow.european.canFly
UnladenSwallow.unknown.canFly


String(describing: swiftBird)
String(describing: penguin)
String(describing: UnladenSwallow.african)
String(describing: UnladenSwallow.unknown)
