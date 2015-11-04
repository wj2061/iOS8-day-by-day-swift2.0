//: Playground - noun: a place where people can play

import UIKit

//MARK: - NSDateComponentsFormatter
let dateCompnentsFormatter = NSDateComponentsFormatter()
let components = NSDateComponents()
components.hour   = 2
components.minute = 45

let dcfStyle: [NSDateComponentsFormatterUnitsStyle] = [.Positional,.Abbreviated,.Short,.Full,.SpellOut]
for style in dcfStyle {
    dateCompnentsFormatter.unitsStyle = style
    dateCompnentsFormatter.stringFromDateComponents(components)
}

let calendar = NSCalendar.currentCalendar()
calendar.locale = NSLocale(localeIdentifier: "th-TH")
dateCompnentsFormatter.calendar = calendar
dateCompnentsFormatter.stringFromDateComponents(components)

dateCompnentsFormatter.calendar = NSCalendar.currentCalendar()
let now = NSDate()
let longTimeAgo = NSDate(timeIntervalSince1970: 0.0)
dateCompnentsFormatter.unitsStyle = .Short
dateCompnentsFormatter.stringFromDate(longTimeAgo, toDate: now)

//Extra strings
dateCompnentsFormatter.includesApproximationPhrase = true
dateCompnentsFormatter.stringFromDateComponents(components)
dateCompnentsFormatter.includesTimeRemainingPhrase = true
dateCompnentsFormatter.stringFromDateComponents(components)

//MARK: NSDateIntervalFormatter
let dateIntervalFormatter = NSDateIntervalFormatter()
let difStyle : [NSDateIntervalFormatterStyle] = [.NoStyle,.ShortStyle,.MediumStyle,.LongStyle,.FullStyle]
for style in difStyle{
    dateIntervalFormatter.dateStyle = style
    dateIntervalFormatter.timeStyle = style
    dateIntervalFormatter.stringFromDate(longTimeAgo, toDate: now)
}

//MARK: NSlengthFormatter
let lengthFormatter = NSLengthFormatter()
lengthFormatter.stringFromMeters(1.65)
let lfUnits : [NSLengthFormatterUnit] = [.Millimeter,.Centimeter,.Meter,.Kilometer,.Inch,.Yard,.Mile]
for unit in lfUnits{
    lengthFormatter.stringFromValue(15.2, unit: unit)
    lengthFormatter.unitStringFromValue(10.3, unit: unit)
}
lengthFormatter.forPersonHeightUse = true
lengthFormatter.stringFromMeters(1.65)
let unitStyles:[NSFormattingUnitStyle] = [.Short,.Medium,.Long]
for style in unitStyles{
    lengthFormatter.unitStyle = style
    lengthFormatter.stringFromValue(1.65, unit: .Meter)
}

//MARK:- NSMassFormatter
let massFormatter = NSMassFormatter()
massFormatter.stringFromKilograms(56.4)
let mfUnits: [NSMassFormatterUnit] = [.Gram,.Kilogram,.Ounce,.Pound,.Stone]
for unit in mfUnits{
    massFormatter.stringFromValue(165.2, unit: unit)
}
massFormatter.forPersonMassUse = true
massFormatter.stringFromKilograms(76.2)
for style in unitStyles{
    massFormatter.unitStyle = style
    massFormatter.stringFromValue(34.2, unit: .Kilogram)
}

//MARK: - NSEnergyFormatter
let energyFormatter = NSEnergyFormatter()
energyFormatter.stringFromJoules(42.5)
let efUnits: [NSEnergyFormatterUnit] = [.Joule,.Kilojoule,.Calorie,.Kilocalorie]
for unit in efUnits{
    energyFormatter.stringFromValue(54.2, unit: unit)
}
energyFormatter.forFoodEnergyUse = true
energyFormatter.stringFromJoules(4200)
for style in unitStyles{
    energyFormatter.unitStyle = style
    energyFormatter.stringFromValue(5.6, unit: .Kilojoule)
}

for style in unitStyles{
    energyFormatter.unitStyle = style
    energyFormatter.forFoodEnergyUse = false
    energyFormatter.stringFromValue(6.75, unit: .Kilocalorie)
    energyFormatter.forFoodEnergyUse = true
    energyFormatter.stringFromValue(6.75, unit: .Kilocalorie)
}












