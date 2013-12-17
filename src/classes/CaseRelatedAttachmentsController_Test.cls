@isTest(seeAllData = false)
private class CaseRelatedAttachmentsController_Test{
  static Case getTestCase(){
    Case parentCase = new Case (Subject = 'Im teh parent');
    insert parentCase;

    Attachment testAttach = new Attachment(Name = 'TestAttachment', Body = blob.valueOf('super important'), ParentId = parentCase.Id);
    insert testAttach;

    Case myCase = new Case (Subject = 'Test', ParentId = parentCase.Id);
    insert myCase;

    return myCase;
  }
  static testMethod void shouldRender(){
    ApexPages.StandardController sc = new ApexPages.StandardController(getTestCase());
    CaseRelatedAttachmentsController myController = new CaseRelatedAttachmentsController(sc);

    system.assertEquals(myController.getRender(), true);
  }

  static testMethod void shouldNotRender(){
    getTestCase();
    Case parentCase = [SELECT Id, ParentId, GSO_Contract__c FROM Case WHERE ParentId = '' LIMIT 1];
    ApexPages.StandardController sc = new ApexPages.StandardController(parentCase);
    CaseRelatedAttachmentsController myController = new CaseRelatedAttachmentsController(sc);

    system.assertEquals(myController.getRender(), false);
  }
}