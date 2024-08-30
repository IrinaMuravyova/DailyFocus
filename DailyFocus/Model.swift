//
//  Model.swift
//  DailyFocus
//
//  Created by Irina Muravyeva on 28.08.2024.
//

struct Habit {
    let habit: String
    let howManyDays: Int
    let howManyTimesADay: Int
    let progress: Float
    
    static func getHabitsList() -> [Habit] {
        [
            Habit(habit: "Заниматься английским", howManyDays: 365, howManyTimesADay: 1, progress: 10),
            Habit(habit: "Делать тело", howManyDays: 90, howManyTimesADay: 1, progress: 1),
            Habit(habit: "Читать", howManyDays: 100, howManyTimesADay: 1, progress: 70)
        ]
    }
}

struct Pill {
    let type: PillsType
    let pillName: String
    let dose: Int?
    let measureUnit: MeasureUnits?
    let howManyDoses: Int
    let howManyDays: Int
    let timesADay: Int
    let wayToEat: WaysToEatPills
    let image: String
    var description: String {
        dose == nil
        ? "Принять \(howManyDoses) \(type.rawValue) \(wayToEat.rawValue)"
        : "\(dose!) \(measureUnit!.rawValue), принять \(howManyDoses) \(type.rawValue) \(wayToEat.rawValue)"
    }
    
    static func getPillsList() -> [Pill] {
        [
            Pill(
                type: .pill,
                pillName: "Эутирокс",
                dose: 100,
                measureUnit: .mcg,
                howManyDoses: 1,
                howManyDays: 60,
                timesADay: 1,
                wayToEat: .duringEat,
                image: "IMG_0880"
            ),
            Pill(
                type: .drop,
                pillName: "Витамин Д",
                dose: nil,
                measureUnit: nil,
                howManyDoses: 2,
                howManyDays: 30,
                timesADay: 1,
                wayToEat: .afterEat,
                image: "IMG_0876"
            ),
            Pill(
                type: .capsule,
                pillName: "Урдокса",
                dose: 2,
                measureUnit: .piece,
                howManyDoses: 3,
                howManyDays: 90,
                timesADay: 2,
                wayToEat: .beforeEat,
                image: "IMG_0879"
            )
        ]
    }
}

struct Task {
    let textOfTask: String
    let done: Bool
    
    static func getTasksList() -> [Task] {
        [
            Task(textOfTask: "Прибрать в комнате", done: false),
            Task(textOfTask: "Собрать чемодан", done: false)
        ]
    }
}

// TODO: дополнить список измерений, возможно есть какой-то стандартизованный справочник в инете
enum PillsType: String {
    case pill = "пилюля(и)"
    case capsule = "капсулу(ы)"
    case drop = "капля(и)"
    case elixir = "порцию"
}


enum WaysToEatPills: String {
    case onEmptyStomach = "натощак"
    case beforeEat = "до еды"
    case duringEat = "во время еды"
    case afterEat = "после еды"
}

// TODO: дополнить список измерений, возможно есть какой-то стандартизованный справочник в инете
enum MeasureUnits: String {
    case mcg = "мкг"
    case mg = "мг"
    case ml = "мл"
    case g = "г"
    case piece = "шт"
}
