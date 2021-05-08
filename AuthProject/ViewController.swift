//
//  ViewController.swift
//  AuthProject
//
//  Created by Aarón Cervantes Álvarez on 07/05/21.
//

import UIKit
import Alamofire
import CryptoKit

class ViewController: UIViewController {
  let url = "https://reqres.in/api/login"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  @IBOutlet weak var emailInput: UITextField!
  @IBOutlet weak var passwordInput: UITextField!
  @IBAction func submitSignIn(_ sender: Any) {
    if emailInput.text!.isEmpty {
      let title = "Error en el formulario"
      let message = "Se necesita un usuario para inicar sesión"
      displayAlert(title, message: message)
      return
    }
    
    if passwordInput.text!.isEmpty {
      let title = "Error en el formulario"
      let message = "La contraseña es requerida para inicar sesión"
      displayAlert(title, message: message)
      return
    }
    
    
    let email = emailInput.text!
    let password = passwordInput.text!
    
    if !isValidEmail(email) {
      let title = "Error en el correo"
      let message = "Por favor ingresa un correo valido"
      displayAlert(title, message: message)
      return
    }
    
    if !isValidPassword(password) {
      let title = "Error en el formulario"
      let message = "La contraseña debe tener más de 10 caracteres"
      displayAlert(title, message: message)
      return
    }
    
    // let passwordCrypted = crypthPassword(password)
    
    let params: [String:String] = [
      "email": email,
      "password": password
    ]
    
    AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default ).validate().responseJSON(completionHandler: { response in
      guard let result = response.value else {
        let title = "Error al iniciar sesion"
        let message = "Tu correo/contraseña no coinciden"
        self.displayAlert(title, message: message)
        return
      }
      let value = result as! NSDictionary
      let token = value.object(forKey: "token")
      let title = "Listo, ya iniciaste sesión"
      let message = "Este es el token: \(token ?? "")"
      self.displayAlert(title, message: message)
    })
  }
  
  private func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
  }
  
  private func isValidPassword(_ password: String) -> Bool {
    return password.count >= 10
  }
  
  private func crypthPassword(_ password: String ) -> String {
    guard let bytes = password.data(using: .utf8) else { return "" }
    let passwordCrypted = SHA512.hash(data: bytes)
    let newPassword = passwordCrypted.compactMap{ String(format: "%02x", $0) }.joined()
    return newPassword
  }
  
  private func displayAlert(_ title: String, message: String) {
    let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert )
    let alertAction = UIAlertAction.init( title: "Ok", style: .default, handler: nil )
    alert.addAction(alertAction)
    self.present(alert, animated: true, completion: nil)
  }
  
  
}

