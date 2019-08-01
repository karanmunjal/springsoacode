public class recentAccounts {
    @AuraEnabled
    public static List<Account> returnAcc(){
        List<Account> accList = [SELECT ID, Name, Type FROM Account ORDER BY createdDate DESC LIMIT 10];
        return accList;
    }
}