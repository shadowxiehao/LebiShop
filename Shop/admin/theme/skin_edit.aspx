﻿<%@ Page Language="C#" AutoEventWireup="true" Inherits="Shop.Admin.theme.Skin_Edit" validateRequest="false"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta content="text/html; charset=UTF-8" http-equiv="content-type" />
<meta name="author" content="LebiShop" />

    <title><%=model.Name %>-<%=theme.Name %>-<%=Tag("主题管理")%>-<%=site.title%></title>
    <style>
    textarea
    {
       font-size:12px;
     }
    </style>

<script src="<%=site.AdminJsPath %>/jquery-3.1.0.min.js"></script>
<script src="<%=site.AdminJsPath %>/jquery-migrate-1.2.1.js"></script>
<script src="<%=site.AdminJsPath %>/Cookies.js"></script>
<script src="<%=site.AdminJsPath %>/main.js"></script>
<script src="<%=site.AdminJsPath %>/messagebox.js"></script>
<script src="<%=site.AdminJsPath %>/master.js"></script>
<script src="<%=site.AdminJsPath %>/jquery-ui/jquery-ui.min.js"></script>
<%if (CurrentLanguage.Code=="CN"){%><script src="<%=site.AdminJsPath %>/jquery-ui/datepicker-zh-CN.js"></script><%}%>
<link rel="stylesheet" type="text/css" href="<%=site.AdminCssPath %>/css.css" />
<link rel="stylesheet" type="text/css" href="<%=site.AdminJsPath %>/jquery-ui/jquery-ui.min.css" />
<link rel="stylesheet" type="text/css" href="<%=site.AdminJsPath %>/jquery-ui/jquery-ui.theme.min.css" />
<link rel="stylesheet" type="text/css" href="<%=site.AdminJsPath %>/lightbox/lightbox.min.css" />
<%if (Shop.LebiAPI.Service.Instanse.Check("managelicenese")){%>
<style>#body_head #logo {width:112px;height:62px;background:url(<%=site.AdminImagePath %>/2015/logo_oem.gif) center 20px #0669c5 no-repeat;float:left;}</style>
<%}%>
<script>
    var AdminPath = "<%=site.AdminPath %>";var WebPath ="<%=site.WebPath %>";var AdminImagePath = "<%=site.AdminImagePath %>";var requestPage = "<%=Shop.Tools.RequestTool.GetRequestUrl().ToLower() %>";var refPage = "<%=Shop.Tools.RequestTool.GetUrlReferrer().ToLower() %>";
    function quit() { if (confirm("<%=Tag("您确定要退出吗？")%>")) return true; else return false; }
</script>

