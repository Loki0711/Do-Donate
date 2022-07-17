//
//  AppDelegate.swift
//  Giveth
//
//  Created by Jagsifat Makkar on 2022-01-23.
//

import UIKit
import CoreData
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        self.preloadDataForPostModifications()
        return true
    }
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Giveth")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func preloadDataForPostModifications(){
        let ob1 = CharityUser(name: "The Boundless School", contact: "416-951-7059", address: "97 Kendal Avenue, ON M5R 1L8", city: "Toronto", country: "Canada", zipCode: "00000", description: "We started in 1984 as an outdoor adventure centre, experimenting with who we could help and how much we could inspire people to go beyond their limits. In 1989, we became a charity, figuring that we could change the world one paddle stroke at a time, and have since motivated 20,000 students to achieve outstanding outcomes. In 2004, we officially became a private high school, and life at Boundless has never been the same, resulting in longer and even more impactful education programs.", email: "boundlessschool@gmail.com", password: "school123", imageUrl: "https://firebasestorage.googleapis.com/v0/b/giveth-f4366.appspot.com/o/Boundless-menu-logo-color.png?alt=media&token=4998df1e-0546-4c6d-8734-e1c6e4e0d904")
        
        let ob2 = CharityUser(name: "HAROLD & GRACE BAKER CENTRE", contact: "416-654-2889", address: "1 Northwestern Ave, ON M6M 2J7", city: "Toronto", country: "Canada", zipCode: "00000", description: "At Harold & Grace Baker Centre Long Term Care Home, it’s all about the details, from compassion to care, everything you need is taken care of. This is a not-for-profit long term care home operated by Revera, where you can feel right at home.", email: "charit@bakercentre.com", password: "charitbaker@gmail.com", imageUrl: "https://firebasestorage.googleapis.com/v0/b/giveth-f4366.appspot.com/o/Harold.png?alt=media&token=0b7b74a7-2768-408c-be32-adbff2e034e6")
        
        let ob3 = CharityUser(name: "The Compass", contact: "905-274-9309", address: "427 Lakeshore Road East, ON L5G 1H8", city: "Mississauga", country: "Canada", zipCode: "00000", description: "Together, we provide help for today and hope for tomorrow   This mission statement was true when The Compass was founded by a group of local Christian Churches in 2002 and remains the foundation of what we do today.  We provide a safe and welcoming place for people to come to for help. We offer immediate assistance with food, then work with clients offering practical and spiritual support to the challenges that often come along with a low income.", email: "compass@gmail.com", password: "compass123", imageUrl: "https://firebasestorage.googleapis.com/v0/b/giveth-f4366.appspot.com/o/COMPASS-New-Logo2021.png?alt=media&token=c987b801-8830-4e49-9a39-bb46e0f0ac19")
        
        let ob4 = CharityUser(name: "DAILY BREAD FOOD BANK", contact: "416-203-0050", address: "191 New Toronto Street, ON M8V 2E7", city: "Toronto", country: "Canada", zipCode: "00000", description: "The Daily Bread Food Bank (DBFB) is a non-denominational Canadian charity organisation that strives to end hunger in urban communities. The organisation is based in Toronto, Ontario, and feeds thousands of low-income people a year. They also provide valuable resources to the same demographic in order to find them financial assistance and support when needed. The Daily Bread Food Bank is the largest food bank in Canada and was founded in 1983.", email: "dailybread@gmail.com", password: "dailybread123", imageUrl: "https://firebasestorage.googleapis.com/v0/b/giveth-f4366.appspot.com/o/dailybread.png?alt=media&token=e8062c98-223b-46a5-9d6b-efd2e8d2d25c")
        
        let ob5 = CharityUser(name: "Toronto Foundation for Student Success", contact: "416-394-6880", address: "2 Trethewey Drive, 4th Floor, ON M6M 4A8", city: "Toronto", country: "Canada", zipCode: "00000", description: "Our mission is to remove barriers for children so that every child is nourished and able to learn. By providing food, medical care, emergency funds and after school programs for children in need, we help them succeed in school.  Founded in 1998, the Toronto Foundation for Student Success (TFSS) is an independent, registered charitable organization dedicated to supporting Toronto District School Board (TDSB) children and helping remove barriers to their education.", email: "education@gmail.com", password: "education123", imageUrl: "https://firebasestorage.googleapis.com/v0/b/giveth-f4366.appspot.com/o/student.png?alt=media&token=f28503ca-aad1-4a19-a953-6abb47c5e56c")
        
        let ob6 = CharityUser(name: "FOODSHARES", contact: "416-363-6442", address: "120 Industry Street – Unit C, ON M6M 4L8", city: "Toronto", country: "Canada", zipCode: "00000", description: "FoodShare’s supporters help make a difference in the lives of hundreds of thousands across Toronto. THANK YOU to each and every one of our visionary donors, core funders, foundations, faith groups, unions and levels of government.", email: "foodshare@gmail.com", password: "foodshare123", imageUrl: "https://firebasestorage.googleapis.com/v0/b/giveth-f4366.appspot.com/o/foodshare.png?alt=media&token=5db39af4-63ad-4dfa-ae61-468d1fdb9017")
        
        let ob7 = CharityUser(name: "Street Health", contact: "416-921-8668", address: "338 Dundas Street East, ON M5A 2A1", city: "Toronto", country: "Canada", zipCode: "00000", description: "Street Health is a non-profit community based agency that improves the health of homeless and under-housed people in Toronto. We offer both physical and mental health programs. Our work is focused in the neighbourhood around Dundas and Sherbourne Streets, an area with the largest concentration of homeless shelters and drop-in centres in Canada.   We provide our services on the street, in parks, and in homeless shelters and drop-ins. The people we work with have lives characterized by extreme poverty, chronic unemployment, insecurity in housing, poor nutrition, high stress and loneliness. They also have more frequent and serious illnesses, and die younger on average than the general population.", email: "health@gmail.com", password: "health123", imageUrl: "https://firebasestorage.googleapis.com/v0/b/giveth-f4366.appspot.com/o/street-health-logo-full.jpg?alt=media&token=db718e44-39e6-4bc7-8e97-7991af314306")
        
        let ob8 = CharityUser(name: "East York Learning Experience", contact: "906-345-6273", address: "266 Donlands Ave, ON M4J 5B1", city: "Toronto", country: "Canada", zipCode: "00000", description: "We work with the Ontario Adult Literacy Curriculum Framework as mandated by our main funder, the Ministry of Training, Colleges & Universities. We use milestones designed by the Ministry to measure progress.  These milestones are tasks featuring real-life situations, designed for each of the 5 goal paths and the 3 levels of Literacy & Essential Skills.  They are scored based on strict guidelines.  Results are entered into our case management system which enables us to track each student’s progress.", email: "learning@gmail.com", password: "learning123", imageUrl: "https://firebasestorage.googleapis.com/v0/b/giveth-f4366.appspot.com/o/eastyork.png?alt=media&token=3d927c4c-a471-46ec-97ad-e24f4d0b8828")
        
        let ob9 = CharityUser(name: "ONTARIO ASSOCIATION OF FOOD BANKS (OAFB)", contact: "416-656-4100", address: "555 Richmond Street West, Suite 501, ON, M5V 3B1", city: "Toronto", country: "Canada", zipCode: "00000", description: "The Ontario Association of Food Banks (OAFB) is the umbrella organization for food banks across the Ontario, representing over 100 members. Food banks offer fresh, healthy food, as well as programs that go beyond emergency food support. This includes: training opportunities and apprentice programs, community gardens, shelter and housing help, child care, dental programs, budgeting and economics workshops, and employment search assistance.", email: "ontariofood@gmail.com", password: "ontariofood123", imageUrl: "https://firebasestorage.googleapis.com/v0/b/giveth-f4366.appspot.com/o/OAFB-Logo_2014-02-05.jpg?alt=media&token=57ad1eb6-a023-48d7-8fff-877acfae5bf3")
        
        let ob0 = CharityUser(name: "PARKDALE COMMUNITY FOOD BANK", contact: "416-532-2375", address: "1499 Queen Street West, ON, M6R 1A3", city: "Toronto", country: "Canada", zipCode: "00000", description: "The Parkdale Community Food Bank sits at the intersection of  Queen and Sorauren, nestled among iconic local businesses like Cici's Pizza, Parkdale Pet Foods, and the original Craig's Cookies location. Since 2007, it's been our mission to provide nutritious food for our community members -  which would not be possible without our partners and friends in the Parkdale community. ", email: "parkdale@gmail.com", password: "parkdale123", imageUrl: "https://firebasestorage.googleapis.com/v0/b/giveth-f4366.appspot.com/o/parkdale.png?alt=media&token=39754f9b-cd96-4365-8947-9a5bc04c569e")
        
        FirebaseService.saveRegisterCharity(registerObject: ob1)
        FirebaseService.saveRegisterCharity(registerObject: ob2)
        FirebaseService.saveRegisterCharity(registerObject: ob3)
        FirebaseService.saveRegisterCharity(registerObject: ob4)
        FirebaseService.saveRegisterCharity(registerObject: ob5)
        FirebaseService.saveRegisterCharity(registerObject: ob6)
        FirebaseService.saveRegisterCharity(registerObject: ob7)
        FirebaseService.saveRegisterCharity(registerObject: ob8)
        FirebaseService.saveRegisterCharity(registerObject: ob9)
        FirebaseService.saveRegisterCharity(registerObject: ob0)
        
    }
}

