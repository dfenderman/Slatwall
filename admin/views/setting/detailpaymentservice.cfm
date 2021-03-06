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

<cfparam name="rc.edit" />
<cfparam name="rc.paymentServicePackage" />
<cfparam name="rc.paymentService" />
<cfparam name="rc.errors" default="#structNew()#" />

<cfset local.serviceMeta = getMetaData(rc.paymentService) />

<cfoutput>
	<div class="svoadminsettingdetailPaymentService">
		<ul id="navTask">
	    	<cf_SlatwallActionCaller action="admin:setting.listPaymentMethods" type="list">
			<cf_SlatwallActionCaller action="admin:setting.listPaymentServices" type="list">
		</ul>

		<cfif !structIsEmpty(rc.errors)>
			<ul class="error">
				<cfloop collection="#rc.errors#" item="local.thisError">
					<li>#rc.errors[local.thisError]#</li>
				</cfloop>
			</ul>
		</cfif>
		
		<cfif rc.edit>
			<form name="savePaymentService" method="post" action="#buildURL(action='admin:setting.savePaymentService')#">
				<input type="hidden" name="paymentServicePackage" value="#rc.paymentServicePackage#" />
		</cfif>
		<cfif structKeyExists(local.serviceMeta, "properties")>
			<dl>
				<cfloop array="#local.serviceMeta.properties#" index="local.property">
					
					<!--- Get The Property Title --->
					<cfset local.propertyTitle = "" />
					<cfif structKeyExists(local.property, "displayName")>
						<cfset local.propertyTitle = local.property.displayName />
					<cfelse>
						<cfset local.propertyTitle = local.property.name />
					</cfif>
					<cfset local.propertyEditType = "" />
					<cfif structKeyExists(local.property, "editType")>
						<cfset local.propertyEditType = local.property.editType />
					</cfif>
					<cf_SlatwallPropertyDisplay object="#rc.paymentService#" fieldName="paymentService.#local.property.name#" property="#local.property.name#" title="#local.propertyTitle#" edit="#rc.edit#" editType="#local.propertyEditType#">
				</cfloop>
			</dl>
		</cfif>
		<cfif rc.edit>
			<cf_SlatwallActionCaller action="admin:setting.listPaymentServices" class="button" text="#rc.$.Slatwall.rbKey('sitemanager.cancel')#">
			<cf_SlatwallActionCaller action="admin:setting.savePaymentService" type="submit" class="button">
			</form>
		</cfif>
	</div>
</cfoutput>

