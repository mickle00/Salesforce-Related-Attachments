public with sharing class CaseRelatedAttachmentsController{
  public CaseRelatedAttachmentsController(ApexPages.StandardController stdController) {
    this.myCase = [SELECT Id, ParentId, GSO_Contract__c FROM Case WHERE Id = :stdController.getRecord().Id];
  }

  public List<Attachment> getRelatedAttachments(){
    if (this.relatedAttachments == null){
      this.relatedAttachments = new List<Attachment>();
      this.relatedAttachments = [SELECT Id
                                        ,Name
                                        ,CreatedDate
                                        ,Parent.Name
                                        ,ParentId
                                FROM Attachment
                                WHERE ParentId IN (:myCase.ParentId, :myCase.GSO_Contract__c)];
    }
    return this.relatedAttachments;
  }

  public boolean getRender(){
    return this.getRelatedAttachments().size() != 0;
  }

  private Case myCase;
  private List<Attachment> relatedAttachments;
}