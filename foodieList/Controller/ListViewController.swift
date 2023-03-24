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
            Info.saveUnCheckedInfo(infos: unCheckedLists)
        }
    }
    var checkedLists = [Info]() {
        didSet{
            Info.saveCheckedInfo(Infos: checkedLists)
            print("save")
        }
    }
    
    var newRestaurant: Info?
    var viewModel = ListViewModel()
    
    @IBOutlet weak var wishListTableView: UITableView!
    @IBOutlet weak var checkedListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        viewModel.wishBgStyle(height: 337, cornerRadius: 28, view: view)
        viewModel.loadAllLists()
    }
    
    @IBAction func unCheckList(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: checkedListTableView)
        if let indexPath = checkedListTableView.indexPathForRow(at: point){
            viewModel.unCheckOnCeckListAt(index: indexPath.row)
            checkedListTableView.reloadData()
            wishListTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .right)
        }
    }
    
    @IBAction func checkList(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: wishListTableView)
        if let indexPath = wishListTableView.indexPathForRow(at: point){
            viewModel.checkOnWishListAt(index: indexPath.row)
            wishListTableView.reloadData()
            checkedListTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        }
    }
    
    @IBSegueAction func addNew(_ coder: NSCoder) -> EditViewController? {
        let controller = EditViewController(coder: coder)
        controller?.delegate = self
        return controller
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "wishCellToEdit" {
            if let row = wishListTableView.indexPathForSelectedRow?.row,
               let destinationC = segue.destination as? EditViewController {
                destinationC.delegate = self
                destinationC.newRestaurant = viewModel.unCheckedLists[row]
            }
        } else if segue.identifier == "checkCellToView" {
            if let destinationC = segue.destination as? DetailViewController,
               let row = checkedListTableView.indexPathForSelectedRow?.row,
               let indexPath = checkedListTableView.indexPathForSelectedRow {
                destinationC.delegate = self
                destinationC.viewModel.restaurant = viewModel.checkedLists[row]
                destinationC.indexPath = indexPath
            }
        }
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case self.wishListTableView:
            return viewModel.numberOfUnCheckedList()
        case self.checkedListTableView:
            return viewModel.numberOfCheckedList()
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case self.wishListTableView:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "\(WishTableViewCell.self)", for: indexPath) as? WishTableViewCell{
                cell.wishNameLabel.text = viewModel.nameOnUnCheckList(index: indexPath.row)
                cell.unCheckBtn.configuration?.image = viewModel.btnImageOnUnCheckList(index: indexPath.row)
                return cell
            }
        case self.checkedListTableView:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "\(CheckdTableViewCell.self)", for: indexPath) as? CheckdTableViewCell {
                cell.checkedNameLabel.text = viewModel.nameOnCheckList(index: indexPath.row)
                cell.checkBtn.configuration?.image = viewModel.btnImageOnCheckList(index: indexPath.row)
                cell.commentLabel.text = viewModel.checkedLists[indexPath.row].comment
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

extension ListViewController: EditViewControllerDelegate, DetailViewControllerDelegate {
    func detailViewControllerDelegate(_ controller: DetailViewController, didSelect restaurant: Info, didSelect indexPath: IndexPath) {
        viewModel.checkedLists[indexPath.row] = restaurant
        checkedListTableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func editViewControllerDelegate(_ controller: EditViewController, didEditRestaurant restaurant: Info) {
        
        if restaurant.checked {
            //未去過編輯後為已去過
            if let indexPath = wishListTableView.indexPathForSelectedRow{
                checkedLists.insert(restaurant, at: 0)
                checkedListTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
                unCheckedLists.remove(at: indexPath.row)
                wishListTableView.deleteRows(at: [indexPath], with: .automatic)
            } else if let indexPath = checkedListTableView.indexPathForSelectedRow {
                checkedLists[indexPath.row] = restaurant
                checkedListTableView.reloadRows(at: [indexPath], with: .automatic)
            } else {
                // 新增已去過
                checkedLists.insert(restaurant, at: 0)
                checkedListTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
            }
        } else {
            //未去過編輯後更新未去過
            if let indexPath = wishListTableView.indexPathForSelectedRow{
                unCheckedLists[indexPath.row] = restaurant
                wishListTableView.reloadRows(at: [indexPath], with: .automatic)
            } else {
                //新增未去過
                unCheckedLists.insert(restaurant, at: 0)
                wishListTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
            }
        }
    }
}
