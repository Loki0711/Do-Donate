//
//  CharityDetailsViewController.swift
//  Giveth
//
//  Created by Lokesh Kumar on 25/01/22.
//

import UIKit
import MapKit
import CoreLocation

class CharityDetailsViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var charityEntity : CharityUser? = nil
    private let geocoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.displayCharityDetails()
    
    }
    
    
    func displayCharityDetails(){
        nameLabel.text = charityEntity?.name
        descLabel.text = charityEntity?.description
        let url = URL(string: charityEntity?.imageUrl ?? "")
        guard let urlUnwrapped = url else { return }
        
        let data = try? Data(contentsOf: urlUnwrapped)
        DispatchQueue.main.async {
            self.image1.image = UIImage(data: data ?? Data())
        }        
        getLocation()
    }
    
    private func getLocation(){
        
        let street = charityEntity?.address
        let city = charityEntity?.city
        let country = charityEntity?.country
    
        let postalAddress = "\(country ?? ""), \(city ?? ""), \(street ?? "")"
        print("Postal Address \(postalAddress)")
        
        //self.getLocation(address: postalAddress)
        
        
        self.geocoder.geocodeAddressString(postalAddress, completionHandler: { (placemark, error) in
            self.processGeoResponse(placemarks: placemark, error: error)
        })
         
    }
    
    private func processGeoResponse(placemarks: [CLPlacemark]?, error: Error?){
        if error != nil{
            print("Unable to get location coordinates")
        }else{
            var obtainedLocation : CLLocation?
            
            if let placemark = placemarks, placemarks!.count > 0{
                obtainedLocation = placemark.first?.location
            }
            
            if obtainedLocation != nil{
                self.displayLocationOnMap(location: obtainedLocation!.coordinate)
                print("LOCATION: \(obtainedLocation?.coordinate.latitude) : \(obtainedLocation?.coordinate.longitude)")
            }else{
                print("No Coordinates Found")
            }
        }
    }
    

    func displayLocationOnMap(location : CLLocationCoordinate2D){
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        
        self.mapView?.setRegion(region, animated: true)
        
        //display annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "You'r here"
        self.mapView?.addAnnotation(annotation)
    }

}
