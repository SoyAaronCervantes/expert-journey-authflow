//
//  DetailsViewController.swift
//  AuthProject
//
//  Created by Aarón Cervantes Álvarez on 08/05/21.
//

import UIKit
import Alamofire

class DetailsViewController: UIViewController {
  @IBOutlet weak var imageView: UIImageView!
  var photoName: String = ""
  var urlSource = "http://janzelaznog.com/DDAM/iOS/gaga/"
  override func viewDidLoad() {
    super.viewDidLoad()
    print(photoName)
    guard let url = URL(string: urlSource + photoName) else { return }
    AF.request(url, method: .get)
      .validate()
      .response{ response in
        guard let data = response.data else { return }
        self.setImage(data)
      }
  }
  
  private func setImage(_ data: Data ){
    let img = UIImage(data: data)
    imageView.image = img
    imageView.contentMode = .scaleAspectFit
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}
