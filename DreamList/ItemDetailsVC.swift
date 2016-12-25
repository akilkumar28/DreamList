//
//  ItemDetailsVC.swift
//  DreamList
//
//  Created by AKIL KUMAR THOTA on 12/23/16.
//  Copyright © 2016 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, categorySelected {
    
    @IBOutlet weak var categorybtn: UIButton!
    @IBOutlet weak var priceFld: UITextField!
    @IBOutlet weak var titleFld: UITextField!
    @IBOutlet weak var detailsFld: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var thumbImage: UIImageView!
    
    var stores = [Store]()
    
    var itemToEdit : Item?
    var imagePicker : UIImagePickerController!

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let topbutton = navigationController?.navigationBar.topItem {
            topbutton.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        }
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        pickerView.delegate = self
        pickerView.dataSource = self

        
        storeNames()
        fetchStores()
        
        if itemToEdit != nil {
            loadItemData()
        }
        ad.saveContext()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = stores[row]
        return store.name
    }
    
    func storeNames() {
        let store1 = Store(context: context)
        store1.name = "Amazon"
        
        let store2 = Store(context: context)
        store2.name = "Best Buy"
        
        let store3 = Store(context: context)
        store3.name = "Target"
        
        let store4 = Store(context: context)
        store4.name = "Snap Deal"
        
        let store5 = Store(context: context)
        store5.name = "Flipkart"
        
        let store6 = Store(context: context)
        store6.name = "Apple Store"
        
        
    }
    
    func fetchStores() {
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            self.stores = try context.fetch(fetchRequest)
            self.pickerView.reloadAllComponents()
            
        } catch let err as NSError{
            
            print(err)
            
            
        }
    }

    @IBAction func savePressd(_ sender: UIButton) {
        
        let item = itemToEdit ?? Item(context: context)
        let image = Image(context: context)
        
        image.image = thumbImage.image
        
        
        item.toImage = image
        
        if let title = titleFld.text {
            item.title = title
        }
        if let price = priceFld.text {
            item.price = (price as NSString).doubleValue
        }
        if let details = detailsFld.text {
            item.details = details
        }
        item.toStore = stores[pickerView.selectedRow(inComponent: 0)]
        
        if let type = categorybtn.titleLabel?.text {
            item.type = type
        }
        
        ad.saveContext()
        
        _ = navigationController?.popViewController(animated: true)

    }
    
    func loadItemData() {
        
        if let item = itemToEdit {
            titleFld.text = item.title
            priceFld.text = "\(item.price)"
            detailsFld.text = item.details
            thumbImage.image = item.toImage?.image as? UIImage
            categorybtn.setTitle(item.type, for: .normal)
            
            for s in 0..<stores.count {
                if item.toStore?.name == stores[s].name {
                    pickerView.selectRow(s, inComponent: 0, animated: true)
                }
            }
        }
    }
    
    
    @IBAction func deletePressd(_ sender: UIBarButtonItem) {
        
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        _ = navigationController?.popViewController(animated: true)
        
        
    }
    
    @IBAction func imgBtnPressd(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            thumbImage.image = img
            imagePicker.dismiss(animated: true, completion: nil)

            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ItemCategoryVC {
            destination.delegate = self
        }
    }
    
    
    func category(category: String) {
        categorybtn.setTitle(category, for: .normal)
    }
    
    
    
    
    
    
    
   
    
    
    
}
