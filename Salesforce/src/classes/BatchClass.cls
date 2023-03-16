public class BatchClass implements Database.Batchable<sObject>,Database.AllowsCallouts{
        String contactsQuery='';
        set<Id> contactUserId = new set<Id>();
        public BatchClass(set<Id> contactId){
          system.debug(contactId);
           contactUserId=contactId;
           contactsQuery = 'select Id,Email,Name,Phone,Potential_Candidate__c, Baton_User_Id__c, Baton_Response_Status__c from  contact where Potential_Candidate__c = true And Id=:contactUserId';
        }
        public Database.QueryLocator start(Database.BatchableContext BC) {
          system.debug('8--enter the start method');
          
          return Database.getQueryLocator(contactsQuery);
        }
        public void execute(Database.BatchableContext BC, List<Contact> con){
          system.debug('13--enter the execute method' + con);
          List<Contact> contactuserslist = new List<Contact>();
           for(Contact cnt : con){
             //  if (cnt.Baton_User_Id__c != NULL) {  
            //    system.debug('17--baton user id not equal to null' + cnt.Baton_User_Id__c);                          //-----------> is not equal to null and hits the reset password.(existing baton)
             //      cnt.Baton_Response_Status__c = ContactHttpCallout.makeGetCallout(String.valueOf(cnt.Email));
               //    system.debug('19--baton user status' + cnt.Baton_Response_Status__c);
              // }else{               
               // system.debug('21--baton user id equal to null' + cnt.Baton_User_Id__c);                                                            //---------> is equal to null and hits the signup user.
                    ContactHttpCallout.makePostCallout(cnt);
                  // cnt.Baton_User_Id__c=status[0];
                  // cnt.Baton_Response_Status__c = status[1];
              // }
              // contactuserslist.add(cnt);
            //   system.debug('27--baton user id equal to null' + contactuserslist);                                                            //----------------------->update (cnt)
           }
          // ------------> update contactuserslist;
        }
        public void finish(Database.BatchableContext BC){}
        
      }