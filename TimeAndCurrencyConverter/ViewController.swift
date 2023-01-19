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
   @State public var newCurrencyText = ""
   @State public var dollarText = ""
   @State public var argentinaDollarText = ""
    
    var body: some View {
      let today = Date()
      
      ScrollView {
        LazyVStack {
          if let PSTDate = Calendar.current.date(byAdding: .hour, value: -3, to: today) {
              VStack {
                  Text("PST")
                  Text(PSTDate, format: .dateTime.hour().minute())
              }
              .padding()
          }
          
          if let ESTDate = Calendar.current.date(byAdding: .hour, value: 0, to: today) {
              VStack {
                  Text("EST")
                  Text(ESTDate, format: .dateTime.hour().minute())
              }
              .padding()
          }
          
          if let UTCDate = Calendar.current.date(byAdding: .hour, value: +5, to: today) {
              VStack {
                  Text("UTC")
                  Text(UTCDate, format: .dateTime.hour().minute())
              }
              .padding()
          }
          
          if let BairesDate = Calendar.current.date(byAdding: .hour, value: +2, to: today) {
              VStack {
                  Text("Buenos Aires")
                  Text(BairesDate, format: .dateTime.hour().minute())
              }
              .padding()
          }
          

        
          Text("Dollar amount (PEN/3.83)")
          Text(dollarText)
          if dollarText.count > 0 {
              Text("Peruvian Sol Amount")
          }
        
          TextField("Enter Peruvian Sol", text: $newCurrencyText)
              .onChange(of: newCurrencyText) { _ in
                  if let newCurrency = Float(newCurrencyText) {
                    let conversion = newCurrency / 3.83
                    let roundedValue = round(conversion * 100) / 100.0
                    
                    let argentinaConversion = newCurrency / 27.51
                    let argentinaRoundedValue = round(argentinaConversion * 100) / 100.0
                    
                    dollarText = String(roundedValue)
                    argentinaDollarText = String(argentinaRoundedValue)
                  } else {
                    dollarText = ""
                    argentinaDollarText = ""
                  }
              }
              .disableAutocorrection(true)
              .multilineTextAlignment(.center)
              .keyboardType(.numberPad)
          
//          Text("Dollar amount (ARS/290)")
//          Text(argentinaDollarText)
          //Text(Date.now, format: .dateTime.hour().minute())
        }
      }
      
      Spacer()
      
    }
}

