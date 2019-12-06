public class ContactListCltr {
    
    @AuraEnabled 
    public static list<contact> getContactList(string accountId){
        list<contact> contactList = [select id,lastname,firstname,email,phone from contact where lastname !=null and accountid=:accountId] ;
        return contactList ;
    }

    @AuraEnabled
    public static contact createContact(contact con,id accountId){
        con.accountid=accountId;
        insert con;
        return con;
    }
    
}