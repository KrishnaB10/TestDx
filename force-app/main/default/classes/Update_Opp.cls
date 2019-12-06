public class Update_Opp {
    public list<opportunity> opplst{set;get;}
    public update_Opp(Apexpages.standardsetcontroller controller){
        list<string> fields = new list<string>{'name','stagename','closedate','amount'};
            controller.addFields(fields);
        opplst = (list<opportunity>)controller.getSelected();	
    }
    public pagereference callMe(){
        for(opportunity opp:opplst){
            opp.stagename='Closed Won';
        }
        update opplst;
        pagereference p = new pagereference('/006');
        return p;
    }	
}