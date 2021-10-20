import UIKit

class PListManager: NSObject
{
    
    //singleton - make it once and use it throughout the app
    static var dataSharedInstance = PListManager()
    static var sharedInstance: PListManager
    {
        return self.dataSharedInstance
    }
    
    public func readMainBundlePList(namePList: String) -> NSMutableDictionary
    {
        let path = Bundle.main.path(forResource: namePList, ofType: "plist")
        let dictionary: NSMutableDictionary = NSMutableDictionary(contentsOfFile: path!)!
        return dictionary
    }
    
    
    //write to the documents directory
    func writeToDocumentsDirectoryPlist(namePlist: String, key: String, data: NSMutableDictionary)
    {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentsDirectory = paths.object(at: 0) as! NSString
        let path = documentsDirectory.appendingPathComponent(namePlist+".plist")
        
        if let dict = NSMutableDictionary(contentsOfFile: path)
        {
            dict.setObject(data, forKey: key as NSCopying)
            if dict.write(toFile: path, atomically: true)
            {
                print("plist_write")
                print(dict)
            }
            else
            {
                print("plist_write_error")
            }
        }
        else
        {
            if let privPath = Bundle.main.path(forResource: namePlist, ofType: "plist")
            {
                if let dict = NSMutableDictionary(contentsOfFile: privPath)
                {
                    dict.setObject(data, forKey: key as NSCopying)
                    if dict.write(toFile: path, atomically: true)
                    {
                        print("plist_write")
                    }
                    else
                    {
                        print("plist_write_error")
                    }
                }
                else
                {
                    print("plist_write")
                }
            }
            else
            {
                print("error_find_plist")
                print("FINAL", path)
            }
        }
    }
    
    
    
    //read from the documents directory
    func readFromDocumentsDirectoryPlist(namePlist: String, key: String) -> AnyObject
    {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentsDirectory = paths.object(at: 0) as! NSString
        let path = documentsDirectory.appendingPathComponent(namePlist+".plist")
        
        var output:AnyObject = false as AnyObject
        
        if let dict = NSMutableDictionary(contentsOfFile: path)
        {
            output = dict.object(forKey: key)! as AnyObject
        }
        else
        {
            if let privPath = Bundle.main.path(forResource: namePlist, ofType: "plist")
            {
                if let dict = NSMutableDictionary(contentsOfFile: privPath)
                {
                    output = dict.object(forKey: key)! as AnyObject
                }
                else
                {
                    output = false as AnyObject
                    print("error_read")
                }
            }
            else
            {
                output = false as AnyObject
                print("error_read")
            }
        }
        print("plist_read \(output)")
        return output
    }
    
    
    

}

