//
//  MViewController.swift
//  DovizCevirici
//
//  Created by Emir Keskin on 24.03.2022.
//

import UIKit

class MViewController: UIViewController {

    @IBOutlet weak var dolarLabel: UILabel!
    @IBOutlet weak var euroLabel: UILabel!
    @IBOutlet weak var sterlinLabel: UILabel!
    @IBOutlet weak var frangLabel: UILabel!
    @IBOutlet weak var yenLabel: UILabel!
    
    @IBOutlet weak var usdBack: UIView!
    @IBOutlet weak var eurBack: UIView!
    @IBOutlet weak var gbpBack: UIView!
    @IBOutlet weak var chfBack: UIView!
    @IBOutlet weak var jpyBack: UIView!
    @IBOutlet weak var showButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showButton.layer.cornerRadius = 16
        usdBack.layer.cornerRadius = 16
        eurBack.layer.cornerRadius = 16
        gbpBack.layer.cornerRadius = 16
        chfBack.layer.cornerRadius = 16
        jpyBack.layer.cornerRadius = 16
        
    }
    
    @IBAction func showClicked(_ sender: Any) {
        
        
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=5efa34723ec63af25b5bca538ba102e3&format=1")
        let oturum =  URLSession.shared
        
        let task = oturum.dataTask(with: url!) { data, response, error in
            if error != nil {
                let alert = UIAlertController(title: "Dikkat", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else {
                
                if data != nil {
                    
                    do {
                        let jsonVerisi =  try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        
                        DispatchQueue.main.async {
                            if let rates = jsonVerisi["rates"] as? [String: Any] {
                                
                                
                                if let usd = rates["USD"] as? Double{
                                    self.dolarLabel.text = " \(usd)"
                                }
                                
                                if let eur = rates["EUR"] as? Double{
                                    self.euroLabel.text = " \(eur)"
                                }
                                if let gbp = rates["GBP"] as? Double{
                                    self.sterlinLabel.text = " \(gbp)"
                                }
                                if let chf = rates["CHF"] as? Double{
                                    self.frangLabel.text = " \(chf)"
                                }
                                if let jpy = rates["JPY"] as? Double{
                                    self.yenLabel.text = " \(jpy)"
                                }
                            }
                        }
                        
                        
                        
                        
                    } catch {
                        print("hata var")
                    }
                }
                
            }
        }
        task.resume()
    }
    
}
