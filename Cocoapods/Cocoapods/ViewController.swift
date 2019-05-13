//
//  ViewController.swift
//  Cocoapods
//
//  Created by 酒井綾菜 on 2019-05-08.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit
import ScrollableGraphView

class ViewController: UIViewController, ScrollableGraphViewDataSource {
    
    let linePlotData = [11.0, 15.0, 24.3, 25.5, 30.7, 20.5]
    
    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
        // Return the data for each plot.
        switch(plot.identifier) {
        case "dot":
            return linePlotData[pointIndex]
        default:
            return 0
        }
    }
    
    func label(atIndex pointIndex: Int) -> String {
        return "FEB \(pointIndex)"
    }
    
    func numberOfPoints() -> Int {
        return linePlotData.count
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let frame = self.view.frame
        let graphView = ScrollableGraphView(frame: frame, dataSource: self)
        
        // Setup the plot
        let plot = DotPlot(identifier: "dot")
        
        plot.dataPointSize = 5
        plot.dataPointFillColor = UIColor.white
        
        // Setup the reference lines
        let referenceLines = ReferenceLines()
        referenceLines.referenceLineLabelFont = UIFont.boldSystemFont(ofSize: 10)
        referenceLines.referenceLineColor = UIColor.white.withAlphaComponent(0.5)
        referenceLines.referenceLineLabelColor = UIColor.white
        referenceLines.referenceLinePosition = ScrollableGraphViewReferenceLinePosition.both
        
        referenceLines.shouldShowLabels = false
        
        // Setup the graph
        graphView.backgroundFillColor = UIColor.red
        graphView.shouldAdaptRange = false
        graphView.shouldAnimateOnAdapt = false
        graphView.shouldAnimateOnStartup = false
        
        graphView.shouldAnimateOnStartup = true
        graphView.shouldAdaptRange = true
        graphView.shouldRangeAlwaysStartAtZero = true
        
        graphView.dataPointSpacing = 25
        graphView.rangeMax = 50
        graphView.rangeMin = 0
        
        // Add everything
        graphView.addPlot(plot: plot)
        graphView.addReferenceLines(referenceLines: referenceLines)
        
        self.view.addSubview(graphView)
    }
    

}

