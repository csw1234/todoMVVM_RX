//
//  ViewController.swift
//  todoMVVM
//
//  Created by Csw on 2/25/18.
//  Copyright © 2018 csw. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var button: UIButton!

    
    //MARK: Variables
    var tasks = Variable<[Task]>([])
    var viewModel: ViewModel?
    var circleViewVar: UIView!
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        setupButtonBinding()
        setupTableViewBinding()
    }

    private func setupTableViewBinding(){
        self.tasks
        .asObservable()
        .bind(to: self.tableView.rx.items(cellIdentifier: "cell"))
        {row, elemnt, cell in
            cell.textLabel?.text = elemnt.name
            
        }.disposed(by: disposeBag)
    }
    
    func setupButtonBinding(){
        self.button.rx.tap.asObservable()
            .subscribe(onNext:{
                let task = Task(name: "sd")
                self.tasks.value.append(task)
                
            }).disposed(by: disposeBag)
    }
}