</head>
<body>
<div id="body_head">
  <div class="admintop">
    <div id="logo">
        <a href="<%=site.AdminPath %>/ajax/ajax_admin.aspx?__Action=MenuJump&pid=0"></a>
        <%=LicenseString %>
    </div>
    <%=Version %>
    <div class="admininfo">
        <div id="NewEvent">
            <span><%=Tag("未确认")%></span><em><a href="<%=site.AdminPath %>/order/default.aspx?t=211&type=1"><span id="NewEvent_Order_IsVerified"><%=SYS.NewEvent_Order_IsVerified%></span></a></em>
            <span><%=Tag("已支付")%></span><em><a href="<%=site.AdminPath %>/order/default.aspx?t=211&type=4"><span id="NewEvent_Order_IsPaid"><%=SYS.NewEvent_Order_IsPaid%></span></a></em>
            <span><%=Tag("未发货")%></span><em class="noborder"><a href="<%=site.AdminPath %>/order/default.aspx?t=211&type=5"><span id="NewEvent_Order_IsShipped"><%=SYS.NewEvent_Order_IsShipped%></span></a></em>
        </div>
    </div>
    <%if (Tips()!=""){ %><div id="tips"><%=Tips() %></div><%} %>
    <div id="service">
        <div class="layout">
          <div class="adminface" onmousehover="">
            <img src="<%=CurrentAdmin.Avatar%>" alt="[<%=Lang(CurrentAdminGroup.Name)%>]<%=CurrentAdmin.UserName%>" />
          </div>
          <div class="adminfacepop">
              <a href="javascript:AdminPWD(0);"><%=Tag("改密")%></a>
              <a href="<%=site.AdminPath %>/Logout.aspx" onclick="return quit()"><%=Tag("注销")%></a>
              <a href="<%=site.WebPath %>/" target="_blank"><%=Tag("网站前台")%></a>
          </div>
        </div>
    </div>
    <div class="clearfix">
    </div>
    <div class="navmenu">
        <ul id="shopmenu" class="menu">
            <%foreach (Shop.Model.Lebi_Menu menu in TopMenus)
                { %>
            <li class="<%=CurrentTopMenu.id==menu.id?"current":"" %>"><a href="<%=site.AdminPath %>/Ajax/ajax_admin.aspx?__Action=MenuJump&pid=<%=menu.id %>"><span><img src="<%if (menu.Image != ""){ %><%=GetImage(site.WebPath + menu.Image) %><%}else{%><%=site.AdminImagePath%>/icon/plugin.png<%} %>" /><%=Tag(menu.Name)%></span></a> </li>
            <%} %>
        </ul>
        <ul class="menu">
            <li class="menuline"></li>
            <li><a href="javascript:void(0);" onclick="updateadmin();"><span><img src="<%=site.AdminImagePath%>/icon/reh.png" /><%=Tag("系统刷新")%></span></a></li>
            <li><a href="javascript:void(0);" onclick="UpdateCache(0);"><span><img src="<%=site.AdminImagePath%>/icon/cache.png" /><%=Tag("更新缓存")%></span></a></li>
            <li><a href="javascript:void(0);" onclick="UpdateCache(1);"><span><img src="<%=site.AdminImagePath%>/icon/data.png" /><%=Tag("数据同步")%></span></a></li>
            <li><a href="<%=site.AdminPath%>/Ajax/ajax_admin.aspx?__Action=MenuJump&pid=0"><span><img src="<%=site.AdminImagePath%>/icon/dasktop.png" /><%=Tag("桌面") %></span></a></li>
            <li><a href="<%=site.WebPath %>/" target="_blank"><span><img src="<%=site.AdminImagePath%>/icon/web.png" /><%=Tag("网站前台")%></span></a></li>
            <li><a href="javascript:void(0);" onclick="Copyright();"><span><img src="<%=site.AdminImagePath%>/icon/about.png" /><%=Tag("关于") %></span></a></li>
        </ul>
        
    </div>
  </div>
</div>
<div id="body_content">
<div id="sidebar">
    <div class="menubar ">
        <%if (desk == 1)
            { 
        %>
        <h2><span><img src="<%=site.AdminImagePath %>/2015/minus.png" id="img1" /> <%=Tag("快捷菜单")%></span></h2>
        <ul class="clear">
            <%foreach (Shop.Model.Lebi_Menu menu in GetIndexMenus()){ %><li><a href="<%=MenuUrl(menu.URL,1) %>"><span><%=Tag(menu.Name)%></span></a></li><%}%>
        </ul>
        <% }else{ %>
        <%foreach (Shop.Model.Lebi_Menu pmenu in GetMenus(CurrentTopMenu.id)){ %>
        <h2><span><img mid="<%=pmenu.id %>" src="<%=site.AdminImagePath %>/2015/<%=MenuShow(pmenu.id)==true?"minus":"plus" %>.png" id="imgStatis" /> <%=Tag(pmenu.Name)%></span></h2>
        <ul class="clear" <%=MenuShow(pmenu.id)==true?"":"style=\"display:none;\"" %>>
            <%foreach (Shop.Model.Lebi_Menu menu in GetMenus(pmenu.Code)){ %><li><a href="<%=MenuUrl(menu.URL,0) %>"><span><%=Tag(menu.Name)%></span></a></li><%}%>
        </ul>
        <%} } %>
    </div>
