public class AngularJsPaginationController
{
    @RemoteAction
    public static List<Account> getMyAccounts(String srchString) {
       /* List<Account> accList  = new List<Account>();
        String soqlQuery = 'Select Id, Name,Phone,Type,BillingCountry from Account';
        if(srchString != '')
        {
            soqlQuery += ' WHERE Name LIKE  \'%' + String.escapeSingleQuotes(srchString) + '%\'';
        }
        accList = Database.query(soqlQuery);
        return accList;*/
        return Database.query('Select Id, Name,Phone,Type,BillingCountry from Account');
    }
    @RemoteAction
    public static String getSaveAccounts(String deleteRecord, String updateRecord) {
        List<Account> updateAccountList = (List<Account>)JSON.deserialize(updateRecord, List<Account>.class);
        List<Account> deleteAccountList = (List<Account>)JSON.deserialize(deleteRecord, List<Account>.class);
        Savepoint sp = Database.setSavepoint();
        try {
            update updateAccountList;
            delete deleteAccountList;
        } catch(Exception e) {
            System.debug(e.getMessage());
            Database.rollback(sp);
            return e.getMessage();
        }
        return 'Success';
    }
    @RemoteAction
    public static String getDeleteAccounts(String record) {
        List<Account> account = (List<Account>)JSON.deserialize(record, List<Account>.class);
        try {
            System.debug(account);
            delete account;
        } catch(Exception e) {
            return e.getMessage();
            System.debug(e.getMessage());
        }
        return 'Success';
    }
}