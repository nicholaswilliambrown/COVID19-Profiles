<%@ Page Language="C#" ContentType="text/plain" %>
<%Response.Write("User-Agent: *" + Environment.NewLine);%>
<%Response.Write("Disallow: /shindigorng/" + Environment.NewLine);%>
<%Response.Write("Disallow: /sparql/" + Environment.NewLine);%>
<%Response.Write("Disallow: /*?Publications=All" + Environment.NewLine);%>
<%Response.Write("Sitemap: " + Profiles.Framework.Utilities.Root.Domain + "/SiteMap.ashx" + Environment.NewLine);%>
<%Response.Write("Crawl-Delay: 10" + Environment.NewLine);%>
