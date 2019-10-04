//
//  WeatherTableViewCell.swift
//  WeatherDarkSky
//
//  Created by Tony He on 2019/10/4.
//  Copyright © 2019 Tony He. All rights reserved.
//

import UIKit
import SDWebImage

class WeatherTableViewCell: UITableViewCell {
    
    // show weather icon
    let iconImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    // show short of weekday
    let dayLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        
        return label
    }()
    
    // show high temp
    let highLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        return label
    }()
    
    // show low temp
    let lowLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        contentView.addSubview(iconImageView)
        contentView.addSubview(dayLabel)
        contentView.addSubview(highLabel)
        contentView.addSubview(lowLabel)
        
        iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 64).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
        dayLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16).isActive = true
        dayLabel.topAnchor.constraint(equalTo: iconImageView.topAnchor).isActive = true
        dayLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor).isActive = true
        
        highLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16).isActive = true
        highLabel.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 8).isActive = true
        highLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor).isActive = true
        
        lowLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16).isActive = true
        lowLabel.topAnchor.constraint(equalTo: highLabel.bottomAnchor, constant: 8).isActive = true
        lowLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor).isActive = true
        lowLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24).isActive = true
    }
    
    func configureCell(with data:WeatherModelDailyData,timeZone:String) {
        
        guard let icon = data.icon, let high = data.temperatureHigh, let low = data.temperatureLow, let time = data.time else {
            return
        }
        
        // To get the icon online.
        iconImageView.sd_setImage(with: URL.init(string: "https://darksky.net/images/weather-icons/\(icon).png"), completed: nil)
        
        // To get the short of weekday
        let date = Date.init(timeIntervalSince1970: TimeInterval.init(time))
    
        let formatter = DateFormatter.init()
        formatter.timeZone = TimeZone.init(identifier: timeZone)
        formatter.dateFormat = "EEE"
        
        dayLabel.text = formatter.string(from: date)
        highLabel.text = "H:\(high)"
        lowLabel.text = "L:\(low)"
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