</div>
<div id="sideplus">
    <a href="javascript:void()" onclick="switchSysBar()"><span class="navPoint" id="switchPoint" title="<%=Tag("关闭/打开左栏")%>"><img src="<%=site.AdminImagePath%>/2015/left.png" alt="<%=Tag("关闭/打开左栏")%>" /></span></a>
</div>
<div id="sidecontent" class="clear">
    <div class="mainbody_path" id="body_path">
      
    <div class="tools">
    <ul>
    <%if (PageReturnMsg == ""){%>
    <li class="submit"><a href="javascript:void(0);" onclick="SaveObj();"><b></b><span><%=Tag("保存")%></span></a></li>
    <li class="submit"><a href="javascript:void(0);" onclick="CreateSkin();"><b></b><span><%=Tag("生成页面")%></span></a></li>
    <li class="submit"><a href="javascript:void(0);" onclick="CreateTheme();"><b></b><span><%=Tag("生成主题")%></span></a></li>
    <%}%>
    <li class="rotate"><a href="javascript:void(0);" onclick="history.go(-1);"><b></b><span><%=Tag("返回")%></span></a></li>
    <li class="name"><span id="navIgation"><%=Tag("当前位置")%>：<a href="<%=site.AdminPath %>/Ajax/ajax_admin.aspx?__Action=MenuJump&pid=0"><%=Tag("管理首页")%></a> > <a href="<%=site.AdminPath %>/theme/default.aspx"><%=Tag("主题管理")%></a> > <a href="<%=site.AdminPath %>/theme/Skin.aspx?id=<%=theme.id %>"><%=theme.Name %></a> > <%=model.Name %></span></li>
    </ul>
    </div>

    </div>
    <%if (PageReturnMsg == ""){%>
        
        
    <%}%>
    <div class="mainbody" id="body_main">
        <div id="body_main_form">
          <%if (PageReturnMsg == ""){%>
            
    <table class="table">
        <%if (model.id>0){ %>
        <tr>
            <th >
                <%=Tag("代码")%>：
            </th>
            <td><%=model.Code %>
                <%if (tpage.PageParameter != "")
                  { %>
                <%=Tag("页面参数")%>：<%=tpage.PageParameter%>
                <%}if(tpage.StaticPageName!=""){ %>
                <%=Tag("静态页面名称")%>：<%=tpage.StaticPageName %>
                <%} %>
            </td>
        </tr>
        <%} %>
        <tr>
            <th>
                <%=Tag("名称")%>：
            </th>
            <td>
                <input type="text" id="Name" name="Name" class="input" shop="true" min="notnull" style="width: 200px;" value="<%=model.Name %>" />&nbsp;<span></span>
            </td>
        </tr>
        <%if (model.id>0){ %>
        <tr>
            <th>
                <%=Tag("分页大小")%>：
            </th>
            <td>
                <input type="text" id="PageSize" name="PageSize" class="input" shop="true" style="width: 50px;" value="<%=model.PageSize %>" onkeyup="value=value.replace(/[^\d]/g,'')"/>&nbsp;<span></span>
            </td>
        </tr>
        <%} %>
        <tr>
            <th>
                <%=Tag("类型")%>：
            </th>
            <td>
                <input type="radio" name="IsPage" value="1" shop="true" <%=model.IsPage==1?"checked":"" %> onclick="ChangeIsPage();" /><%=Tag("页面")%>
                <input type="radio" name="IsPage" value="0" shop="true" <%=model.IsPage==0?"checked":"" %> onclick="ChangeIsPage();" /><%=Tag("块")%>
                <input type="radio" name="IsPage" value="2" shop="true" <%=model.IsPage==2?"checked":"" %> onclick="ChangeIsPage();" /><%=Tag("布局")%>
            </td>
        </tr>
        <tr>
            <th>
                <%=Tag("皮肤文件")%>：
            </th>
            <td>
                <%=theme.Path_Files %>/<input type="text" id="Path_Skin" name="Path_Skin" class="input" shop="true" style="width: 200px;" value="<%=model.Path_Skin %>" />&nbsp;<a href="javascript:void(0);" onclick="SelectPart();" />[<%=Tag("选择")%>]</a>
            </td>
        </tr>
        <tr id="DivPageName">
            <th>
                <%=Tag("生成路径")%>：
            </th>
            <td>
                <%=theme.Path_Create%><input type="text" id="PageName" name="PageName" class="input" shop="true" style="width: 200px;" value="<%=model.PageName %>" />&nbsp;<span></span>
            </td>
        </tr>
        <tr>
            <th style="vertical-align:top">
                <%=Tag("页面内容")%>：<%if (model.Code!=""){ %><br /><label><input type="checkbox" name="IsLoadSystemPage" id="IsLoadSystemPage" value="1" onclick="LoadSystemPage();" /><em><%=Tag("加载系统页面内容")%></em></label><%} %>
            </th>
            <td>
                <textarea id="SkinContent" name="SkinContent" shop="true" class="textarea" style="height: 500px; width: 100%" rows="4" class="input"><%=Server.HtmlEncode(SkinContent)%></textarea>
                <div class="tools clear">
                    <ul>
                        <li class="plus"><a href="javascript:void(0);" onclick="javascript:resizeEditor('SkinContent',250);"><b></b><span><%=Tag("展开")%></span></a></li>
                        <li class="minus"><a href="javascript:void(0);" onclick="javascript:resizeEditor('SkinContent',-250)"><b></b><span><%=Tag("收缩")%></span></a></li>
                    </ul>
                </div>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        function SaveObj() {
            var postData = GetFormJsonData("shop");
            if (!CheckForm("shop", "span"))
                return false;
            var nodeid = $("#Node_id").val();
            var IsPage = $("input[name='IsPage']:checked").val();
            var url = "<%=site.AdminPath %>/ajax/ajax_theme.aspx?__Action=Skin_Edit&id=<%=model.id %>";
            var returnurl = "skin.aspx?id=<%=theme.id %>&ispage="+IsPage;
            if (IsPage ==0){
                returnurl = "filelist.aspx?id=<%=theme.id %>&t=block";
            }else if (IsPage ==2){
                returnurl = "filelist.aspx?id=<%=theme.id %>&t=layout";
            }
            RequestAjax(url,postData,function(res){MsgBox(1, "<%=Tag("操作成功")%>", returnurl)});
            
        }
        function CreateSkin() {
            var postData = GetFormJsonData("shop");
            var nodeid = $("#Node_id").val();
            var url = "<%=site.AdminPath %>/ajax/ajax_theme.aspx?__Action=Skin_Edit&id=<%=model.id %>";
            RequestAjax(url,postData,function(res){
                url="<%=site.AdminPath %>/ajax/ajax_aspx.aspx?__Action=CreateSkin&id=<%=model.id %>";
                RequestAjax(url,postData,function(res){MsgBox(1, "<%=Tag("操作成功")%>", "")});
            });
        }
        function CreateTheme() {
            var Theme_id = $("#Theme_id").val();
            var postData = { "Theme_id": Theme_id };
            var url="<%=site.AdminPath %>/ajax/ajax_aspx.aspx?__Action=CreateTheme";
            RequestAjax(url,postData,function(res){MsgBox(1, "<%=Tag("操作成功")%>", "")});
        }
        function ChangeIsPage() {
            var ispage = $("input[name='IsPage']:checked").val();
            if (ispage == 1||ispage == 2) {
                if (ispage == 1){
                    $("#DivPageName").show();
                    $("#Path_Skin").val("<%=model.Path_Skin %>");
                }else if(ispage == 2){
                    $("#DivPageName").hide();
                    $("#Path_Skin").val("layout/<%=model.Path_Skin %>");
                }
            } else {
                $("#DivPageName").hide();
                $("#Path_Skin").val("inc/<%=model.Path_Skin %>");
            }
        }
        function LoadSystemPage(){
            var IsLoadSystemPage = $("input[name='IsLoadSystemPage']:checked").val();
            if (IsLoadSystemPage==1){
                var url="<%=site.AdminPath %>/ajax/ajax_theme.aspx?__Action=GetSkinContent&filename=page/<%=model.PageName %>";
                LoadHtml(url,"",function(res){$("#SkinContent").val(res);});
            }else{
                $("#SkinContent").val("");
            }
        }
        function LoadHtml(url, jsondata, callback) {
            $.ajax({
                type: "POST",
                url: url,
                data: jsondata,
                dataType: 'html',
                success: function (res) {
                    callback(res);
                    return false;
                }
            });
        }
        function SelectPart() {
            var ispage = $("input[name='IsPage']:checked").val();
            var title_ = "<%=Tag("系统模板")%>";
            var url_ = "part_window.aspx?ispage=" + ispage;
            var width_ = 800;
            var height_ = 500;
            var modal_ = true;
            EditWindow(title_, url_, width_, height_, modal_,'partdiv');
        }
        ChangeIsPage();
        <%if (model.id>0 && model.IsPage==1){ %>$("#DivPageName").show();<%} %>
    </script>

          <%}else{%>
            <%=PageReturnMsg%>
          <%}%>
        </div>
    </div>
    
    <input type="hidden" id="Theme_id" name="Theme_id" shop="true" value="<%=theme.id %>" />
    <div class="bottom" id="body_bottom">
    </div>

    <div id="body_foot">
        <div class="foot">
            <div class="copy" id="lebicopy">
                <asp:Label ID="LBLicense" runat="server"></asp:Label>
            </div>
            <div class="lang">
                <ul class="droplang">
                    <li class="lang_li"><a class="noclick">
                        <%int langi = 0;
                          if (CurrentAdminLanguage.Name == "")
                            {%><%=Tag("语言选择")%><%}else{%><%=CurrentAdminLanguage.Name%><%} %></a>
                        <dl class="lang_li_content">
                            <%foreach (Shop.Model.Lebi_Language_Code langc in langs)
                              {
                                  langi++; if (langi== langs.Count)
                                  {%>
                            <dd class="last"><%}
                                  else
                                  {%><dd><%} %>
                            <a href="javascript:SetLanguage('<%=langc.Code %>','<%=langc.Name %>');"><%=langc.Name %></a></dd>
                                  <%} %>
                        </dl>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
