//
//  SettingsViewController.swift
//  Ping-Pong Scorer
//
//  Created by Stuart McClintock on 12/15/19.
//  Copyright © 2019 Stuart McClintock. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

   var del: AppDelegate!
   
   @IBOutlet weak var leadBy2Switch: UISwitch!
   @IBOutlet weak var pointsNeededLabel: UILabel!
   @IBOutlet weak var pointsNeededStepper: UIStepper!
   @IBOutlet weak var serveModeTable: UITableView!
   let optionsServe: [String] = ["Change server every 2 points",
   "Winner of last point serves", "Loser of last point serves"]
   
   @IBAction func updateLeadBy2(_ sender: Any) {
      del.setMustBeAheadBy2(val: leadBy2Switch.isOn)
   }
   @IBAction func updatePointsNeeded(_ sender: Any) {
      del.setWinningScore(score: Int(pointsNeededStepper.value))
      pointsNeededLabel.text = "Points required to win: \( del.getWinningScore())"
   }

   override func viewDidLoad() {
        super.viewDidLoad()
      serveModeTable.dataSource = self
      serveModeTable.delegate = self
      let app = UIApplication.shared
      del = app.delegate as? AppDelegate

      pointsNeededStepper.value = Double(del.getWinningScore())
      pointsNeededLabel.text = "Points required to win: \( del.getWinningScore())"
      leadBy2Switch.isOn = del.getMustBeAheadBy2()

        // Do any additional setup after loading the view.
    }

   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
      return optionsServe.count
   }

   func tableView (_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
      let cell = serveModeTable.dequeueReusableCell(withIdentifier: "serveModeCell", for:indexPath)
      cell.textLabel?.text = optionsServe[indexPath.row]
      if del.selectedServe[indexPath.row]{
         cell.accessoryType = .checkmark
      }

      return cell
   }

   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let row = indexPath.row
      del.selectedServe = Array(repeating: false, count: del.selectedServe.count)
      del.selectedServe[row] = true
      var index: Int = 0
      for i in del.selectedServe{
         let cell = serveModeTable.cellForRow(at: IndexPath(row: index, section:0))
         if i{
            cell?.accessoryType = .checkmark
         }
         else{
            cell?.accessoryType = .none
         }
         index+=1
      }
      del.setServeChange(val: row+1)
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
