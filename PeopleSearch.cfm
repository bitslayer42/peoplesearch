<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

<title>Search through phone list</title>

<!---<cfdump var="#form#">  --->
	<link rel="stylesheet" type="text/css" href="./PeopleSearch.css">
	
	<script type="text/javascript" src="https://ccp1.msj.org/scripts/jquery/jquery-1.8.2.min.js"></script>

	<script type="text/javascript">
		$(document).ready(function() {
			var small={width: "150px",height: "160px",top:"0px",left:"0px",borderRadius:"50%"};			
			var large={width: "200px",height: "269px",top:"-100px",left:"-10px",borderRadius:"0"};
			$(".pics").css(small)
			          .css("display","block");
			$(".pics")
				.on('mouseover',function () {
					  $(this).css({"box-shadow": "0px 2px 10px grey"});
				})
				.on('mouseout',function () {
					  $(this).css({"box-shadow": "none"});
				});
			$(".grow")	
				.on('click',function () { 
					if ($(this).is(':animated')) { return false; };
					$(this).css({"zIndex": 10}).animate(large,600);
					$(this).animate(large,1200);
					$(this).animate(small,600);
				})
		});
	</script>
  

<cffunction name="formatPhoneNumber">
   <cfargument name="phoneNumber" required="true" />

   <cfif IsNumeric(phoneNumber) AND len(phoneNumber) EQ 10>
       <!--- 10-digit phone numbers --->
       <cfreturn "(#left(phoneNumber,3)#) #mid(phoneNumber,4,3)#-#right(phoneNumber,4)#" />
   <cfelseif IsNumeric(phoneNumber) AND len(phoneNumber) EQ 7>
       <!--- 7-digit phone numbers --->
       <cfreturn "#left(phoneNumber,3)#-#right(phoneNumber,4)#" />
   <cfelse>
       <cfreturn phoneNumber />
   </cfif>
</cffunction>

<cfif NOT IsDefined("form.id") AND NOT IsDefined("form.searchby") AND NOT IsDefined("form.supv") AND 
	  NOT IsDefined("form.dept") AND NOT IsDefined("form.job")>
	<div style="margin:0 auto; text-align:center; width:300px; height:140px;">
	<img src="https://ccp1.msj.org/images/CarePartners_logo.png">
	<div class="h1">People Search</div>
	Enter a search term:
		<form name="peoplesearcho" method="post" action="https://ccp1.msj.org/telecom/peoplesearch/PeopleSearch.cfm">
		&nbsp;<input type="text" size="17" class="dropdown" name="searchby">&nbsp;<input type="submit" value="Search">
		</form>
	</div>
	<cfabort>
<cfelseif IsDefined("form.searchby") AND len(form.searchby) LT 2> 
	<cfset searchterm = replace(Form.searchby,"-",chr(0),"ALL") />
	<cfif len(searchterm) LTE 2>
		<div style="margin:0 auto; text-align:center; width:300px; height:140px;">
		<div class="h1">People Search</div>
		Please search using more letters.
		<cfform name="peoplesearcho" method="post" action="https://ccp1.msj.org/telecom/peoplesearch/PeopleSearch.cfm">
		&nbsp;<cfinput type="text" size="17" class="dropdown" name="searchby" value="#Form.searchby#"><input type="submit" value="Search Again" class="dropdown"></TD>
		</cfform>
		</div>
		<cfabort>	
	</cfif>
