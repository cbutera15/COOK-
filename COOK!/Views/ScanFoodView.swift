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

struct ScanFoodView: View {
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
                }
            },
            onCancel: {
                // Handle the user tapping the 'Cancel' button
            },
            onError: { error in
                // Handle errors
            }
        )
    }
}

#Preview {
    ScanFoodView()
}
