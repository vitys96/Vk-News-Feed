//  FooterView.swift

import UIKit


class FooterView: UIView {
    
    private var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = #colorLiteral(red: 0.631372549, green: 0.6470588235, blue: 0.662745098, alpha: 1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var activityInd: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.hidesWhenStopped = true
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        [textLabel, activityInd].forEach { (view) in
            addSubview(view)
        }
        
        textLabel.anchor(top: topAnchor,
                         leading: leadingAnchor,
                         bottom: nil,
                         trailing: trailingAnchor,
                         padding: UIEdgeInsets(top: 8, left: 20, bottom: 0, right: 20))
        activityInd.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityInd.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 8).isActive = true
    }
    
    func showActivityInd() {
        self.activityInd.startAnimating()
    }
    
    func setTitle(_ title: String?) {
        self.activityInd.stopAnimating()
        self.textLabel.text = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
