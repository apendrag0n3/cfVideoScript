<cfset variables.newrow = False>
<cfset yt = createObject("component", "#request.cfcpath#.youtube")>
<cfset tick = GetTickCount()>
<cfif isDefined('url.time')>
<cfset topFavs = #yt.getTopFavoritesVideos("#url.time#",1,50)#>
<cfelse>
<cfset topFavs = #yt.getTopFavoritesVideos("",1,50)#>
</cfif>
<cfset tock = GetTickCount()>
<table align="center" width="100%">
<cfoutput>
<cfset _searchtime = (tock - tick)/1000> 
<tr><td colspan="4"><div style="float:left;">Fetching data took <b class="errString">#_searchtime#</b> (locally) seconds</div><div style="float:right;">&nbsp;&nbsp;<a href="videos.cfm?action=topFav&time=today" title="Show Todays's Top viewed videos">Today</a> | <a href="videos.cfm?action=topFavs&time=this_week" title="Show this week's top viewed videos">This week</a> | <a href="videos.cfm?action=topFavs&time=this_month" title="Show this month's top viewed videos">This Month</a> | <a href="videos.cfm?action=topFavs&time=all_time" title="Ahow all time Top viewed Videos">All Time</a></div></td></tr>
</cfoutput>
<cfif topFavs.recordcount>
<cfinclude template="paging.cfm">
	<br />
    <div align="center">
    <cfoutput>
    Displaying <b>#pagination.getStartRow()#</b> to <b>#pagination.getMaxRows()#</b> of <b>#topFavs.total#</b> Records.
    </cfoutput>
    </div>
    <cfoutput>#pagination.getRenderedHTML()#</cfoutput>
    <cfoutput query="topFavs" startrow="#pagination.getStartRow()#" maxrows="#pagination.getMaxRows()#">
    <td height="30" valign="middle"><div class="leftcontentDIV" align="center"> <strong><a href="videos.cfm?action=show&ID=#ID#"> <img src="#thumbnail_url#" width="#thumbnail_width#" height="#thumbnail_height#" title="#title#" border="0"/></a><br>
        <cfinclude template="timing.cfm">
        <br>
        <div align="center">#Left(title,10)#...<br>
          <cfif averagerating GT 0>
            #repeatstring('<img src="images/star.png" width="16" height="16" title="#averagerating#" alt="Avg Rating: ' & averagerating &'">', int(averagerating))#
            <cfif int(#averagerating#) LT 5>
              #repeatstring('<img src="images/star-blank.png" width="16" height="16" title="#averagerating#" alt="Avg Rating: ' & averagerating &'">', 5-int(averagerating))#
            </cfif>
            <cfelse>
            #repeatstring('<img src="images/star-blank.png" width="16" height="16" alt="not rated yet" title="not rated yet">', 5)#
          </cfif>
          <br>
          <cfif #viewcount# IS "">0<cfelse>#viewcount#</cfif> views<br>
          <a href="videos.cfm?action=author&code=#author#" title="All Videos by #author#">#author#</a></div>
        </strong> </div>
      </td>
      <cfif topFavs.currentRow MOD 4 EQ 0>
        </tr>
        <cfset variables.newrow = true>
        <cfelse>
        <cfset variables.newrow = false>
      </cfif>
  </cfoutput>
  <cfelse>
  <tr><td colspan="4" align="center">
  <img src="images/smilo.gif" alt="No Top Favorites videos Found" border="0" /><br /><br />
  No Top Favorites Videos Found!
  </td></tr>
  </cfif>
  <tr>
</table>
