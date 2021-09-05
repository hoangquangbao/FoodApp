//
//  HomeViewModel.swift
//  FoodApp
//
//  Created by Quang Bao on 23/08/2021.
//

import SwiftUI
import CoreLocation
import Firebase

class HomeViewModel: NSObject,ObservableObject,CLLocationManagerDelegate{
    
    @Published var locationManager = CLLocationManager()
    @Published var search = ""
    
    // Locations Details
    @Published var userLocation : CLLocation!
    @Published var userAddress = ""
    @Published var noLocation = false
    
    //Menu
    @Published var showMenu = false
    
    //ItemData....
    @Published var items : [Item] = []
    @Published var filtered : [Item] = []
    
    //Cart Data....
    @Published var cartItems : [Cart] = []
    

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        //checking Location Access....
        
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            print("authorized")
            self.noLocation = false
            manager.requestLocation()
        case .denied:
            self.noLocation = true
            print("denied")
        default:
            self.noLocation = false
            print("unknown")
            // Direct Call
            locationManager.requestWhenInUseAuthorization()
            // Modifying Info.plist
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Reading User Location and Extracting Details.
        self.userLocation = locations.last
        self.extractLocation()
        
        //After extracting location logging to....
        self.login()
    }
    
    func extractLocation(){
        
        CLGeocoder().reverseGeocodeLocation(self.userLocation) { (res, err) in
            
            guard let safeData = res else{return}
            
            var address = ""
            
            //getting area and locatlity name....
            address += safeData.first?.name ?? ""
            address += ", "
            address += safeData.first?.locality ?? ""
            
            self.userAddress = address
        }
    }
    
    //anynomus login for reading database....
    
    func login() {
        
        Auth.auth().signInAnonymously {(res, err) in
            
            if err != nil{
                print(err!.localizedDescription)
                return
            }
            
            print("Success = \(res!.user.uid)")
            
            //After Logging in Fetching Data
            
            self.fetchData()
        }
    }
    
    //Fetching Iteam Data....
    
    func fetchData(){
        
        let db = Firestore.firestore()
        
        db.collection("Items").getDocuments { snap, err in
            
            guard let itemData = snap else{return}
            
            self.items = itemData.documents.compactMap({ doc -> Item? in
                
                let id = doc.documentID
                let name = doc.get("item_name") as! String
                let cost = doc.get("item_cost") as! NSNumber
                let details = doc.get("item_details") as! String
                let image = doc.get("item_image") as! String
                let raitings = doc.get("item_raitings") as! String
                
                return Item(id: id, item_name: name, item_cost: cost, item_details: details, item_image: image, item_raitings: raitings)
            })
            
            self.filtered = self.items
        }
    }
    
    //Search or Filter..
    
    func filterData() {
        
        withAnimation(.linear){
            
            self.filtered = self.items.filter({
                return $0.item_name.lowercased().contains(self.search.lowercased())
            })

        }
    }
    
    //Add to Cart function
    func addToCart(item: Item) {
        
        // cheking it is added....
        self.items[getIndex(item: item, isCartIndex: false)].isAdded = !item.isAdded
        // updating filtered array also for search bar results....
        self.filtered[getIndex(item: item, isCartIndex: false)].isAdded = !item.isAdded
        
        if item.isAdded {
            
            // remove from list....
            self.cartItems.remove(at: getIndex(item: item, isCartIndex: true))
            return
        }
        // else adding....
        self.cartItems.append(Cart(item: item, quantity: 1))
    }
    
    func getIndex(item: Item, isCartIndex:Bool) -> Int {
        
        let index = self.items.firstIndex { item1 in
            
            return item.id == item1.id
        } ?? 0
        
        let cartIndex = self.cartItems.firstIndex { item1 in
            
            return item.id == item1.item.id
        } ?? 0
        
        return isCartIndex ? cartIndex : index
    }
    
    func calculateTotalPrice() -> String {
        
        var price: Float = 0
        
        cartItems.forEach { (item) in
            
            price += Float(item.quantity)*Float(truncating: item.item.item_cost)
        }
        
        return getPrice(value: price)
    }
    
    func getPrice(value: Float) -> String {
        
        let format = NumberFormatter()
        format.numberStyle = .currency
        
        return format.string(from: NSNumber(value: value)) ?? ""
    }
}
