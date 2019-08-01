trigger contactTrigger on Contact (after insert, after update, after delete, after undelete) {
    Set<Id> accIds = new set<Id>();
    List<Account> accToUpdate = new List<Account>();
    system.debug('Trigger.new>>'+Trigger.old);
    If(Trigger.isInsert || Trigger.isUndelete || Trigger.isUpdate){
        for(Contact c: Trigger.new){
            accIds.add(c.AccountId);
        }
    }
    If(Trigger.isDelete || Trigger.isUpdate){
        for(Contact c: Trigger.old){
            accIds.add(c.AccountId);
        }
    }
    List<Account> accList = [SELECT Id,Number_of_Contacts__c, (Select Id from Contacts) From Account where id in : accIds];
    
    for(Account acc: accList){
        acc.Number_of_Contacts__c = acc.Contacts.size();
        accToUpdate.add(acc);
    }
    update accToUpdate;
}