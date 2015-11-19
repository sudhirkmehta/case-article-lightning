({
	getAttachedArticles: function(component) {
        var urlPath = window.location.pathname;
        var baseUrl = urlPath.substring(0,urlPath.lastIndexOf("mycase"));        
        baseUrl = baseUrl + 'article/';
        //alert('baseUrl: '+baseUrl);
        component.set("v.baseUrl", baseUrl);
        var action = component.get("c.getCaseArticles");
        action.setParams({
          "caseId": component.get("v.caseId")
        });
        action.setCallback(this, function(a) {
            component.set("v.caseArticles", a.getReturnValue());
            if(a.getReturnValue() != null){
                component.set("v.articleCount", a.getReturnValue().length);
            }
        });
        $A.enqueueAction(action);
    }
})