</cfif>
<cfif IsDefined("form.supv")>
	<cfstoredproc procedure="PeopleSearch" datasource="intranet-sql">
		<cfprocparam cfsqltype="cf_sql_varchar" null="true">
		<cfprocparam cfsqltype="cf_sql_varchar" value="#form.supv#"><!--- 2nd param is ID: returns supervisor herself --->
		<cfprocparam cfsqltype="cf_sql_varchar" null="true">
		<cfprocparam cfsqltype="cf_sql_varchar" null="true">
		<cfprocparam cfsqltype="cf_sql_varchar" null="true">
		<cfprocresult name="theresults">
	</cfstoredproc>
	<cfstoredproc procedure="PeopleSearch" datasource="intranet-sql">
		<cfif IsDefined("form.searchby")><cfprocparam cfsqltype="cf_sql_varchar" value="#trim(form.searchby)#">
			<cfelse><cfprocparam cfsqltype="cf_sql_varchar" null="true"></cfif>
		<cfif IsDefined("form.id")><cfprocparam cfsqltype="cf_sql_varchar" value="#form.id#">
			<cfelse><cfprocparam cfsqltype="cf_sql_varchar" null="true"></cfif>
		<cfif IsDefined("form.supv")><cfprocparam cfsqltype="cf_sql_varchar" value="#form.supv#">
			<cfelse><cfprocparam cfsqltype="cf_sql_varchar" null="true"></cfif>
		<cfif IsDefined("form.dept")><cfprocparam cfsqltype="cf_sql_varchar" value="#form.dept#">
			<cfelse><cfprocparam cfsqltype="cf_sql_varchar" null="true"></cfif>
		<cfif IsDefined("form.job")><cfprocparam cfsqltype="cf_sql_varchar" value="#form.job#">
			<cfelse><cfprocparam cfsqltype="cf_sql_varchar" null="true"></cfif>
		<cfprocresult name="supvees">
	</cfstoredproc>
<cfelse>
	<cfstoredproc procedure="PeopleSearch" datasource="intranet-sql">
		<cfif IsDefined("form.searchby")><cfprocparam cfsqltype="cf_sql_varchar" value="#trim(form.searchby)#">
			<cfelse><cfprocparam cfsqltype="cf_sql_varchar" null="true"></cfif>
		<cfif IsDefined("form.id")><cfprocparam cfsqltype="cf_sql_varchar" value="#form.id#">
			<cfelse><cfprocparam cfsqltype="cf_sql_varchar" null="true"></cfif>
		<cfif IsDefined("form.supv")><cfprocparam cfsqltype="cf_sql_varchar" value="#form.supv#">
			<cfelse><cfprocparam cfsqltype="cf_sql_varchar" null="true"></cfif>
		<cfif IsDefined("form.dept")><cfprocparam cfsqltype="cf_sql_varchar" value="#form.dept#">
			<cfelse><cfprocparam cfsqltype="cf_sql_varchar" null="true"></cfif>
		<cfif IsDefined("form.job")><cfprocparam cfsqltype="cf_sql_varchar" value="#form.job#">
			<cfelse><cfprocparam cfsqltype="cf_sql_varchar" null="true"></cfif>
		<cfprocresult name="theresults">
	</cfstoredproc>
	<cfquery name="supvees" datasource="intranet-sql">
	select null where 1=2
	</cfquery>
</cfif>

</head>


<body style="padding:40px">
<span style=" position:absolute; top:20px; left:20px; font-size:12px;">
	<a href="https://ccp1.msj.org/index.cfm">Return to intranet home page.</a>
</span>
<div style="margin:0 auto; text-align:center; width:300px; height:200px;">
	<img src="https://ccp1.msj.org/images/CarePartners_logo.png">
	<div class="h1">People Search</div>
	<cfif Isdefined("Form.searchby")>Search term: <cfoutput>#Form.searchby#</cfoutput></cfif>
    <form name="peoplesearcho" method="post" action="https://ccp1.msj.org/telecom/peoplesearch/PeopleSearch.cfm">
    &nbsp;<input type="text" size="17" class="dropdown" name="searchby" required>&nbsp;<input type="submit" value="Search Again" class="dropdown"></TD>
    </form>
</div>

