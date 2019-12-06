public class TestPackage {
    
    
 /*   public ZCaseCommentDetails packageinstall(String name){
        
        ZCaseCommentDetails zccd = new ZCaseCommentDetails();
        zccd.zsfjira__Jira_Details__c=name;
        return zccd;
        
    }
    */
public Account createAccount(String name) { //method to create account
		Account acc = new Account();
		acc.Name = name;
		return acc;
	}    
    
    
}