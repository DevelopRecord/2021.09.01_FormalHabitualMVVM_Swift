//
//  AddHabitualController.swift
//  FormalHabitualMVVM
//
//  Created by LeeJaeHyeok on 2021/09/01.
//

import UIKit

class AddHabitualController: UIViewController, UIActionSheetDelegate {
    
    // MARK: Properties
    private let newHabitual: UILabel = {
        let label = UILabel()
        label.text = "New Habitual"
        label.font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight.bold)
        return label
    }()
    
    lazy var titleTextField: UITextField = {
        let tf = CustomTextField(placeholder: "새로운 습관의 이름을 작성해 보세요")
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.tertiarySystemGroupedBackground.cgColor
        tf.textAlignment = .center
        tf.setHeight(150)
        tf.setWidth(view.frame.width - 50)
        return tf
    }()
    
    lazy var notificationLabel: UILabel = {
        let label = UILabel()
        label.text = "Notifications"
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium)
        return label
    }()
    
    lazy var sundayButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("SUN", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 11)
        button.tag = 0
        button.frame = CGRect(x: 160, y: 100, width: 45, height: 45)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.clipsToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.tertiarySystemGroupedBackground.cgColor
        button.backgroundColor = .systemGray5
        button.setTitleColor(.black, for: .normal)
        button.setHeight(48)
        button.setWidth(48)
        button.addTarget(self, action: #selector(sunBtnTapped), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var mondayButton: UIButton = {
        let button = UIButton()
        button.setTitle("MON", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 11)
        button.tag = 1
        button.frame = CGRect(x: 160, y: 100, width: 45, height: 45)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.clipsToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.tertiarySystemGroupedBackground.cgColor
        button.backgroundColor = .systemGray5
        button.setTitleColor(.black, for: .normal)
        button.setHeight(48)
        button.setWidth(48)
        button.addTarget(self, action: #selector(monBtnTapped), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var thuesdayButton: UIButton = {
        let button = UIButton()
        button.setTitle("TUE", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 11)
        button.tag = 2
        button.frame = CGRect(x: 160, y: 100, width: 45, height: 45)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.clipsToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.tertiarySystemGroupedBackground.cgColor
        button.backgroundColor = .systemGray5
        button.setTitleColor(.black, for: .normal)
        button.setHeight(48)
        button.setWidth(48)
        button.addTarget(self, action: #selector(tueBtnTapped), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var wednesdayButton: UIButton = {
        let button = UIButton()
        button.setTitle("WED", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 11)
        button.tag = 3
        button.frame = CGRect(x: 160, y: 100, width: 45, height: 45)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.clipsToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.tertiarySystemGroupedBackground.cgColor
        button.backgroundColor = .systemGray5
        button.setTitleColor(.black, for: .normal)
        button.setHeight(48)
        button.setWidth(48)
        button.addTarget(self, action: #selector(wedBtnTapped), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var thursdayButton: UIButton = {
        let button = UIButton()
        button.setTitle("THR", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 11)
        button.tag = 4
        button.frame = CGRect(x: 160, y: 100, width: 45, height: 45)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.clipsToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.tertiarySystemGroupedBackground.cgColor
        button.setHeight(48)
        button.setWidth(48)
        button.backgroundColor = .systemGray5
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(thrBtnTapped), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var fridayButton: UIButton = {
        let button = UIButton()
        button.setTitle("FRI", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 11)
        button.tag = 5
        button.frame = CGRect(x: 160, y: 100, width: 45, height: 45)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.clipsToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.tertiarySystemGroupedBackground.cgColor
        button.setHeight(48)
        button.setWidth(48)
        button.backgroundColor = .systemGray5
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(friBtnTapped), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    private let saturdayButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("SAT", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 11)
        button.tag = 6
        button.frame = CGRect(x: 160, y: 100, width: 45, height: 45)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.clipsToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.tertiarySystemGroupedBackground.cgColor
        button.setHeight(48)
        button.setWidth(48)
        button.backgroundColor = .systemGray5
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(satBtnTapped), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var onOffButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("ON", for: UIControl.State.normal)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.tertiarySystemGroupedBackground.cgColor
        button.setHeight(50)
        button.setWidth(view.frame.width - 50)
        button.backgroundColor = .systemGray5
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(onOffButtonTapped), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var notiSoundLabel: UILabel = {
        let label = UILabel()
        label.text = "Notification Sound"
        label.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium)
        return label
    }()
    
    lazy var notiSoundButton: UIButton = {
        let button = UIButton()
        button.setTitle("알림음", for: UIControl.State.normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -280, bottom: 0, right: 0)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.tertiarySystemGroupedBackground.cgColor
        button.setHeight(60)
        button.setWidth(view.frame.width - 50)
        button.backgroundColor = .systemGray5
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(frequencyButtonTapped), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var timeButton: UIButton = {
        let button = UIButton()
        button.setTitle("시간", for: UIControl.State.normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -280, bottom: 0, right: 0)
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.tertiarySystemGroupedBackground.cgColor
        button.setHeight(50)
        button.setWidth(view.frame.width - 50)
        button.backgroundColor = .systemGray5
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(timeButtonTapped), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("CANCEL", for: UIControl.State.normal)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.setTitleColor(.black, for: .normal)
        button.setHeight(60)
        button.setWidth(180)
        button.addTarget(self, action: #selector(cancelButtonTapped), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var confirmButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("CONFIRM", for: UIControl.State.normal)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.setTitleColor(.black, for: .normal)
        button.setHeight(50)
        button.setWidth(180)
        button.addTarget(self, action: #selector(confirmButtonTapped), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        self.hideKeyboardWhenTappedAround()
        moveViewWithKeyboard()
        self.moveViewWithKeyboard()
    }
    
    // MARK: Helper
    func configureUI() {
        view.backgroundColor = .systemBackground
        
//        configureColors()
        
        
        let topStack = UIStackView(arrangedSubviews: [newHabitual, titleTextField])
        topStack.axis = .vertical
        topStack.spacing = 20
        
        let dayStack = UIStackView(arrangedSubviews: [sundayButton, mondayButton, thuesdayButton,
                                                    wednesdayButton, thursdayButton,fridayButton, saturdayButton])
        dayStack.axis = .horizontal
        dayStack.spacing = 7.5
        
        let notificationStack = UIStackView(arrangedSubviews: [notificationLabel, dayStack, onOffButton, timeButton])
        notificationStack.axis = .vertical
        notificationStack.spacing = 10
        
        let notiSoundStack = UIStackView(arrangedSubviews: [notiSoundLabel, notiSoundButton])
        notiSoundStack.axis = .vertical
        notiSoundStack.spacing = 10
        
        let btnStack = UIStackView(arrangedSubviews: [cancelButton, confirmButton])
        btnStack.axis = .horizontal
        btnStack.spacing = 7
        
        let wholeStack = UIStackView(arrangedSubviews: [topStack, dayStack, notificationStack, notiSoundStack])
        wholeStack.axis = .vertical
        wholeStack.spacing = 10
        
        view.addSubview(wholeStack)
        wholeStack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor,
                          right: view.rightAnchor, paddingTop: 32, paddingLeft: 16, paddingRight: 16)
//        wholeStack.setHeight(view.frame.height)
        wholeStack.setWidth(view.frame.width)
        
        view.addSubview(btnStack)
        btnStack.centerX(inView: view)
        btnStack.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    // MARK: Actions
    @objc func cancelButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func confirmButtonTapped() {
        guard let memo = titleTextField.text,
            memo.count > 0 else {
            alert(message: "습관 이름을 입력해주세요.")
            return
        }
        print("DEUBG: 저장 완료! (테스트)")
        dismiss(animated: true, completion: nil)
    }
    
    @objc func frequencyButtonTapped() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let basicMusic = UIAlertAction(title: "기본", style: .default, handler: nil)
        let etc1Music = UIAlertAction(title: "뮤직1", style: .default, handler: nil)
        let etc2Music = UIAlertAction(title: "뮤직2", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(basicMusic)
        alert.addAction(etc1Music)
        alert.addAction(etc2Music)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func onOffButtonTapped(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            timeButton.isEnabled = true
            onOffButton.setTitle("ON", for: UIControl.State.normal)
            self.timeButton.alpha = 1
        } else {
            sender.isSelected = true
            timeButton.isEnabled = false
            onOffButton.setTitle("OFF", for: UIControl.State.normal)
            self.timeButton.alpha = 0.3
        }
    }
    
    @objc func timeButtonTapped() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "en_GB")
        let datestr = "00:00"
        let dateform = DateFormatter()
        dateform.dateFormat = "HH:mm"
        let datetime = dateform.date(from: datestr)
        if let unwrappedDate = datetime {
            datePicker.setDate(unwrappedDate, animated: true)
        }
        
        let alert = UIAlertController(title: "Pick a time", message: nil, preferredStyle: .actionSheet)
        alert.view.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor).isActive = true
        datePicker.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 40).isActive = true
        datePicker.widthAnchor.constraint(equalToConstant: alert.view.frame.width - 10).isActive = true
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // actionSheet Constraint
        let height: NSLayoutConstraint = NSLayoutConstraint(item: alert.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.1, constant: 380)
        alert.view.addConstraint(height)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func sunBtnTapped(_ sender: UIButton, date: NSDate, id: Int) {
        if sender.isSelected {
            sender.isSelected = false
            sundayButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
            sundayButton.backgroundColor = .black
            self.sundayButton.alpha = 1
        } else {
            sender.isSelected = true
            self.sundayButton.alpha = 0.3
        }
    }
    
    @objc func monBtnTapped(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            mondayButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
            mondayButton.backgroundColor = .black
            self.mondayButton.alpha = 1
        } else {
            sender.isSelected = true
            self.mondayButton.alpha = 0.3
        }
    }
    
    @objc func tueBtnTapped(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            thuesdayButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
            thuesdayButton.backgroundColor = .black
            self.thuesdayButton.alpha = 1
        } else {
            sender.isSelected = true
            self.thuesdayButton.alpha = 0.3
        }
    }
    
    @objc func wedBtnTapped(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            wednesdayButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
            wednesdayButton.backgroundColor = .black
            self.wednesdayButton.alpha = 1
        } else {
            sender.isSelected = true
            self.wednesdayButton.alpha = 0.3
        }
    }
    
    @objc func thrBtnTapped(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            thursdayButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
            thursdayButton.backgroundColor = .black
            self.thursdayButton.alpha = 1
        } else {
            sender.isSelected = true
            self.thursdayButton.alpha = 0.3
        }
    }
    
    @objc func friBtnTapped(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            fridayButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
            fridayButton.backgroundColor = .black
            self.fridayButton.alpha = 1
        } else {
            sender.isSelected = true
            fridayButton.alpha = 0.3
        }
    }
    
    @objc func satBtnTapped(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            saturdayButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
            saturdayButton.backgroundColor = .black
            self.saturdayButton.alpha = 1
        } else {
            sender.isSelected = true
            self.saturdayButton.alpha = 0.3
        }
    }
    
    /*
    //MARK: Configures
    func configureColors() {
        if self.traitCollection.userInterfaceStyle == .dark { //유저 인터페이스가 다크 테마일 때
            sundayButton.backgroundColor = .lightGray
            sundayButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
            mondayButton.backgroundColor = .white
            mondayButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
            thuesdayButton.backgroundColor = .white
            thuesdayButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
            wednesdayButton.backgroundColor = .white
            wednesdayButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
            thursdayButton.backgroundColor = .white
            thursdayButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
            fridayButton.backgroundColor = .white
            fridayButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
            saturdayButton.backgroundColor = .white
            saturdayButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
            onOffButton.backgroundColor = .white
            onOffButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
            cancelButton.backgroundColor = .white
            cancelButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
            confirmButton.backgroundColor = .white
            confirmButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
            notiSoundButton.backgroundColor = .white
            notiSoundButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
            timeButton.backgroundColor = .white
            timeButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
            
        } else { //일반 라이트 모드일 때
            sundayButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
            sundayButton.backgroundColor = .systemGray5
            mondayButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
            mondayButton.backgroundColor = .systemGray5
            thuesdayButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
            thuesdayButton.backgroundColor = .systemGray5
            wednesdayButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
            wednesdayButton.backgroundColor = .systemGray5
            thursdayButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
            thursdayButton.backgroundColor = .systemGray5
            fridayButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
            fridayButton.backgroundColor = .systemGray5
            saturdayButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
            saturdayButton.backgroundColor = .systemGray5
            onOffButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
            onOffButton.backgroundColor = .systemGray5
            cancelButton.setTitleColor(UIColor.systemGray, for: UIControl.State.normal)
            confirmButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
            notiSoundButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
            notiSoundButton.backgroundColor = .systemGray5
            timeButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
            timeButton.backgroundColor = .systemGray5
        }
    }
     */
}
