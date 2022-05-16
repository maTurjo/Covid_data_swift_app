//
//  ViewController.swift
//  Final_exam
//
//  Created by user202461 on 4/20/22.
//

import UIKit
import Charts
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {
    
    var DataObject:Welcome?
    
    var total=0;
    var recovered=0;
    var deaths=0;
    let manager=CLLocationManager()
    
    var DeviceLocation=CLLocation()
    
    @IBOutlet weak var Total: UIButton!
    @IBOutlet weak var Recovered: UIButton!
    
    @IBOutlet weak var Deaths: UIButton!
    
    
    @IBOutlet weak var recoveryRate: UIButton!
    
    @IBOutlet weak var DeathRate: UIButton!
    
    @IBOutlet weak var chartSuperView: UIView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        manager.delegate=self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization();
        manager.startUpdatingLocation();
        loadData();
        populateValues();
        createChart();
        
        // Do any additional setup after loading the view.
    }
    
    //location manager captures current lcoation and calls render function to display location

        func locationManager(_ manager:CLLocationManager,didUpdateLocations location:[CLLocation]){
           
            if let location=location.first{
                manager.startUpdatingLocation()
                DeviceLocation=location
                getClosestLocation()
                
            }
        }

    

    @IBOutlet weak var closestLocationLabel: UILabel!
    
    @IBOutlet weak var totalConfirmedLabel: UILabel!
    
    @IBOutlet weak var totalRecoveredLabel: UILabel!
    
    @IBOutlet weak var totalDeathsLabel: UILabel!
    
    //Gets the closest location in the JSON data from the current location and displays the data
    func getClosestLocation(){
        
        var distanceArray=[Double]();
        
        for areas in DataObject!.areas!{
            
            let coordinate=CLLocation(latitude: areas.lat!, longitude: areas.long!)
            
            let distanceInMeters=DeviceLocation.distance(from: coordinate)
            
            distanceArray.append(distanceInMeters)
            
        }
        
        
        var index=distanceArray.firstIndex(of: distanceArray.min()!)
        var object=DataObject!.areas![index!]
        
        var totalConfirmed=object.totalConfirmed ?? 0
        var totalRecovered=object.totalRecovered ?? 0
        var totalDeath=object.totalDeaths ?? 0
        
        closestLocationLabel.text=object.displayName
        totalConfirmedLabel.text="Total Confirmed \(totalConfirmed)"
        totalRecoveredLabel.text="Total Recovered \(totalRecovered)"
        totalDeathsLabel.text="Total Deaths\(totalDeath)"
        
    }

    //creates and displays the chart
    func createChart(){
        //Create bar chart
        let barChart=BarChartView(frame: CGRect(x: 0, y: 0,
                                                width: chartSuperView.frame.size.width,
                                                height: chartSuperView.frame.size.height))
        //configure the axis
        
        //configure legend
        let legend=barChart.legend
        var legendEntries=[LegendEntry(label: "Deaths"),LegendEntry(label: "Recovered")]
        
        legendEntries[0].formColor=NSUIColor(cgColor: UIColor.red.cgColor)
        legendEntries[1].formColor=NSUIColor(cgColor: UIColor.green.cgColor)
        legend.setCustom(entries: legendEntries)
        
        
        
        //supply data
        var entries=[BarChartDataEntry]()
        for x in 0..<3{
            if(x==1){
                entries.append(BarChartDataEntry(x: Double(x), y: Double(deaths)))
            }
            if(x==2){
                entries.append(BarChartDataEntry(x: Double(x), y: Double(recovered)))
            }
//            if(x==3){
//                entries.append(BarChartDataEntry(x: Double(x), y: Double(total)))
//            }
            
        }
        let set=BarChartDataSet(entries: entries, label: "Cost")
        set.colors=[NSUIColor(cgColor: UIColor.red.cgColor),NSUIColor(cgColor: UIColor.green.cgColor)]
        set.stackLabels=["deaths","recovered"]
        let data=BarChartData(dataSet: set)
        barChart.data=data
        chartSuperView.addSubview(barChart)
    }
    
    //displays the data in the UI
    func populateValues(){
        
        total=DataObject!.totalConfirmed!
        recovered=DataObject!.totalRecovered!
        deaths=DataObject!.totalDeaths!
        
        let totalLabel="Total=\(total)"
        let recoveredLabel="Recovered=\(recovered)"
        let deathLabel="Deaths=\(deaths)"
        
        var Deathrate:Double=round((Double(deaths)/Double(total))*1000)/10
        var RecoveryRate:Double=round((Double(recovered)/Double(total))*1000)/10
        
        let DeathRateLabel="\(Deathrate) % Death"
        let RecoveryRateLabel="\(RecoveryRate) % Recovery"
            
        
        Total.setTitle(totalLabel, for: .normal)
        Recovered.setTitle(recoveredLabel, for: .normal)
        Deaths.setTitle(deathLabel, for: .normal)
        recoveryRate.setTitle(RecoveryRateLabel, for: .normal)
        DeathRate.setTitle(DeathRateLabel, for: .normal)
        
    }
    
 
    //Loads JSON data into the program
    func loadData(){
        
        guard let path=Bundle.main.path(forResource: "covid_data", ofType: "json")else{
            fatalError("File Location not found")
            
        }
        
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {return}
        
        let localArray = try? JSONDecoder().decode(Welcome.self,from: data)
       
        self.DataObject=localArray!;
        
        
    }
}

