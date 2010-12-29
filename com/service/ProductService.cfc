import slatwall.com.*;
component extends="slatwall.com.service.BaseService" accessors="true" {
	
	property name="skuDAO" type="any";
	property name="contentManager" type="any";
	property name="settingsManager" type="any";
	
	public any function init(required any entityName, required any dao, required any skuDAO, required any contentManager, required any settingsManager) {
		setEntityName(arguments.entityName);
		setDAO(arguments.DAO);
		setSkuDAO(arguments.skuDAO);
		setContentManager(arguments.contentManager);
		setSettingsManager(arguments.settingsManager);
		
		return this;
	}
	
	public any function getSmartList(required struct rc){
		
		var smartList = new entity.SmartList(rc=arguments.rc, entityName=getEntityName());
		
		smartList.addKeywordProperty(rawProperty="productCode", weight=1);
		smartList.addKeywordProperty(rawProperty="productName", weight=1);
		smartList.addKeywordProperty(rawProperty="productDescription", weight=1);
		smartList.addKeywordProperty(rawProperty="brand_brandID", weight=1);
		smartList.addKeywordProperty(rawProperty="brand_brandName", weight=1);
		
		return getDAO().fillSmartList(smartList=smartList, entityName=getEntityName());	
	}
	
	public any function getProductTemplates() {
		return getSettingsManager().getSite(session.siteid).getTemplates();
	}
	
	public any function validateSave(required any entity) {
		
	}
}