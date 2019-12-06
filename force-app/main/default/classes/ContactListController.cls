/*
 * public class MyContactController {
    
    @AuraEnabled
    public static list<contact> getContacts(list<id> accountids){        
        list<contact> conlst = [select id,name,phone,accountid from contact where accountid in :accountids];        
        return conlst;        
    }
}
*/

// Apex Controller for Contact List Lightning Component
public class ContactListController {
	
    @AuraEnabled
    public static List<Contact> getContactList(List<Id> accountIds) {
    	// Getting the list of contacts from where Id is in accountIds
		List<Contact> contactList = [SELECT Id, Name, Email, Phone, AccountId FROM Contact WHERE AccountId in :accountIds];
		// Returning the contact list
        return contactList;
    }
}