//
//  ViewController.swift
//  Paramvir_Atwal_Currency_Conversion
//
//  Created by Paramvir Singh Atwal on 2019-07-16.
//  Copyright © 2019 Paramvir Singh Atwal. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    

    //Mark: Outlet
    
    @IBOutlet weak var CurrencyPicker: UIPickerView!
    
    @IBOutlet weak var fromCurrencyName: UILabel!
    @IBOutlet weak var toCurrencyName: UILabel!
    @IBOutlet weak var fromCurrencyAmount: UITextField!
    @IBOutlet weak var toCurrencyAmount: UITextField!
    
    var conversionModel = ConversionModel()
    var fromIndex = 0
    var toIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        CurrencyPicker.dataSource = self
        CurrencyPicker.delegate = self
    }
    
    //MARK: UIPickerVIewDataSpource func
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return conversionModel.listOfCurrencies.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return conversionModel.listOfCurrencies[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print ("selected row \(row) in component \(component)")
        
        if(component == 0) {
            fromIndex = row
        }
        else{
            toIndex = row
        }
        
        let fromCurrency = conversionModel.listOfCurrencies[fromIndex]
        
        let toCurrency = conversionModel.listOfCurrencies[toIndex]
        
        fromCurrencyName.text = conversionModel.currencyNames[fromCurrency]
        
        toCurrencyName.text = conversionModel.currencyNames[toCurrency]
        
        print ("go from \(fromCurrency) to \(toCurrency)")
        conversionModel.updateExchangeRate(viewController: self, from: fromIndex, to: toIndex)
    }
    
    func updateConversionAmount(exchangeRate: Double) {
        
        DispatchQueue.main.async {
            self.toCurrencyAmount.text = String(exchangeRate)
        }
    }
   
}

