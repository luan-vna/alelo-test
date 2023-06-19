import Foundation

struct Database {
    
    static var shared: Database = {
       let instance = Database()
       return instance
    }()
    
    //REPRESENTACAO DO BANCO DE DADOS LOCAL NO MUNDO REAL
    var products: [BagItem] = []
}
