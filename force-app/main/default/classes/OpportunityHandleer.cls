/*
		1 	if customer create opportunity always closedate should be today+5 days and opp name should be IBM and 
			Stagename should be Qualififcation 
	
		2   customer create opporutnity if closedate not equal to today then campaign should create record
		
		3   if customer try to modify record on opporutnity leadsource should be Email

		4  Customer try to modify record on opportunity if the name is equal to IBM then create new case

		5  if opportunity stagename not equal to null then we need to send error message you can not delete record.

*/
public class OpportunityHandleer {    
    
    public static void BeforeInsert(list<opportunity> opplst){       
        for(opportunity opp: opplst ){
            opp.closeDate=system.today()+5;
            opp.name='IBM';
            opp.stagename='Qualification';           
        }     
    }
    
    public static void AfterInsert(list<opportunity> opplst){        
        list<Campaign> cmlst = new   list<Campaign>();
         for(opportunity opp: opplst ){
             if(opp.closeDate != system.today()){
                 Campaign cm = new Campaign();
                 cm.ActualCost=123333;
                 cm.Name='TV Advertising';
                 cmlst.add(cm);
             }                      
        } insert cmlst;          
    }
    
    public static void BeforeUpdate(list<opportunity> opplst){
        for(opportunity opp:opplst){
            if(opp.LeadSource==null){
                opp.LeadSource='Email';
            }
        }
    }
    public static void AfterUpdate(list<opportunity> opplst){
        list<case> clst = new list<case>(); 
        for(opportunity opp : opplst){
            if(opp.name=='IBM'){
                case c = new case();
               // c.RecordType.name='Inquery';
                c.Status='new';
                c.Priority='Medium';
                c.Origin='Phone';
                clst.add(c);
            }
            insert clst;
        }
    }
    public static void BeforeDelete(list<opportunity> opplst){
        
		//	list<contact> conlst = new list<contact>();        
        for(opportunity opp : opplst ){  
            if(opp.StageName !=null){
                opp.name.addError('You can not delete opportunity name');
           /*   contact con = new contact();
                con.Lastname=opp.Name;
                conlst.add(con);
                system.debug('BeforeDelete');*/
            }            
        }
        //insert conlst;
    }
    public static void BeforeDeleteOpp(list<opportunity> opplst){
        set<id> ids = new set<id>();
        for(opportunity opp :opplst){
            ids.add(opp.id);
            system.debug('AfterDelete');
        }
        list<OpportunityLineItem> oplIst = [select id, quantity, unitPrice, totalPrice, productCode,PricebookEntry.Product2.name, opportunity.name, opportunity.amount from OpportunityLineItem where opportunityid in : ids ];
        	system.debug('OpportunityLineItem'+oplIst);
        delete oplIst;
     		
                                                                      
                                                                      
    }
}