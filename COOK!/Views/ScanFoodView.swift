//
//  ScanFoodView.swift
//  COOK!
//
//  Created by Sam Zimpfer on 10/8/25.
//

//import SwiftUI
//
//struct ScanFoodView: View {
//    var body: some View {
//        Text("Scan Food View")
//    }
//}
import SwiftUI
import ScanbotBarcodeScannerSDK
import Foundation

let apiKey = "jh0sti0c5bwgwztufq522r91s54l4r"

func getProductName(_ barcode: String) async -> String? {
    guard let url = URL(string: "https://api.barcodelookup.com/v3/products?barcode=\(barcode)&formatted=y&key=\(apiKey)"),
          let (data, _) = try? await URLSession.shared.data(from: url),
          let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
          let products = json["products"] as? [[String: Any]],
          let firstProduct = products.first,
          let productName = firstProduct["title"] as? String else {
        return nil
    }
    return productName
}

struct ScanFoodView: View {
    @EnvironmentObject var appState: AppState
    
    @State private var addToPantryList: [Ingredient] = []
    
    let configuration: SBSDKUI2BarcodeScannerScreenConfiguration = {
        let config = SBSDKUI2BarcodeScannerScreenConfiguration()
        let usecase = SBSDKUI2MultipleScanningMode()
        usecase.arOverlay.visible = true
        config.useCase = usecase
        return config
    }()

    var body: some View {
        SBSDKUI2BarcodeScannerView(
            configuration: configuration,
            onSubmit: { (result: SBSDKUI2BarcodeScannerUIResult?) in
                if let result = result {
                    guard !result.items.isEmpty else {
                        print("No barcode found")
                        return
                    }
                    for barcodeItem in result.items {
                        let format = barcodeItem.barcode.format.name
                        let value = barcodeItem.barcode.textWithExtension
                        print("\(format): \(value)")
                    }
                    Task {
                        for barcodeItem in result.items {
                            let code = barcodeItem.barcode.text
                            if let itemName = await getProductName(code) {
                                print("Fetched product name for \(code): \(itemName)")
                                appState.addToPantry([Ingredient(name: itemName, quantity: 1)])
                            } else {
                                print("No product name found for \(code)")
                            }
                        }
                    }
                }
            },
            onCancel: {
                // do nothing
            },
            onError: { error in
                print("Unexpected error: \(error, default: "Unknown Error")")
            }
        )
    }
}

#Preview {
    ScanFoodView()
}
