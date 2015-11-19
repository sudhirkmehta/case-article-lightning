/*
 * This controller class is invoked from CaseArticle lightning component.
 * This class collects all the articles attached to case. 
*/
public without sharing class CaseArticleController {
    
    @AuraEnabled
    public static List<KnowledgeArticleVersion> getCaseArticles(Id caseId){
        List<KnowledgeArticleVersion> caseArticleList = null;
        List<String> caseArticleIds = new List<String>();
        List<CaseArticle> knowArtList = [SELECT KnowledgeArticleId, CaseId FROM CaseArticle WHERE CaseId = :caseId];
        system.debug('CaseArticleController.getCaseArticles() knowArtList.size(): '+knowArtList.size());
        if(knowArtList.size() > 0){
            for(CaseArticle article:knowArtList){
                caseArticleIds.add(article.KnowledgeArticleId);
            }
            system.debug('CaseArticleController.getCaseArticles() caseArticleIds.size(): '+caseArticleIds.size());
            if(caseArticleIds.size() > 0){
                caseArticleList = [SELECT Title, Summary, UrlName FROM KnowledgeArticleVersion 
                                                             WHERE PublishStatus='Online' AND KnowledgeArticleId IN :caseArticleIds AND Language = 'en_US'];
                system.debug('CaseArticleController.getCaseArticles() caseArticleList.size(): '+caseArticleList.size());
            }    
        }
        return caseArticleList;
    }
}