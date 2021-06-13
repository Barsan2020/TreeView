//
//  ViewController.swift
//  TreeView
//
//  Created by Barsan Baidya on 6/12/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ConnectionDelegate {
    //MARK: - IBOutlet
    @IBOutlet weak var TreeTable: UITableView!
    @IBOutlet weak var BlurView: UIView!
    @IBOutlet weak var LoaderView: UIActivityIndicatorView!
    @IBOutlet weak var NoDataLbl: UILabel!
    
    //MARK: - Variables
    var home_data_array: [HomeDataDetails] = [HomeDataDetails]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        TreeTable.register(UINib(nibName: "SectionHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "SectionHeader")
        
        callHomeData()
    }
    
    // MARK: - UITableVIew Delegate Methods
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = self.TreeTable.dequeueReusableHeaderFooterView(withIdentifier: "SectionHeader") as! SectionHeader
        header.SectionTitle.tag = section
        let tapOnSection = UITapGestureRecognizer(target: self, action: #selector(showCell))
        header.SectionTitle.addGestureRecognizer(tapOnSection)
        
        let temp_dict: HomeDataDetails = home_data_array[section] as HomeDataDetails
        header.SectionTitle.text = temp_dict.role_name
        if temp_dict.open_role {
            header.SelectionView.isHidden = false
        }
        else {
            header.SelectionView.isHidden = true
        }
        return header
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return home_data_array.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let temp_dict: HomeDataDetails = home_data_array[section] as HomeDataDetails
        if temp_dict.open_role {
            return ((temp_dict.planning)["objective"] as? Array ?? []).count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        var treeCell: ResultTableViewCell!
        treeCell = tableView.dequeueReusableCell(withIdentifier: "TreeCell") as?  ResultTableViewCell
        if treeCell == nil
        {
            treeCell = ResultTableViewCell.cellFromNibNamed()
        }
        treeCell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        treeCell.TitleLbl.tag = (100*indexPath.section)+indexPath.row
        let tapOnCell = UITapGestureRecognizer(target: self, action: #selector(showSubContent))
        treeCell.TitleLbl.addGestureRecognizer(tapOnCell)
        let temp_dict: HomeDataDetails = home_data_array[indexPath.section] as HomeDataDetails
        treeCell.TitleLbl.text = (((temp_dict.planning)["objective"] as? Array ?? [])[indexPath.row] as? Dictionary ?? [:])["content_obj"] as? String ?? ""
        let result_array:Array = (((temp_dict.planning)["objective"] as? Array ?? [])[indexPath.row] as? Dictionary ?? [:])["key_result"] as? Array ?? []
        
        if temp_dict.open_objective && result_array.count > 0 {
            treeCell.SubStack.isHidden = false
            switch result_array.count {
            case 1:
                treeCell.SubViewOne.isHidden = false
                treeCell.SubLblOne.text = (result_array[0] as? Dictionary ?? [:])["key_result"] as? String ?? ""
                break
            case 2:
                treeCell.SubViewOne.isHidden = false
                treeCell.SubLblOne.text = (result_array[0] as? Dictionary ?? [:])["key_result"] as? String ?? ""
                treeCell.SubViewTwo.isHidden = false
                treeCell.SubLblTwo.text = (result_array[1] as? Dictionary ?? [:])["key_result"] as? String ?? ""
                break
            case 3:
                treeCell.SubViewOne.isHidden = false
                treeCell.SubLblOne.text = (result_array[0] as? Dictionary ?? [:])["key_result"] as? String ?? ""
                
                treeCell.SubViewTwo.isHidden = false
                treeCell.SubLblTwo.text = (result_array[1] as? Dictionary ?? [:])["key_result"] as? String ?? ""
                
                treeCell.SubViewThree.isHidden = false
                treeCell.SubLblThree.text = (result_array[2] as? Dictionary ?? [:])["key_result"] as? String ?? ""
                break
            default:
                break
            }
        }
        else {
            treeCell.SubStack.isHidden = true
        }
        
        return treeCell
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // MARK: - UIActions
    @objc func showCell(sender: UITapGestureRecognizer)
    {
        print((home_data_array[sender.view?.tag ?? 0] as HomeDataDetails).open_role)
        let temp_dict: HomeDataDetails = home_data_array[sender.view?.tag ?? 0] as HomeDataDetails
        if temp_dict.open_role {
            (home_data_array[sender.view?.tag ?? 0] as HomeDataDetails).open_role = false
            (home_data_array[sender.view?.tag ?? 0] as HomeDataDetails).open_objective = false
        }
        else {
            (home_data_array[sender.view?.tag ?? 0] as HomeDataDetails).open_role = true
        }
        
        TreeTable.reloadSections(NSIndexSet(index: sender.view?.tag ?? 0) as IndexSet, with: .automatic)
    }
    
    @objc func showSubContent(sender: UITapGestureRecognizer)
    {
        let section = (sender.view?.tag ?? 0) / 100
        let row = (sender.view?.tag ?? 0) % 100
        
        let temp_dict: HomeDataDetails = home_data_array[section] as HomeDataDetails
        let result_array:Array = (((temp_dict.planning)["objective"] as? Array ?? [])[row] as? Dictionary ?? [:])["key_result"] as? Array ?? []
        if result_array.count > 0 {
            if temp_dict.open_objective {
                (home_data_array[section] as HomeDataDetails).open_objective = false
            }
            else {
                (home_data_array[section] as HomeDataDetails).open_objective = true
            }
            
            TreeTable.reloadRows(at: [IndexPath.init(row: row, section: section)], with: .automatic)
        }
        else {
            showAlertToastBottom(message: "No data found under it!")
        }
    }
    
    //MARK: - Webservice Call
    func callHomeData() {
        LoaderView.isHidden = false
        LoaderView.stopAnimating()
        BlurView.isHidden = false
        Connection.sharedConnectionWithDelegate(delegate: self).callFetchData()
    }
    
    // MARK:Connection Delegates
    func connectionDidFinish(nState: String, nData: [String: Any]) {
        if nState == Constants.WebAPISuccessState.successStateHomeData
        {
            if let statusCode = nData[Constants.WebAPIResponseParam.reqResStatusKey] as? Int
            {
                LoaderView.isHidden = true
                LoaderView.stopAnimating()
                BlurView.isHidden = true
                NoDataLbl.isHidden = true
                switch(statusCode)
                {
                case Constants.ConstStr.failedCode:
                    showAlertToastBottom(message: nData[Constants.WebAPIResponseParam.reqResMessageKey] as? String ?? "")
                    break
                case Constants.ConstStr.successCode:
                    if let resultArray : NSArray = nData[Constants.WebAPIResponseParam.reqResDataKey] as? NSArray
                    {
                        self.home_data_array = resultArray.compactMap { (temp:Any) -> HomeDataDetails? in
                            let tempDict = temp as? [String:Any] ?? [:]
                            
                            return HomeDataDetails(hColour: tempDict["colour"] as? String ?? "", hCompany: tempDict["company"] as? String ?? "", hCreated_at: tempDict["created_at"] as? String ?? "", hDeleted_at: tempDict["deleted_at"] as? String ?? "", hId: tempDict["id"] as? Int ?? 0, hOrder: tempDict["order"] as? Int ?? 0, hPlanning: tempDict["planning"] as? Dictionary ?? [:], hRole_name: tempDict["role_name"] as? String ?? "", hRole_type: tempDict["role_type"] as? Int ?? 0, hUpdated_at: tempDict["updated_at"] as? String ?? "", hUser_id: tempDict["user_id"] as? Int ?? 0)
                        }
                    }
                    
                    break
                default:
                    break
                }
                if home_data_array.count > 0 {
                    TreeTable.isHidden = false
                    NoDataLbl.isHidden = true
                    TreeTable.reloadData()
                }
                else {
                    TreeTable.isHidden = true
                    NoDataLbl.isHidden = false
                    NoDataLbl.text = "No data found!"
                }
            }
            else
            {
                LoaderView.isHidden = true
                LoaderView.stopAnimating()
                BlurView.isHidden = true
                NoDataLbl.isHidden = true
                showToastBottom(message: "Status code missing fom API")
            }
        }
        else
        {
            LoaderView.isHidden = true
            LoaderView.stopAnimating()
            BlurView.isHidden = true
            NoDataLbl.isHidden = true
            showToastBottom(message: Constants.AlertStr.errorMsgKey)
            print(Constants.AlertStr.errorMsgKey)
        }
    }
    
    func connectionDidFail(nDataError: Error, nData: String) {
        LoaderView.isHidden = true
        LoaderView.stopAnimating()
        BlurView.isHidden = true
        NoDataLbl.isHidden = true
        print("Response Error \(nData)")
        showToastBottom(message: nData)
    }
}
