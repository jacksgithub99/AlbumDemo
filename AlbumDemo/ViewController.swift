//
//  ViewController.swift
//  AlbumDemo
//
//  Created by Weshare on 2018/3/28.
//  Copyright © 2018年 Weshare. All rights reserved.
//

import UIKit

import Photos

//@available(iOS 11.0, *)

class ViewController: UIViewController {
    
    @IBOutlet weak var album_btn: UIButton!
    @IBOutlet weak var smart_album_btn: UIButton!
    @IBOutlet weak var moment_btn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    // PHAssetCollectionTypeAlbum regular subtypes
    let album_regular_subtype_names = ["albumRegular", "albumSyncedEvent", "albumSyncedFaces", "albumSyncedAlbum", "albumImported"]
    // PHAssetCollectionTypeAlbum shared subtypes
    let album_shared_subtype_names = ["albumMyPhotoStream", "albumCloudShared"]
    // PHAssetCollectionTypeSmartAlbum subtypes
    // any: Used for fetching, if you don't care about the exact subtype
    let smart_album_subtype_names = ["smartAlbumGeneric", "smartAlbumPanoramas", "smartAlbumVideos", "smartAlbumFavorites", "smartAlbumTimelapses", "smartAlbumAllHidden", "smartAlbumRecentlyAdded", "smartAlbumBursts", "smartAlbumSlomoVideos", "smartAlbumUserLibrary", "smartAlbumSelfPortraits(ios9.0)", "smartAlbumScreenshots(ios9.0)", "smartAlbumDepthEffect(ios10.2)", "smartAlbumLivePhotos(ios10.3)", "smartAlbumAnimated(ios11.0)", "smartAlbumLongExposures(ios11.0)", "any"]
    
    var namesArrays: [[String]]!
    var subtypeArrays: [[PHAssetCollectionSubtype]]!
    
    var selectedType: PHAssetCollectionType = .album
    var selectedSubtype: PHAssetCollectionSubtype = .albumRegular
    
    var selectedTypeName: String = "album"
    var selectedSubtypeName: String = "albumRegular"
    
    // PHAssetCollectionTypeAlbum regular subtypes
    let album_regular_subtypes: [PHAssetCollectionSubtype] = [.albumRegular, .albumSyncedEvent, .albumSyncedFaces, .albumSyncedAlbum, .albumImported]
    // PHAssetCollectionTypeAlbum shared subtypes
    let album_shared_subtypes: [PHAssetCollectionSubtype] = [.albumMyPhotoStream, .albumCloudShared]
    // PHAssetCollectionTypeSmartAlbum subtypes
    // any: Used for fetching, if you don't care about the exact subtype
    let smart_album_subtypes: [PHAssetCollectionSubtype] = [.smartAlbumGeneric, .smartAlbumPanoramas, .smartAlbumVideos, .smartAlbumFavorites, .smartAlbumTimelapses, .smartAlbumAllHidden, .smartAlbumRecentlyAdded, .smartAlbumBursts, .smartAlbumSlomoVideos, .smartAlbumUserLibrary, .smartAlbumSelfPortraits, .smartAlbumScreenshots]
    
    let section_headers = ["album regular subtypes", "album shared subtypes", "smartAlbum subtypes"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "相册类型选择"
        // Do any additional setup after loading the view, typically from a nib.
        namesArrays = [album_regular_subtype_names, album_shared_subtype_names, smart_album_subtype_names]
        subtypeArrays = [album_regular_subtypes, album_shared_subtypes, smart_album_subtypes]
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "headerID")
        
        //
        let normalColor = UIColor.white
        let selectedColor = UIColor.red
        album_btn.setTitleColor(normalColor, for: .normal)
        album_btn.setTitleColor(selectedColor, for: .selected)
        album_btn.isSelected = true
        selectedType = .album
        
        smart_album_btn.setTitleColor(normalColor, for: .normal)
        smart_album_btn.setTitleColor(selectedColor, for: .selected)
        
        moment_btn.setTitleColor(normalColor, for: .normal)
        moment_btn.setTitleColor(selectedColor, for: .selected)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func goNext(_ sender: Any) {
        let vc = TheMultiSelectorViewController(nibName: "TheMultiSelectorViewController", bundle: nil)
        vc.selectedType = selectedType
        vc.selectedSubtype = selectedSubtype
        vc.title = selectedTypeName + "->" + selectedSubtypeName
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func album_btn(_ btn: UIButton) {
        album_btn.isSelected = true
        smart_album_btn.isSelected = false
        moment_btn.isSelected = false
        selectedType = .album
        selectedTypeName = "album"
    }
    
    @IBAction func smart_album_btn(_ btn: UIButton) {
        album_btn.isSelected = false
        smart_album_btn.isSelected = true
        moment_btn.isSelected = false
        selectedType = .smartAlbum
        selectedTypeName = "smartAlbum"
    }
    
    @IBAction func moment_btn(_ btn: UIButton) {
        album_btn.isSelected = false
        smart_album_btn.isSelected = false
        moment_btn.isSelected = true
        selectedType = .moment
        selectedTypeName = "moment"
    }
    
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return namesArrays.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let section_names = namesArrays[section]
        return section_names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID")!
        
        let section_names = namesArrays[indexPath.section]
        cell.textLabel?.text = section_names[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row < smart_album_subtypes.count {
            
            let section_types = subtypeArrays[indexPath.section]
            selectedSubtype = section_types[indexPath.row]
            
            let section_names = namesArrays[indexPath.section]
            selectedSubtypeName = section_names[indexPath.row]
        }else {
            selectedSubtype = .any
            selectedSubtypeName = "any"
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerID")!
        header.contentView.backgroundColor = UIColor.green
        header.textLabel?.textColor = UIColor.red
        header.textLabel?.text = section_headers[section]
        
        return header
    }
    
}
