public class MaintenanceRequestHelper {
    public static void updateWorkOrders(Map<Id,Case> cOldMap, Map<Id,Case> cNewMap){
        List<Id> caseToProcessIdList = new List<Id>();
        Map<Id,List<Work_Part__c>> caseIdToWpMap = new Map<Id,List<Work_Part__c>>();
        Map<Integer,Case> insertCaseMap = new Map<Integer,Case>();
        Map<Integer,List<Work_Part__c>> insertWpMap = new Map<Integer,List<Work_Part__c>>();
        List<Work_Part__c> insertAllWpList = new List<Work_Part__c>();
        Integer commonKey = 0;
        for(Id csId : cNewMap.keySet()){
            if(cOldMap.get(csId).status != 'Closed' && cNewMap.get(csId).status == 'Closed' && (cNewMap.get(csId).type == 'Repair' || cNewMap.get(csId).type == 'Routine Maintenance'))
                caseToProcessIdList.add(csId);
        }
        if(caseToProcessIdList.size() == 0)
            return;
        for (Work_Part__c wp: [Select Id, Name, Equipment__c, Equipment__r.Maintenance_Cycle__c, Maintenance_Request__c, Quantity__c From Work_Part__c Where Maintenance_Request__c IN :caseToProcessIdList]) {
            if(!caseIdToWpMap.containsKey(wp.Maintenance_Request__c))
                caseIdToWpMap.put(wp.Maintenance_Request__c, new List<Work_Part__c>{wp});
            else{
                List<Work_Part__c> tempList = caseIdToWpMap.get(wp.Maintenance_Request__c);
                tempList.add(wp);
                caseIdToWpMap.put(wp.Maintenance_Request__c, tempList);
            }
        }
        for(Id csId : caseToProcessIdList){
            List<Work_Part__c> relatedWpList = caseIdToWpMap.get(csId);
            List<Work_Part__c> insertWpList = new List<Work_Part__c>();
            Integer minDays;
            if(relatedWpList==null || relatedWpList.size()==0){
                relatedWpList = new List<Work_Part__c>();
                minDays = 0;
            }            
            for(Work_Part__c wp : relatedWpList){
                if(minDays == null || minDays >= wp.Equipment__r.Maintenance_Cycle__c.intValue())
                    minDays = wp.Equipment__r.Maintenance_Cycle__c.intValue();
                insertWpList.add(new Work_Part__c(Equipment__c=wp.Equipment__c, Quantity__c=wp.Quantity__c));
            }
            Case oldCase = cNewMap.get(csId);
            Case cse = new Case();
            cse.Type ='Routine Maintenance';
            cse.Status ='New';
            cse.Origin =oldCase.Origin;
            cse.Vehicle__c = oldCase.Vehicle__c;
            cse.Equipment__c = oldCase.Equipment__c;
            cse.Subject = String.isBlank(oldCase.Subject) ? 'subject' : oldCase.Subject;
            cse.Date_Reported__c = System.today();
            cse.Date_Due__c = System.Today().addDays(minDays);
            insertCaseMap.put(commonKey, cse);
            insertWpMap.put(commonKey, insertWpList);
            commonKey++;
        }
        insert insertCaseMap.values();
        for(Integer i : insertCaseMap.keySet()){
            for(Work_Part__c wp : insertWpMap.get(i)){
                wp.Maintenance_Request__c = insertCaseMap.get(i).Id;
                insertAllWpList.add(wp);
            }
        }
        insert insertAllWpList;
    }
}