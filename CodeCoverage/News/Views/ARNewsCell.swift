//
//  ARNewsCell.swift
//  ThemeSample
//
//  Created by Ashok Rawat on 22/04/22.
//

import Foundation
import UIKit

class ARNewsCell: UITableViewCell {
    
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func cellConfiguration(newsVMSource: NewsVMSource) {
        self.descriptionLabel.text = newsVMSource.description
        self.categoryLabel.text = newsVMSource.category
        self.countryLabel.text = newsVMSource.country

        configURLLabel(newsVMSource: newsVMSource)
    }
    
    private func configURLLabel(newsVMSource: NewsVMSource) {
        let tapAction = UITapGestureRecognizer(target: self, action: #selector(self.tapLabel(gesture:)))
        self.urlLabel.isUserInteractionEnabled = true
        self.urlLabel.addGestureRecognizer(tapAction)
            
        let attributedString = NSMutableAttributedString(string: newsVMSource.url)
        let range = (newsVMSource.url as NSString).range(of: newsVMSource.url)
        attributedString.addAttribute(.foregroundColor, value: UIColor.blue, range: range)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
        self.urlLabel.attributedText = attributedString
    }
    
    @IBAction private func tapLabel(gesture: UITapGestureRecognizer) {
        let text = (self.urlLabel.text)!
        UIApplication.shared.open(URL(string: text)!)
    }
}
