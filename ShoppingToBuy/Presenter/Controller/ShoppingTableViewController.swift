//
//  ShoppingTableViewController.swift
//  SeSAC-Mission-Day8-TableView
//
//  Created by 원태영 on 1/5/24.
//

import UIKit


/**
 고민 지점
 
 toBuy Cell에서 조작한 북마크나 체크박스 토글이 전체 배열 저장 시에 반영되지 않는다.
 
 toBuy Cell은 Cell 생성 시점에 toBuys 배열에서 가져온 단일 인스턴스를 들고 생성되는데, 전달받은 구조체가 값 복사되어 참조가 연결되어있지 않기 때문이다. 그래서 내부 구조체의 변경이 외부 배열에 반영될 수 없다.
 
 이를 해결하려면 Cell에 참조를 전달하여 변경사항을 원본에 반영하거나, 구조체를 유지하고 Cell에 action 클로저를 주입해서 Cell 내부에서의 변경 사항을 외부에 전달해야한다.
 
 toBuys에 직접 값을 할당하는 것 뿐만 아니라, append와 remove를 통해 배열의 길이가 변경되어도 set이 호출되어 UserDefault에 반영된다.
 
 내부 프로퍼티의 업데이트로도 set이 호출되려면 class가 아닌 struct여야한다.
 클래스는 원소의 참조 자체가 변경되지 않는 이상 변경으로 감지하지 않기 때문에 set이 수행되지 않는다.
 반대로 구조체는 내부 프로퍼티가 변경되면 값의 변경으로 감지하기 때문에, update 로직도 UserDefault에 자동으로 반영된다.
 
 -- 솔루션 정리 --
 1. 클래스로 변경하는 경우
 - 클래스로 변경하면 참조는 연결되지만, 프로퍼티의 변경으로 didSet이 호출되지 않음
 
 2. 구조체로 유지하는 경우
 - 구조체를 유지하면 참조는 연결되지 않지만, 프로퍼티 변경으로 didSet이 호출됨
 - inout 참조로 연결하는 방법이 있을지 고민 필요함
 
 결론적으로 어차피 두 방법 모두 Cell에서 인스턴스 수정이 있을 때, 주입된 클로저를 호출하거나 Notification이 필요함
 
 인스턴스의 값 변경이 용이한지 여부로도 struct, class를 고민해봐야 할 듯
 */
final class ShoppingTableViewController: UITableViewController {
  
  @IBOutlet weak var addView: UIView!
  @IBOutlet weak var toBuyTextField: UITextField!
  @IBOutlet weak var addButton: UIButton!
  
  @UserDefault(key: .toBuy)
  var toBuys: [ToBuy] {
    didSet {
      tableView.reloadData()
    }
  }
  
  private var isAddable: Bool {
    guard let text = toBuyTextField.text else {
      return false
    }
    
    return !text.isEmpty
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureUI()
  }
  
  @IBAction func addButtonTapped(_ sender: UIButton) {
    guard let text = toBuyTextField.text
    else {
      return
    }
    
    let toBuy: ToBuy = ToBuy(title: text)
    toBuys.append(toBuy)
    toBuyTextField.text = ""
    inputChanged(toBuyTextField)
  }
  
  @IBAction func inputChanged(_ sender: UITextField) {
    addButton.isEnabled = isAddable
  }
  
  private func configureUI() {
    setView(addView)
    setTextField(toBuyTextField, placeholder: "무엇을 구매하실 건가요?")
    setButton(addButton, title: "추가")
  }
  
  private func setView(_ view: UIView) {
    view.backgroundColor = .systemGray6
    view.layer.cornerRadius = 10
  }
  
  private func setTextField(
    _ field: UITextField,
    placeholder: String
  ) {
    field.placeholder = placeholder
    field.autocapitalizationType = .none
    field.autocorrectionType = .no
    field.borderStyle = .none
  }
  
  private func setButton(
    _ button: UIButton,
    title: String
  ) {
    button.setTitle(title, for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.backgroundColor = .systemGray5
    button.layer.cornerRadius = 10
    button.isEnabled = false
  }
  
  // MARK: - Table view data source
  override func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    return toBuys.count
  }
  
  override func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cellIdentifier = String(describing: ShoppingTableViewCell.self)
    
    // XIB, UINib -> 스토리보드에서 정보 가져오는 과정 확인
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: cellIdentifier,
      for: indexPath
    ) as? ShoppingTableViewCell 
    else {
      return ShoppingTableViewCell()
    }
    
    cell.toBuy = toBuys[indexPath.row]
    cell.updateAction = { [weak self] updatedToBuy in
      guard let self else {
        print(#function, #line)
        return
      }
      
      toBuys[indexPath.row] = updatedToBuy
    }
    
    return cell
  }
  
  override func tableView(
    _ tableView: UITableView,
    canEditRowAt indexPath: IndexPath
  ) -> Bool {
    return true
  }

  override func tableView(
    _ tableView: UITableView,
    commit editingStyle: UITableViewCell.EditingStyle,
    forRowAt indexPath: IndexPath
  ) {
    if editingStyle == .delete {
      let row: Int = indexPath.row
      toBuys.remove(at: row)
    }
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 50
  }
}
