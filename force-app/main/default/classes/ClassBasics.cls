global class ClassBasics  Implements Schedulable {
    
    global void execute(SchedulableContext sc) {
		updateDetails();
    }
    public void updateDetails(){
        
        list<account> acclst = [select id,name,industry,phone from account];
        
        list<account> acc = new list<account>();
         for(account a:acclst){
            a.industry='Education';
             acc.add(a);             
        }
        update acc;
    }
}