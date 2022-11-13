//
//  ViewController.swift
//  TimeAndCurrencyConverter
//
//  Created by Michael Leveton on 11/13/22.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBSegueAction func viewControllerToSwiftUIView(_ coder: NSCoder) -> UIViewController? {
        let homeView = SwiftUIView()
        return HomeViewHostingController(coder: coder, rootView: homeView)
    }
    
}

class HomeViewHostingController: UIHostingController<SwiftUIView> {}

struct SwiftUIView: View {
    @State public var pesoText = ""
    @State public var dollarText = ""
    
    var body: some View {
        let today = Date()
        if let PSTDate = Calendar.current.date(byAdding: .hour, value: -5, to: today) {
            VStack {
                Text("PST")
                Text(PSTDate, format: .dateTime.hour().minute())
            }
            .padding()
        }
        
        if let ESTDate = Calendar.current.date(byAdding: .hour, value: -2, to: today) {
            VStack {
                Text("EST")
                Text(ESTDate, format: .dateTime.hour().minute())
            }
            .padding()
        }
        
        VStack {
            Text("Dollar amount")
                .padding()
            Text(dollarText)
            if dollarText.count > 0 {
                Text("Peso Amount")
                    .padding()
            }
            TextField("Enter Argentine Peso", text: $pesoText)
                .onChange(of: pesoText) { _ in
                    if let peso = Float(pesoText) {
                        let conversion = peso * 0.0063
                        let roundedValue = round(conversion * 100) / 100.0
                        dollarText = String(roundedValue)
                    } else {
                        dollarText = ""
                    }
                }
                .disableAutocorrection(true)
                .multilineTextAlignment(.center)
        }
        .padding()
        
        //Text(Date.now, format: .dateTime.hour().minute())
        
            
    }
}

