//
//  ViewController.swift
//  cafe-fitch
//
//  Created by MATTHEW FITCH on 9/11/24.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var menuTextOutlet: UILabel!
    
    @IBOutlet weak var addItemOutlet: UIButton!
    @IBOutlet weak var destroyItemOutlet: UIButton!
    @IBOutlet weak var cartTextViewOutlet: UITextView!
    var names = ["coffee", "burger", "special", "pancakes", "waffles"]
    
    var devMode = false
    
    var cart: [String : Double] = [:]
    
    @IBOutlet weak var amountTextOutlet: UILabel!
    @IBOutlet weak var cartFieldOutlet: UITextField!
    @IBOutlet weak var cartAmountOutlet: UITextField!
    var prices: [Double] = [100, 40, 5, 15, 14]
    override func viewDidLoad() {
        super.viewDidLoad()
        addItemOutlet.isHidden = true
        destroyItemOutlet.isHidden = true
        cartFieldOutlet.delegate = self
        cartAmountOutlet.delegate = self
        // Do any additional setup after loading the view.
        for i in 0..<names.count {
            menuTextOutlet.text! += "Doom \(names[i]): $\(String(floor(prices[i] * 100)/100))\n"
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        cartFieldOutlet.resignFirstResponder()
        cartAmountOutlet.resignFirstResponder()
        if cartFieldOutlet.text == ""
        {
            return true
        }
        
        if cartFieldOutlet.text == nil || cartAmountOutlet.text == nil || devMode
        {
            return true
        }
        
        if names.contains(cartFieldOutlet.text!.lowercased())
        {
            let count: Double? = Double(cartAmountOutlet.text!)
            if count == nil || count! <= 0
            {
                createAlert(alertName: "Invalid count")
                return true
            }
            if cart[cartFieldOutlet.text!.lowercased()] != nil{
                createAlert(alertName: "Item already in cart.")
            } else {
                cart[cartFieldOutlet.text!] = count!;
            }
        } else {
            createAlert(alertName: "Item not found. (Do not type doom before item name)")
        }
        
        cartTextViewOutlet.text = ""
        
        var total: Double = 0
        
        for (key, value) in cart {
            cartTextViewOutlet.text += key + ": \(value)\n"
            
            total += value * Double(prices[names.firstIndex(of: key)!])
        }
        
        cartTextViewOutlet.text += "Total: $\(total)"
        cartFieldOutlet.text = ""
        cartAmountOutlet.text = ""
        return true
    }
    
    func createAlert(alertName: String)
    {
        let alert = UIAlertController(title: "Error", message: alertName, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(alertAction)
        
        self.present(alert, animated: true)
        
    }
    

    @IBAction func devModeAction(_ sender: Any) {
        if !devMode {
            if cartFieldOutlet.text != "ch33s3burg3r" {
                return
            }
            devMode = true
            cartFieldOutlet.text = ""
            cartAmountOutlet.text = ""
            cartFieldOutlet.resignFirstResponder()
            cartAmountOutlet.resignFirstResponder()
            
            amountTextOutlet.text = "Price of item"
            
            addItemOutlet.isHidden = false
            destroyItemOutlet.isHidden = false
            
            
            
        } else {
            devMode = false
            amountTextOutlet.text = "Amount"
            
            addItemOutlet.isHidden = true
            destroyItemOutlet.isHidden = true
        }
        
    }
    @IBAction func addItemAction(_ sender: Any) {
        cartFieldOutlet.resignFirstResponder()
        cartAmountOutlet.resignFirstResponder()
        if cartAmountOutlet.text == nil || Double(cartAmountOutlet.text!) == nil || Double(cartAmountOutlet.text!)! <= 0 || cartFieldOutlet.text == nil
        {
            createAlert(alertName: "Bad Input")
            return
        }
        names.append(cartFieldOutlet.text!)
        prices.append(Double(cartAmountOutlet.text!)!)
        menuTextOutlet.text = ""
        for i in 0..<names.count {
            menuTextOutlet.text! += "Doom \(names[i]): $\(String(floor(prices[i] * 100)/100))\n"
        }
        cartFieldOutlet.text = ""
        cartAmountOutlet.text = ""
        
    }
    
    @IBAction func destroyItemAction(_ sender: Any) {
        cartFieldOutlet.resignFirstResponder()
        cartAmountOutlet.resignFirstResponder()
        
        if names.contains(cartFieldOutlet.text!.lowercased())
        {
            
            var index = names.firstIndex(of: cartFieldOutlet.text!)!
            names.remove(at: index)
            prices.remove(at: index)
            menuTextOutlet.text = ""
            for i in 0..<names.count {
                menuTextOutlet.text! += "Doom \(names[i]): $\(String(floor(prices[i] * 100)/100))\n"
            }
        } else {
            createAlert(alertName: "Item not found. (Do not type doom before item name)")
        }
        
        cartFieldOutlet.text = ""
        cartAmountOutlet.text = ""
    }
}

