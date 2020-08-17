//
//  ViewController.swift
//  Jose_G_CoreData
//
//  Created by José Godinez on 8/14/20.
//  Copyright © 2020 José Godinez. All rights reserved.
//
import UIKit
import Foundation
import CoreData
class ViewController: UIViewController {
  // 12. Create the dataManager variable and listArry variable.
  // SCROLL DOWN TO THE viewDidLoad Function TO COMPLETE STEP 13
  //
  var dataManager : NSManagedObjectContext!
  var listArray = [NSManagedObject]()
  // 15. Enter the saveRecordButton function below
  //
  @IBAction func saveRecordButton(_ sender: UIButton) {
    let newEntity = NSEntityDescription.insertNewObject(forEntityName:"Item", into: dataManager)
    newEntity.setValue(enterGuitarDescription.text!, forKey: "about")
    do{
      try self.dataManager.save()
      listArray.append(newEntity)
    } catch{
      print ("Error saving data")
    }
    displayDataHere.text?.removeAll()
    enterGuitarDescription.text?.removeAll()
    fetchData()
  }
  // 16. Enter the deleteRecordButton function below
  // Yeah! you are done now build and run your code!
  //
  @IBAction func deleteRecordButton(_ sender: UIButton) {
    let deleteItem = enterGuitarDescription.text!
    for item in listArray {
      if item.value(forKey: "about") as! String == deleteItem {
        dataManager.delete(item)
      }
      do {
        try self.dataManager.save()
      } catch {
        print ("Error deleting data")
      }
      displayDataHere.text?.removeAll()
      enterGuitarDescription.text?.removeAll()
      fetchData()
    }
  }
  @IBOutlet var enterGuitarDescription: UITextField!
  @IBOutlet var displayDataHere: UILabel!
  override func viewDidLoad() {
    super.viewDidLoad()
    // 13. Add the constant appDelegate to the viewDidLoad function
    //
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    dataManager = appDelegate.persistentContainer.viewConText
    displayDataHere.text?.removeAll()
    fetchData()
  }
    // 14. Enter the fetchData function below.
    // GO BACK UP TO THE SAVE RECORD BUTTON FUNCTION TO COMPLETE STEP 15
  func fetchData() {
    let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Item")
    do {
      let result = try dataManager.fetch(fetchRequest)
      listArray = result as! [NSManagedObject]
      for item in listArray {
        let product = item.value(forKey: "about") as! String
        displayDataHere.text! += product
      }
    } catch {
      print ("Error retrieving data")
    }
  }
}
