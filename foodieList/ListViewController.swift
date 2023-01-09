//
//  ListViewController.swift
//  foodieList
//
//  Created by Jube on 2023/1/5.
//

import UIKit

class ListViewController: UIViewController {

    var unCheckedLists = [Info]() {
        didSet{
            Info.saveInfo(Infos: unCheckedLists)
        }
    }
    var checkedLists = [Info]() {
        didSet{
            Info.saveInfo(Infos: checkedLists)
        }
    }
    
    var newRestaurant: Info?
    
    @IBOutlet weak var wishListTableView: UITableView!
    @IBOutlet weak var checkedListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        wishBgStyle(height: 337, cornerRadius: 28)
        
    }
    
    @IBAction func unCheckList(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: checkedListTableView)
        if let indexPath = checkedListTableView.indexPathForRow(at: point){
            checkedLists[indexPath.row].checked = false
            print(checkedLists, "before")
            let removeList = checkedLists.remove(at: indexPath.row)
            unCheckedLists.insert(removeList, at: 0)
            checkedListTableView.reloadData()
            wishListTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .right)
            print(checkedLists, "after")
        }
    }
    
    @IBAction func checkList(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: wishListTableView)
        if let indexPath = wishListTableView.indexPathForRow(at: point){
            unCheckedLists[indexPath.row].checked = true
            print(unCheckedLists[indexPath.row].btnImageName)
            let removedList = unCheckedLists.remove(at: indexPath.row)
            checkedLists.insert(removedList, at: 0)
            wishListTableView.reloadData()
            checkedListTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        }
    }
    func wishBgStyle(height: CGFloat, cornerRadius: CGFloat){
        
        let wishBgLayer = CAShapeLayer()
        let wishBgPath = UIBezierPath()
        wishBgPath.move(to: CGPoint(x: 0.0, y: view.bounds.height))
        wishBgPath.addLine(to: CGPoint(x: 0.0, y: view.bounds.height-height+cornerRadius))
        wishBgPath.addQuadCurve(to: CGPoint(x: cornerRadius, y: view.bounds.height-height), controlPoint: CGPoint(x: 0.0, y: view.bounds.height-height))
        wishBgPath.addLine(to: CGPoint(x: view.bounds.width, y: view.bounds.height-height))
        wishBgPath.addLine(to: CGPoint(x: view.bounds.width, y: view.bounds.height))
        wishBgLayer.path = wishBgPath.cgPath
        wishBgLayer.fillColor = CGColor(gray: 1, alpha: 1)
        
        wishBgLayer.shadowColor = CGColor(red: 20/255, green: 62/255, blue: 40/255, alpha: 1)
        wishBgLayer.shadowOpacity = 0.25
        wishBgLayer.shadowRadius = 36
        wishBgLayer.shadowOffset = CGSize(width: 0.0, height: 8.0)
        view.layer.insertSublayer(wishBgLayer, at: 0)
    }
    
    @IBAction func unwindToListViewController(_ unwindSegue: UIStoryboardSegue) {
        
        // Use data from the view controller which initiated the unwind segue
        if let sourceViewController = unwindSegue.source as? EditViewController,
           let newRestaurant = sourceViewController.newRestaurant {
            if newRestaurant.checked {
                checkedLists.insert(newRestaurant, at: 0)
                checkedListTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
            } else {
                unCheckedLists.insert(newRestaurant, at: 0)
                wishListTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
            }
        }
        
        
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

extension ListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case self.wishListTableView:
            return unCheckedLists.count
        case self.checkedListTableView:
            return checkedLists.count
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case self.wishListTableView:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "\(WishTableViewCell.self)", for: indexPath) as? WishTableViewCell{
                cell.wishNameLabel.text = unCheckedLists[indexPath.row].name
                cell.unCheckBtn.configuration?.image = UIImage(named: unCheckedLists[indexPath.row].btnImageName)
                return cell
            }
                        
        case self.checkedListTableView:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "\(CheckdTableViewCell.self)", for: indexPath) as? CheckdTableViewCell {
                cell.checkedNameLabel.text = checkedLists[indexPath.row].name
                cell.checkBtn.configuration?.image = UIImage(named: checkedLists[indexPath.row].btnImageName)
                if checkedLists[indexPath.row].comment.isEmpty {
                    cell.commentLabel.text = Info.unComment
                } else {
                    cell.commentLabel.text = checkedLists[indexPath.row].comment
                }
                return cell
            }
            
        
        default:
            break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch tableView {
        case self.wishListTableView:
            unCheckedLists.remove(at: indexPath.row)
            wishListTableView.deleteRows(at: [indexPath], with: .automatic)
        case self.checkedListTableView:
            checkedLists.remove(at: indexPath.row)
            checkedListTableView.deleteRows(at: [indexPath], with: .automatic)
        default:
            break
        }
    }
}



extension ListViewController: UITableViewDelegate {
    
}