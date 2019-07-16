//
//  ConversionModel.swift
//  Paramvir_Atwal_Currency_Conversion
//
//  Created by Paramvir Singh Atwal on 2019-07-16.
//  Copyright © 2019 Paramvir Singh Atwal. All rights reserved.
//

import Foundation

class ConversionModel {
    
    var listOfCurrencies = [ "CAD", "INR", "BRL", "USD", "EUR", "AUD", "GBP" ].sorted()
    
    var currencyNames : [String : String] =
        [ "CAD" : "Canadian Dollar",
          "INR" : "Indian Rupee",
          "AUD" : "Australian Dollar",
          "GBP" : "Pound Sterling",
          "USD" : "US Dollar",
          "BRL" : "Brazilian Real",
          "EUR" : "Euro"]
    
    var API_BASE_URL = "https://api.exchangeratesapi.io/latest?"
    
    var fromCurrency = ""
    var toCurrency = ""
    
    func updateExchangeRate(viewController: ViewController, from: Int, to: Int) {
        fromCurrency = listOfCurrencies[from]
        toCurrency = listOfCurrencies[to]
        
        let api_url = API_BASE_URL + "base=" + fromCurrency + "&symbols=" + toCurrency
        
        print(api_url)
        
        if let url = URL(string: api_url) {
            let dataTask = URLSession.shared.dataTask(with: url){
                data, response, error in
                
                if let dataReceived = data{
                    let jsonString = String(data: dataReceived, encoding: .utf8)
                    
                    print(jsonString)
                    
                    do {
                        let json = try JSON(data: dataReceived)
                        
                        let exchangeRate = json["rates"][self.toCurrency].double!
                        
                        viewController.updateConversionAmount(exchangeRate: exchangeRate)
                        
                        print ("1 \(self.fromCurrency) \(exchangeRate) \(self.toCurrency)")
                        
                    }catch let err{
                        print ("error reading JSON \(err)")
                    }
                }
            }
            
            dataTask.resume()
        }
    
    }
}
