//
//  SettingsViewController.swift
//  MachineTaskSphinix
//
//  Created by Mac on 21/03/23.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var strtext : String = "Profile Settings"
    var strtext1 : String = "LogOut"
    
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        lbl1.text = strtext
        lbl2.text = strtext1
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
