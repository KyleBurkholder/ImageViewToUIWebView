//
//  ViewController.swift
//  ImageViewToUIWebView
//
//  Created by Kyle Burkholder on 7/8/18.
//  Copyright © 2018 Kyle Burkholder. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var collectionView: UICollectionView!
    
    let testURLs: [URL] =  [
        URL(string: "https://www.amazon.com/gp/product/B0788R7HM3/ref=s9_acsd_ri_bw_cr_x__a_w?pf_rd_m=ATVPDKIKX0DER&pf_rd_s=merchandised-search-9&pf_rd_r=VMMZ30XQJZXBR4BP40E4&pf_rd_r=VMMZ30XQJZXBR4BP40E4&pf_rd_t=101&pf_rd_p=b8fb56da-1948-401c-abee-e449c9a89865&pf_rd_p=b8fb56da-1948-401c-abee-e449c9a89865&pf_rd_i=283155")!,
        URL(string: "https://www.amazon.com/gp/product/B077GS75HG/ref=s9_acsd_ri_bw_cr_x__a_w?pf_rd_m=ATVPDKIKX0DER&pf_rd_s=merchandised-search-9&pf_rd_r=VMMZ30XQJZXBR4BP40E4&pf_rd_r=VMMZ30XQJZXBR4BP40E4&pf_rd_t=101&pf_rd_p=b8fb56da-1948-401c-abee-e449c9a89865&pf_rd_p=b8fb56da-1948-401c-abee-e449c9a89865&pf_rd_i=283155")!,
        URL(string: "https://www.amazon.com/gp/product/B078JGDYX8/ref=s9_acsd_ri_bw_cr_x__a_w?pf_rd_m=ATVPDKIKX0DER&pf_rd_s=merchandised-search-9&pf_rd_r=VMMZ30XQJZXBR4BP40E4&pf_rd_r=VMMZ30XQJZXBR4BP40E4&pf_rd_t=101&pf_rd_p=b8fb56da-1948-401c-abee-e449c9a89865&pf_rd_p=b8fb56da-1948-401c-abee-e449c9a89865&pf_rd_i=283155")!
    ]
    
    let testImages: [UIImage] = [ #imageLiteral(resourceName: "AKillersMind"), #imageLiteral(resourceName: "WhisperMeThis"), #imageLiteral(resourceName: "TheKingTides") ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.delegate = self
        collectionView.dataSource = self
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        {
            layout.scrollDirection = .horizontal
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate
{
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionViewCell", for: indexPath)
        if let bookCell = cell as? BookCollectionViewCell
        {
            bookCell.image = testImages[indexPath.row]
            bookCell.delegate = self
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.bounds.height
        var aspectRatio: CGFloat = 1.0
        if let image = UIImage(named: "BookCover")
        {
        aspectRatio = image.size.width / image.size.height
        }
        let width = height * aspectRatio
        return CGSize(width: width, height: height)
    }
    
    //MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "ToWebView"
        {
            let webVC = segue.destination as! WebViewController
            if let cell = sender as? UICollectionViewCell
            {
                if let index = collectionView.indexPath(for: cell)
                {
                    webVC.urlToLoad = testURLs[index.row]
                }
            }
        }
    }
    

}

extension ViewController: BookColletionViewDelegate
{
    func tappedBook(for bookCell: UICollectionViewCell) {
        performSegue(withIdentifier: "ToWebView", sender: bookCell)
    }
}
