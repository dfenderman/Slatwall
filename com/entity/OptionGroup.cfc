component displayname="Option Group" entityname="SlatwallOptionGroup" table="SlatwallOptionGroup" persistent=true output=false accessors=true extends="slatwall.com.entity.BaseEntity" {
	
	// Persistant Properties
	property name="optionGroupID" ormtype="string" lenth="32" fieldtype="id" generator="uuid" unsavedvalue="" default="";
	property name="optionGroupName" ormtype="string";
	property name="optionGroupImage" ormtype="string";
	property name="optionGroupDescription" ormtype="string";
	
	// Related Object Properties
	property name="options" singularname="option" type="array" cfc="Option" fieldtype="one-to-many" fkcolumn="optionGroupID" inverse="true" cascade="all" ;

}