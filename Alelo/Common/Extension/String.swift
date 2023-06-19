import Foundation

extension String {
    
    func toDouble() -> Double {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.numberStyle = .currency
        formatter.currencySymbol = "R$ "
        formatter.decimalSeparator = ","
        return (formatter.number(from: self) as? Double) ?? 0
    }
}