</div>
<div id="sound"></div>
<script src="<%=site.AdminJsPath %>/lightbox/lightbox.min.js"></script>
<script>
    function Copyright() {
        var title_ = "<%=Tag("关于")%>";
        var url_ = "<%=site.AdminPath %>/Config/Copyright_window.aspx";
        var width_ = 500;
        var height_ = 'auto';
        var modal_ = true;
        EditWindow(title_, url_, width_, height_, modal_);
    }
    function UpdateCache(type) {
        var postData = ""; 
        if (type == 0){
            postData = {'datatype':'languagetag,producttype,config,themepage'};
        }else{
            postData = {'datatype':'dbbody,lebitype,lebimenu,lebipage'};
        }
        var url = "<%=site.AdminPath %>/ajax/ajax_db.aspx?__Action=CacheReset";
        RequestAjax(url,postData,function(){MsgBox(1, "<%=Tag("操作成功")%>", "")});
    }
    function updateadmin(){
        var url="<%=site.AdminPath %>/ajax/ajax_site.aspx?__Action=UpdateAdmin";
        RequestAjax(url,"",function(res){RequestAjax("<%=site.AdminPath %>/ajax/ajax_db.aspx?__Action=CacheReset","{'datatype':'dbbody'}",function(){MsgBox(1, "<%=Tag("操作成功")%>", "")});});
    }
    function NewEvent(){
        GetNewEvent();
        setTimeout(function(){NewEvent();},<%=SYS.NewEventTimes%>);
    }
    function PlayAudio(){
        <%if (config.NewEventPlayAudio=="1"){%>
        $('#sound').html('<audio autoplay="autoplay"><source src="<%=site.AdminImagePath %>/msg.mp3" type="audio/mpeg"><source src="<%=site.AdminImagePath %>/msg.wav" type="audio/wav"></audio>');
        <%}%>
    }
    setTimeout(function(){NewEvent();},<%=LeftNewEventTimes%>);
</script>
</body>
</html>