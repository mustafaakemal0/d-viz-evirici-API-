//
//  ViewController.swift
//  dövizçevirici API
//
//  Created by Mustafa kemal Özen on 10.05.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tryLabel: UILabel!
    @IBOutlet weak var euroLabel: UILabel!
    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func changeLabel(_ sender: Any) {
        
        let url = URL(string: "https://api.freecurrencyapi.com/v1/latest?apikey=klaKE7AaWAE538c6HwBdrBzuDiEvXcJ34vUAmhsV")
        
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                alert.addAction(okButton)
                self.present(alert, animated: true)
            } else {
                
                if data != nil {
                    
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                       
                        DispatchQueue.main.async {
                            
                            if let data = jsonResponse["data"] as? [String: Any] {
                                //print(data)
                                if let turkish = data["TRY"] as? Double {
                                    self.tryLabel.text = "TRY: \(turkish)"
                                }
                                if let euro = data["EUR"] as? Double {
                                    self.euroLabel.text = "EUR: \(euro)"
                                }
                                if let cad = data["CAD"] as? Double {
                                    self.cadLabel.text = "CAD: \(cad)"
                                }
                                if let jpy = data["JPY"] as? Double {
                                    self.jpyLabel.text = "JPY: \(jpy)"
                                }
                            }
                        }
                            
                        } catch {
                            print("error")
                        }
                    }
                }
            }
            task.resume()
            
        }
        
    }
    
    

