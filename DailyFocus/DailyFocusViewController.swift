//
//  DailyFocusViewController.swift
//  DailyFocus
//
//  Created by Irina Muravyeva on 28.08.2024.
//

import UIKit
import SwiftUI

class DailyFocusViewController: UITableViewController {
    
    // MARK: - Test data
    
    private var habitsList = Habit.getHabitsList()
    private var pillsList = Pill.getPillsList()
    private var tasksList = Task.getTasksList()

    // MARK: - LifeCircle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.rowHeight = 40
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
            case 0: "Привычки".uppercased()
            case 1: "Лекарства".uppercased()
            default: "Список дел".uppercased()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0: habitsList.count
            case 1: pillsList.count
            default: tasksList.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        case 0:
            let habitCell = tableView.dequeueReusableCell(withIdentifier: "habit", for: indexPath) as? HabitTableViewCell
            let habit = habitsList[indexPath.row]
            
            if !habit.habitDone {
                
                habitCell?.leftToDo.isHidden = true
                habitCell?.doneImage.isHidden = true
                
                habitCell?.habitLabel.text = habit.habit.uppercased()
                habitCell?.howOftenADayHabitLabel.text = habit.howManyTimesADay.formatted()
                habitCell?.habitProgressView.progress = habit.progress / 100
                habitCell?.progressInPercent.isHidden = true
                
            } else {
                habitCell?.habitLabel.text = habit.habit.uppercased()
                let leftToDoDays = Float(habit.howManyDays) / 100 * habit.progress
                habitCell?.leftToDo.text = "Ещё \(leftToDoDays.formatted()) дней" // TO DO: Добавить склонение слово "день"
                habitCell?.doneImage.isHidden = false
                habitCell?.tipLabel.isHidden = true
                habitCell?.howOftenADayHabitLabel.isHidden = true
                habitCell?.progressInPercent.text = "\(habit.progress.formatted())%"
                habitCell?.habitProgressView.isHidden = true
                
                setupGradientView(cell: habitCell!, habit: habit)
            }
            
            
            return habitCell!
            
        case 1:
            let pillCell = tableView.dequeueReusableCell(withIdentifier: "pill", for: indexPath)
            let pill = pillsList[indexPath.row]
            var content = pillCell.defaultContentConfiguration()
            
            content.text = pill.pillName
            content.textToSecondaryTextVerticalPadding = 5
            
            
            if !pill.done {
                content.image = UIImage(named: pill.image)
                content.imageProperties.maximumSize = CGSize(width: 20, height: 20)
                
                content.secondaryText = pill.description
                content.secondaryTextProperties.color = .systemGray
            } else {
                
                content.secondaryText = "Принято"
                content.secondaryTextProperties.color = .systemGreen
                content.image = UIImage(named: pill.image)
                content.imageProperties.maximumSize = CGSize(width: 20, height: 20)
                
                content.image = UIImage(systemName: "checkmark")
                content.imageProperties.tintColor = .systemGreen
                
            }
            
            pillCell.contentConfiguration = content
            
            return pillCell
            
        default:
            let taskCell = tableView.dequeueReusableCell(withIdentifier: "task", for: indexPath)
            let task = tasksList[indexPath.row]
            var content = taskCell.defaultContentConfiguration()
    
            content.image = UIImage(systemName: "circle")
            content.imageProperties.tintColor = .systemGray2
            content.image?.withTintColor(.gray)
            content.text = task.textOfTask
            taskCell.contentConfiguration = content
            
            return taskCell
            
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: 60
        case 1: 50
        default: 40
        }
    }

    private func setupGradientView(cell: HabitTableViewCell, habit: Habit) {
        let height = cell.frame.height // Height of the translucent gradient view
        
        lazy var gradientView: UIView = {
               let view = UIView()
               view.translatesAutoresizingMaskIntoConstraints = false // IMPORTANT IF YOU ARE USING CONSTRAINTS INSTEAD OF FRAMES
               return view
           }()
        
        cell.addSubview(gradientView)
        cell.addSubview(cell.contentView)
        
        NSLayoutConstraint.activate([
            gradientView.leadingAnchor.constraint(equalTo: cell.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: cell.trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: cell.bottomAnchor),
            gradientView.heightAnchor.constraint(equalToConstant: height)
        ])

        // Adding the gradient
        let colorLeading =  UIColor.systemGreen
//        let colorTrailing = UIColor.clear
        let colorTrailing = UIColor.white
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.type = .axial
        gradientLayer.colors = [colorLeading.cgColor, colorTrailing.cgColor]
//        gradientLayer.locations = [0.0, 1.1]
        
        let percentInDouble = Double(habit.progress/100)
//        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
//        gradientLayer.endPoint = CGPoint(x: percentInDouble, y: percentInDouble)
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: percentInDouble, y: percentInDouble)
        gradientLayer.frame = CGRect(
            x: 0,
            y: 0,
            width: cell.frame.width,
            height: cell.frame.height
        )
        gradientView.layer.insertSublayer(gradientLayer, at:0)
        print(cell.frame)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
