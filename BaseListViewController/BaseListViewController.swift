//
//  BaseListViewController (Swift)
//
//  [studio memoru]
//

import UIKit

class BaseListViewController: UITableViewController
{

    private var m_indicator: UIActivityIndicatorView! = nil
    private var m_indicatorBase: UIView! = nil
    private var m_noDataLabel: UILabel! = nil
    private var m_dispIndicator: Bool = false
    private var m_noDataString: String = "No Data"
    private var m_dispNoData: Bool = false

    // MARK: -  Properties
    
    var cellReuseId: String?
    var outsideCellReuseId: String?
    var noDataText: String {
        
        get {
            return m_noDataString
        }
        
        set(noDataText) {
            m_noDataString = noDataText
            if m_noDataLabel != nil {
                m_noDataLabel!.attributedText = attributedStringForNoData(noDataText)
            }
        }
    }

    // MARK: - Methods

    func attributedStringForNoData(text: String) -> NSAttributedString {
        return NSAttributedString(string: text,
                                  attributes: [NSForegroundColorAttributeName : UIColor.grayColor(),
                                    NSFontAttributeName : UIFont.systemFontOfSize(14.0)])
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.tableFooterView = UIView() //--不要な区切り線を消す

        m_indicatorBase = UIView(frame: self.view.frame)
    
        m_indicator = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
        m_indicator.color = UIColor.darkGrayColor()
        m_indicatorBase.addSubview(m_indicator)
        m_indicatorBase.exclusiveTouch = true
    
        m_noDataLabel = UILabel(frame: CGRectMake(0, 0, 300, 120))
        m_noDataLabel.textAlignment = .Center
        m_noDataLabel.numberOfLines = 0
        m_noDataLabel.attributedText = attributedStringForNoData(m_noDataString)
        m_indicatorBase.addSubview(m_noDataLabel)
        
        registerCellInfo()
    }

    func registerCellInfo() {

        //-- Should be overridden.

        self.cellReuseId = "BaseListViewController_cell"
        self.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier:self.cellReuseId!)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        m_indicatorBase.frame = self.view.frame
    }


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows()
    }

    func numberOfRows() -> Int {

        //-- Should be overridden.
        return 3
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        var cell: UITableViewCell?
        let row = indexPath.row
        
        if numberOfRows() > row
        {
            cell = tableView.dequeueReusableCellWithIdentifier(self.cellReuseId!, forIndexPath: indexPath)
            if cell != nil {
                cell = configureCell(cell!, atRow: row)
            }
        }
        else if self.outsideCellReuseId != nil
        {
            cell = tableView.dequeueReusableCellWithIdentifier(self.outsideCellReuseId!, forIndexPath: indexPath)
            cell = configureOutsideCell(cell!, atRow: row)
        }
        return cell!
    }

    func configureCell(cell: UITableViewCell, atRow: Int) -> UITableViewCell {
        
        //-- Should be overridden.
        cell.textLabel?.text = "Cell"
        return cell
    }

    func configureOutsideCell(cell: UITableViewCell, atRow: Int) -> UITableViewCell {
        
        //-- Should be overridden.
        cell.textLabel?.text = "More..."
        return cell
    }

    // MARK: - Activity Indicator View

    func showActivityIndicator() {
        
        m_dispNoData = false
        if !m_dispIndicator {
            self.view!.superview!.addSubview(m_indicatorBase)
            
            let r = m_indicatorBase.frame
            let c = CGPointMake(r.size.width/2, r.size.height/2)
            m_indicator.center = c
            m_indicator.hidden = false
            m_indicator.startAnimating()

            self.tableView.scrollEnabled = false
            m_noDataLabel.hidden = true

            m_dispIndicator = true
        }
    }

    func hideActivityIndicator() {
        
        if m_dispIndicator {
            m_indicator.stopAnimating()

            m_indicatorBase.removeFromSuperview()
            self.tableView.scrollEnabled = true
            m_dispIndicator = false
        }
    }

    // MARK: - No-Data Label

    func showNoData() {
        
        m_dispIndicator = false
        if !m_dispNoData {
            let r = m_indicatorBase.frame
            
            let c = CGPointMake(r.size.width/2, r.size.height/2.1)
            m_noDataLabel.center = c
            m_noDataLabel.hidden = false
            m_indicator.hidden = true
            
            self.view!.superview!.addSubview(m_indicatorBase)

            m_dispNoData = true
        }
    }

    func hideNoData() {
        
        if m_dispNoData {
            m_indicatorBase.removeFromSuperview()
            m_dispNoData = false
        }
    }
}
