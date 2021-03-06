<!---

    Slatwall - An e-commerce plugin for Mura CMS
    Copyright (C) 2011 ten24, LLC

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
    
    Linking this library statically or dynamically with other modules is
    making a combined work based on this library.  Thus, the terms and
    conditions of the GNU General Public License cover the whole
    combination.
 
    As a special exception, the copyright holders of this library give you
    permission to link this library with independent modules to produce an
    executable, regardless of the license terms of these independent
    modules, and to copy and distribute the resulting executable under
    terms of your choice, provided that you also meet, for each linked
    independent module, the terms and conditions of the license of that
    module.  An independent module is a module which is not derived from
    or based on this library.  If you modify this library, you may extend
    this exception to your version of the library, but you are not
    obligated to do so.  If you do not wish to do so, delete this
    exception statement from your version.

Notes:

--->
<cfparam name="rc.edit" default="false" />
<cfparam name="rc.attributeSet" type="any" />
 
<cfoutput>
	<ul id="navTask">
		<cfif !rc.attributeSet.isNew()><cf_SlatwallActionCaller action="admin:attribute.create" querystring="attributeSetId=#rc.attributeSet.getAttributeSetID()#" type="list"></cfif>
	    <cfif !rc.edit><cf_SlatwallActionCaller action="admin:attribute.editAttributeSet" querystring="attributeSetid=#rc.attributeSet.getAttributeSetID()#" type="list"></cfif>
		<cf_SlatwallActionCaller action="admin:attribute.list" type="list">
	</ul>
	<cfset local.attributeSetTypeSelected = "" />
	<cfif !isNull(rc.attributeSet.getAttributeSetType())>
		<cfset local.attributeSetTypeSelected = rc.attributeSet.getAttributeSetType().getType() />
	</cfif>
	<cfif rc.edit>
		<form name="attributeSetForm" id="attributeSetForm" enctype="multipart/form-data" action="#buildURL(action='admin:attribute.saveAttributeSet')#" method="post">
		<input type="hidden" id="attributeSetID" name="attributeSetID" value="#rc.attributeSet.getAttributeSetID()#" />
	</cfif>
	<dl class="oneColumn attributeDetail">
		<cf_SlatwallPropertyDisplay object="#rc.attributeSet#" property="attributeSetName" edit="#rc.edit#" />
		<cf_SlatwallPropertyDisplay object="#rc.attributeSet#" property="globalFlag" edit="#rc.edit#" tooltip=true />
		<cf_SlatwallPropertyDisplay object="#rc.attributeSet#" property="attributeSetType" value="#local.attributeSetTypeSelected#" edit="#rc.edit#" />
		<cf_SlatwallPropertyDisplay object="#rc.attributeSet#" property="attributeSetDescription" edit="#rc.edit#" toggle="show" toggletext="#rc.$.Slatwall.rbKey('sitemanager.content.fields.expand')#,#rc.$.Slatwall.rbKey('sitemanager.content.fields.close')#" editType="wysiwyg" />
	</dl>
	<cfif rc.edit>
		<div id="actionButtons" class="clearfix">
			<cf_SlatwallActionCaller action="admin:attribute.list" type="link" class="button" text="#rc.$.Slatwall.rbKey('sitemanager.cancel')#">
			<cfif not rc.attributeSet.hasAttribute() and !rc.attributeSet.isNew()>
				<cf_SlatwallActionCaller action="admin:attribute.deleteAttributeSet" querystring="attributeSetID=#rc.attributeSet.getAttributeSetID()#" type="link" class="button" confirmrequired="true" text="#rc.$.Slatwall.rbKey('sitemanager.delete')#">
			</cfif>
			<cf_SlatwallActionCaller action="admin:attribute.saveAttributeSet" type="submit"  class="button">
		</div>
		</form>
	<cfelse>
		<h4>#rc.$.Slatwall.rbKey('entity.attributeSet.attributes')#</h4>
		<ul id="attributeList">
		<cfloop array="#rc.attributeSet.getAttributes()#" index="local.thisAttribute">
			<li>#local.thisAttribute.getAttributeName()#</li>
		</cfloop>
		</ul>
	</cfif>
</cfoutput>
