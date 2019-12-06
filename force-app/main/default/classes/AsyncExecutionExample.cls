public class AsyncExecutionExample  implements Queueable{    
    public void tstMethod(){
        
        system.debug('Planin method testing');
        
    }
    
    public void execute(System.QueueableContext qc){
        account a = new account(name='IBM');        
        insert a;
        system.debug('Test');
    }
    

}