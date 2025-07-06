public class AccountContactWrapper {
    public Account acc { get; set; } // acc stores account record
    public Contact primaryContact { get; set; } // primaryContact stores contact record 
    
    //constructor
    public AccountContactWrapper (Account acc, Contact primaryContact) {
        this.acc = acc;
        this.primaryContact = primaryContact;
    }
}