<div style="margin:0 auto 100px auto;width:800px;display: flex;flex-direction: column;justify-content: flex-start;">
	<cfoutput query="theresults" group="IsCarePartners">
		<cfif IsCarePartners EQ 0>
			<div>
			<i>Mission Staff</i>
			</div>	
		</cfif>
		
		<cfoutput>

			<cfif IsCarePartners EQ 1>
				<div style="background-color:##FFF;display: flex;justify-content: flex-start;border:1px solid ##444;margin-bottom:10px;">
			<cfelse>
				<div style="background-color:##DDD;display: flex;justify-content: flex-start;border:1px solid ##444;margin-bottom:10px;">
			</cfif>

				<div style="padding-left:5px; height:160px;">
					<cfif FileName EQ "">
					<cfset PhotoLocation = "https://ccp1.msj.org/telecom/peoplesearch/nophoto.gif">
					<cfelse>
					<cfset PhotoLocation = "http://missionondemand.msj.org/empphotos/#FileName#"> 
					</cfif>

					<div class="pics grow" style="position:relative;background-image: url('#PhotoLocation#');">
						<div class="ovaltext">
							#Name#<br>
							<div class="jobt" style="font-size:0.7em">#JobTitle#</div>
						</div>
					</div>
		
				</div>

				<div style="font-size:0.8em;line-height:1.2em;padding:10px;">
					<div style="font-size:1.2em;"><b>#Name#</b></div>
					<div style="color:green;font-size:1.2em;">#JobTitle#</div>
					<cfif #supervisorname# NEQ ''><i>Supervisor:</i> <a href="##" onClick="searchsupv('#supervisorid#')">#supervisorname#</a><br></cfif>
					<cfif #Department# NEQ ''><i>Department:</i> <a href="##" onClick="searchdept('#Department#')">#Department#-#DepartmentName#</a><br></cfif>
					<cfif #JobCode# NEQ ''><i>Job Code:</i> <a href="##" onClick="searchjob('#JobCode#')">#JobCode#-#JobTitle#</a><br></cfif>
					<cfif #SupveeCount# GT 0>Supervises <a href="##" onClick="searchsupv('#employeeid#')">#SupveeCount# staff</a></cfif>
				</div>
				
				<div style="font-size:0.8em;line-height:1.2em;padding:10px;">
					<cfif #Extension# NEQ ''><i>Extension:</i> <b>#Extension#</b><br></cfif>
					<cfif #OfficePhone# NEQ ''><i>Office Phone:</i> <b>#OfficePhone#</b><br></cfif>
					<cfif #Mobile# NEQ ''><i>Cell:</i> <b>#formatPhoneNumber(Mobile)#</b><br></cfif>
					<cfif #Pager# NEQ ''><i>Pager:</i> <b>#Pager#</b><br></cfif>
					<cfif #EMail# NEQ ''><i>EMail:</i> <a href="mailto:#lcase(EMail)#" class="regularlinks">#lcase(EMail)#</a><br></cfif>
					<cfif #StreetAddress# NEQ ''>
						<i>Business Address: </i>
						<div><b>#StreetAddress#<br>
						#City#,#State# #PostalCode#</b>
						</div>
					</cfif>
				</div>
			</div>
		</cfoutput>
	</cfoutput>
	
<!--- supervisor mode --->
<cfif supvees.RecordCount GT 0>
	<div style="font-size:1.2em;margin:1.4em;">
		<cfoutput>#theresults.FirstName# #theresults.LastName# supervises #theresults.SupveeCount# staff:</cfoutput>
	</div>	
		<div style="background-color:##FFF;display: flex;justify-content: center;flex-wrap: wrap;">
			<cfoutput query="supvees">
				<cfif FileName EQ "">
				<cfset PhotoLocation = "https://ccp1.msj.org/telecom/peoplesearch/nophoto.gif">
				<cfelse>
				<cfset PhotoLocation = "http://missionondemand.msj.org/empphotos/#FileName#"> 
				</cfif>

				<a href="##" onClick="searchsupv('#employeeid#')">
					<div class="pics" style="position:relative;background-image: url('#PhotoLocation#');">
						<div class="ovaltext">
							#Name#<br>
							<div class="jobt" style="font-size:0.7em">#JobTitle#</div>
						</div>
						<cfif #SupveeCount# GT 0>
							<div class="supveecount">
								#SupveeCount#
							</div>
						</cfif>
					</div>
				</a>
			</cfoutput>
		</div>				
</cfif>
</div>
<script>
function searchid(id){
		$( "<input name='id' type='hidden' value="+id+">" ).appendTo( "#search" );
		$('#search').submit();
}
function searchdept(dept){
		$( "<input name='dept' type='hidden' value="+dept+">" ).appendTo( "#search" );
		$('#search').submit();
}
function searchjob(job){
		$( "<input name='job' type='hidden' value="+job+">" ).appendTo( "#search" );
		$('#search').submit();
}
function searchsupv(supv){
		$( "<input name='supv' type='hidden' value="+supv+">" ).appendTo( "#search" );
		$('#search').submit();
}


</script>
<form id="search" action="PeopleSearch.cfm" method="post">
</form>
</body>
</html>