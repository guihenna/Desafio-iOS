//
//  DetalhesVC.swift
//  Desafio - Mobile
//
//  Created by Guilherme de Almeida Henna on 24/10/18.
//  Copyright © 2018 Guilherme de Almeida Henna. All rights reserved.
//

import Foundation
import UIKit

class DetalhesVC: UIViewController {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var lblSinopse: UILabel!
    @IBOutlet weak var lblTitulo: UILabel!
    // @IBOutlet weak var btnVoltar: UIButton!
    
    
    var movieId: Int!

    override func viewDidLoad() {
        backView.showBlurLoader()
        super.viewDidLoad()
        
        /*
         * Arredondando o botão de volta. Se o botão for quadrado, ele fica redondo
         * Se for retangular, arredonda perfeitamente o menor eixo
 
        btnVoltar.layer.cornerRadius = min(btnVoltar.layer.bounds.height/2, btnVoltar.layer.bounds.width/2)
        btnVoltar.layer.borderColor = UIColor(red: 0.1, green: 0.1, blue: 0.3, alpha: 1).cgColor
        btnVoltar.layer.borderWidth = 2.0
        
        backImg.layer.borderColor = btnVoltar.layer.borderColor
        backImg.layer.borderWidth = btnVoltar.layer.borderWidth
         */
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkConnection()
    }
    
    func Alert(Message: String) {
        let alert = UIAlertController(title: "Connection Error", message: Message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Try again", style: UIAlertActionStyle.default, handler: { (action) in
            self.checkConnection()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func checkConnection() {
        if !InternetCheck.Connection() {
            self.Alert(Message: "Check your internet connection and try again")
        }
        else {
            downloadData()
        }
    }
    
    func downloadData() {
        NetworkAdapter.request(target: .details(id: movieId), success: { (response) in
            do {
                let movie = try response.map(to: MovieDetails.self)
                
                self.lblSinopse.text = "Overview: \(movie.overview)"
                
                let image = UIImage(named: "default")
                self.backImg.kf.setImage(with: URL(string: movie.backdrop_url), placeholder: image)
                self.lblTitulo.text = movie.title
                self.backView.removeBlurLoader()
                
            } catch {
                print("Parsing Error")
            }
        }, error: { (error) in
            print("Server Error: \(error)")
        }, failure: { (error) in
            print("Moya Error: \(error)")
        })
    }
    
    /*
    @IBAction func btnVoltarPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
     */
}
