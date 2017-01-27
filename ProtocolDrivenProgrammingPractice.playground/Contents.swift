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


class MotorCycle {
    var name: String
    var speed: Double

    init(name: String) {
        self.name = name
        speed = 200
    }
}

protocol Racer {
    var speed: Double { get } //Racing is all about speed
}

extension MotorCycle: Racer {
}

extension FlappyBird: Racer {
    var speed: Double {
        return airSpeedVelocity
    }
}

extension SwiftBird: Racer {
    var speed: Double {
        return airSpeedVelocity
    }
}

extension Penguin: Racer {
    var speed: Double {
        return 40
    }
}

extension UnladenSwallow: Racer {
    var speed: Double {
        return canFly ? airSpeedVelocity : 0
    }
}

let racers: [Racer] = [UnladenSwallow.african, UnladenSwallow.unknown, UnladenSwallow.european, Penguin(name: "Rico"), SwiftBird(version: 3.0), FlappyBird(name: "Private", flappyAmplitude: 10, flappyFrequency: 8), MotorCycle(name: "Bajaj Dominor 400")]

func topSpeed(of racers: [Racer]) -> Double {
    return racers.max(by: { $0.speed < $1.speed })?.speed ?? 0
}

topSpeed(of: racers)

// Our topSpeed function will not work for Sliced array of racers eg: topSpeed(of: racers[0...3]) gives an error
// We can make it more generic by using protocols

func genericTopSpeed<RacerType: Sequence>(of racers: RacerType) -> Double where RacerType.Iterator.Element == Racer {
    return racers.max(by: { $0.speed < $1.speed })?.speed ?? 0
}

genericTopSpeed(of: racers)
genericTopSpeed(of: racers[1...3])


extension Sequence where Iterator.Element == Racer {
    func topSpeed() -> Double {
        return self.max(by: { $0.speed < $1.speed })?.speed ?? 0
    }
}

racers.topSpeed()
racers[1...3].topSpeed()
