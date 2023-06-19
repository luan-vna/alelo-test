import Foundation

extension Double {
    
    func toCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.numberStyle = .currency
        formatter.currencySymbol = "R$"
        formatter.decimalSeparator = ","
        return formatter.string(from: self as NSNumber) ?? "R$0,00"
    }
}
