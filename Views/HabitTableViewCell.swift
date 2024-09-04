//
//  HabitTableViewCell.swift
//  DailyFocus
//
//  Created by Irina Muravyeva on 29.08.2024.
//

import UIKit

class HabitTableViewCell: UITableViewCell {

    @IBOutlet var habitLabel: UILabel!
    @IBOutlet var howOftenADayHabitLabel: UILabel!
    @IBOutlet var habitProgressView: UIProgressView!
    @IBOutlet var leftToDo: UILabel!
    @IBOutlet var tipLabel: UILabel!
    @IBOutlet var doneImage: UIImageView!
    @IBOutlet var progressInPercent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
            
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
