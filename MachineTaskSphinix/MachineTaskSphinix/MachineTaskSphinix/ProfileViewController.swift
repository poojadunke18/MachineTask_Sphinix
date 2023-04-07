//
//  ProfileViewController.swift
//  MachineTaskSphinix
//
//  Created by Mac on 21/03/23.
//

import UIKit

class ProfileViewController: UIViewController {
    var str : String = "Pooja Dunke"
    var str1 : String = "Pune"
    
    @IBOutlet weak var Profileimg: UIImageView!
    @IBOutlet weak var profileLbl1: UILabel!
    @IBOutlet weak var profileLbl2: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        profileLbl1.text = str
        profileLbl2.text = str1
    }
    
}
