import XCTest

final class CatalogUITests: XCTestCase {

    func testInsertingProductOnCart() throws {
        let app = XCUIApplication()
        app.launch()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["R$ 199,90"]/*[[".cells.staticTexts[\"R$ 199,90\"]",".staticTexts[\"R$ 199,90\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Adicionar"].tap()
    }

    func testRemovingProductOnCart() throws {
        let app = XCUIApplication()
        app.launch()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["R$ 199,90"]/*[[".cells.staticTexts[\"R$ 199,90\"]",".staticTexts[\"R$ 199,90\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Adicionar"].tap()
        let adicionarStaticText = app/*@START_MENU_TOKEN@*/.staticTexts["Adicionar"]/*[[".buttons[\"Adicionar\"].staticTexts[\"Adicionar\"]",".staticTexts[\"Adicionar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        adicionarStaticText.tap()
        let removerStaticText = app/*@START_MENU_TOKEN@*/.staticTexts["Remover"]/*[[".buttons[\"Remover\"].staticTexts[\"Remover\"]",".staticTexts[\"Remover\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        removerStaticText.tap()
    }
    
    func testListOnSaleItems() throws {
        let app = XCUIApplication()
        app.launch()
        XCUIApplication().navigationBars["Nosso catálogo"].buttons["Flame"].tap()
    }
    
    func testListEmptyCard() throws {
        let app = XCUIApplication()
        app.launch()
        XCUIApplication().navigationBars["Nosso catálogo"].buttons["shopping bag"].tap()
    }
}
