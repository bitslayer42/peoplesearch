
	<cfcontent type="application/json" reset="yes">
	<cfstoredproc procedure="PeopleSearchNU" datasource="intranet-sql">
		<cfif IsDefined("url.searchby")><cfprocparam cfsqltype="cf_sql_varchar" value="#trim(url.searchby)#">
			<cfelse><cfprocparam cfsqltype="cf_sql_varchar" null="true"></cfif>
		<cfif IsDefined("url.id")><cfprocparam cfsqltype="cf_sql_varchar" value="#url.id#">
			<cfelse><cfprocparam cfsqltype="cf_sql_varchar" null="true"></cfif>
		<cfif IsDefined("url.supv")><cfprocparam cfsqltype="cf_sql_varchar" value="#url.supv#">
			<cfelse><cfprocparam cfsqltype="cf_sql_varchar" null="true"></cfif>
		<cfif IsDefined("url.dept")><cfprocparam cfsqltype="cf_sql_varchar" value="#url.dept#">
			<cfelse><cfprocparam cfsqltype="cf_sql_varchar" null="true"></cfif>
		<cfif IsDefined("url.job")><cfprocparam cfsqltype="cf_sql_varchar" value="#url.job#">
			<cfelse><cfprocparam cfsqltype="cf_sql_varchar" null="true"></cfif>
		<cfif IsDefined("url.maxrows")><cfprocparam cfsqltype="cf_sql_integer" value="#url.maxrows#">
			<cfelse><cfprocparam cfsqltype="cf_sql_integer"  value="0"></cfif>
    <cfprocresult resultset="1" name="staff">
    <cfprocresult resultset="2" name="supvees">    
	</cfstoredproc>

	<cfset loopctr = 1>
  { "staff" :
	  [
	  <cfoutput query="staff">
	  { "IsCarePartners": "#IsCarePartners#"
	  , "EmployeeID": "#EmployeeID#"
	  , "FirstName": "#FirstName#"
	  , "LastName": "#LastName#"
	  , "Name": "#Name#"
	  , "LegalFirstName": "#LegalFirstName#"
	  , "Mobile": "#Mobile#"
	  , "OfficePhone": "#OfficePhone#"
	  , "Extension": "#Extension#"
	  , "Department": "#Department#"
	  , "DepartmentName": "#DepartmentName#"
	  , "JobCode": "#JobCode#"
	  , "JobTitle": "#JobTitle#"
	  , "Pager": "#Pager#"
	  , "Email": "#Email#"
	  , "StreetAddress": "#REReplace(StreetAddress,"[^0-9A-Za-z ]","","all")#"
	  , "City": "#City#"
	  , "State": "#State#"
	  , "PostalCode": "#PostalCode#"
	  , "FileName": "#FileName#"
	  , "SupervisorID": "#SupervisorID#"
	  , "SupervisorName": "#SupervisorName#"
	  , "SupveeCount": "#SupveeCount#"

	  }
	  <cfif loopctr NEQ staff.RecordCount>,</cfif>
	  <cfset loopctr = loopctr + 1>
	  </cfoutput>
	  ]
  <cfif IsDefined("supvees")>  
  , "supvees":
  <cfset loopctr = 1>    
	  [
	  <cfoutput query="supvees">
	  { "Name": "#Name#"
    , "EmployeeID": "#EmployeeID#"
	  , "JobTitle": "#JobTitle#"
	  , "FileName": "#FileName#"
	  , "SupveeCount": "#SupveeCount#"

	  }
	  <cfif loopctr NEQ supvees.RecordCount>,</cfif>
	  <cfset loopctr = loopctr + 1>
	  </cfoutput>
	  ]
  </cfif>  
  }
  
  <!---
  
  https://ccp1.msj.org/telecom/peoplesearch/peoplesearchreact/public/PeopleSearch.cfm?searchby=GUZY
  https://ccp1.msj.org/telecom/peoplesearch/peoplesearchreact/public/PeopleSearch.cfm?supv=1026956
  --->