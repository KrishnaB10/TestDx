public class BearSearchAuraService {

    @AuraEnabled
    public static list<SObject> searchBear(string searchParam){
        string likeParam = '%' +searchParam+'%'; 
        string query = 'SELECT Id, Name FROM Beer__c where name like : likeParam limit 100';
        list<SObject> SObjectList = database.query(query);
        return SObjectList;
    }
    
}