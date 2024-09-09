<!DOCTYPE html>
<html lang="zh">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<title>${siteName!""}|核酸检测记录-${title!""}</title>
<#include "../common/header.ftl"/>
<style>
td{
	vertical-align:middle;
}
 img
 {
   max-height: 400px;
   max-width: 95%;
 }

</style>
</head>
  
<body>
<div class="lyear-layout-web">
  <div class="lyear-layout-container">
    <!--左侧导航-->
    <aside class="lyear-layout-sidebar">
      
      <!-- logo -->
      <div id="logo" class="sidebar-header">
        <a href="/system/index"><img src="/admin/images/logo-sidebar.png" title="${siteName!""}" alt="${siteName!""}" /></a>
      </div>
      <div class="lyear-layout-sidebar-scroll"> 
        <#include "../common/left-menu.ftl"/>
      </div>
      
    </aside>
    <!--End 左侧导航-->
    
    <#include "../common/header-menu.ftl"/>
    
    <!--页面主要内容-->
    <main class="lyear-layout-content">
      
      <div class="container-fluid">
        
        <div class="row">
          <div class="col-lg-12">
            <div class="card">
              <div class="card-toolbar clearfix">
                <form class="pull-right search-bar" method="get" action="list" role="form">
                  <div class="input-group" style="margin-left: -100px">
                    <div class="input-group-btn">
                      <button class="btn btn-default dropdown-toggle" id="search-btn" data-toggle="dropdown" type="button" aria-haspopup="true" aria-expanded="false">
                          身份证号 <span class="caret"></span>
                      </button>
                      <ul class="dropdown-menu">
                        <li> <a tabindex="-1" href="javascript:void(0)" data-field="title">身份证号</a> </li>
                      </ul>
                    </div>
                    <input type="text"  class="form-control" value="${cardNumber!""}" name="cardNumber" placeholder="请输入身份证号">
                  	<span class="input-group-btn">
                      <button class="btn btn-primary" type="submit">搜索</button>
                    </span>
                  </div>
                </form>
                <#include "../common/third-menu.ftl"/>
              </div>
              <div class="card-body">
                
                <div class="table-responsive">
                  <table class="table table-bordered">
                    <thead>
                      <tr>
                        <th>

                        </th>
                        <th>姓名</th>
                        <th>性别</th>
                        <th>身份证号码</th>
                        <th>采集时间</th>
                        <th>采集地点</th>
                        <th>状态</th>
                        <th style="width:30%">操作</th>
                      </tr>
                    </thead>
                    <tbody>
                      <#if pageBean.content?size gt 0>
                      <#list pageBean.content as item>
                      <tr>
                        <td style="vertical-align:middle;">
                          <label class="lyear-checkbox checkbox-primary">
                            <input type="checkbox" name="ids[]" value="${item.id}"><span></span>
                          </label>
                        </td>
                        <td style="vertical-align:middle;">${item.name}</td>
                        <td style="vertical-align:middle;">
                          <#list sexList as sex>
                            <#if item.sex == sex.code>
                              ${sex.value}
                            </#if>
                          </#list>
                        </td>
                        <td style="vertical-align:middle;">${item.cardNumber}</td>
                        <td style="vertical-align:middle;">${item.gatherTime?string("yyyy-MM-dd HH:mm")}</td>
                        <td style="vertical-align:middle;">${item.gatherAddress}</td>
                        <td style="vertical-align:middle;">
                          <#if item.status.code == 0>
                            <font color="red">
                          <#elseif item.status.code == 1>
                            <font color="green">
                          <#else>
                            <font color="#ff69b4">
                          </#if>
                            ${item.status.value}</font>
                        </td>
                        <td style="vertical-align:middle;">
                            <button class="btn btn-primary btn-w-md" type="button"
                                    onclick="show(${item.id})">查看详情
                            </button>
                            <#if item.status.code == 2>
                              <button class="btn btn-primary btn-w-md" type="button"
                                      onclick="approval(${item.id}, true)">通过
                              </button>
                              <button class="btn btn-danger btn-w-md" type="button"
                                      onclick="approval(${item.id}, false)">不通过
                              </button>
                            <#else>
                              <button class="btn btn-primary btn-w-md" disabled type="button">通过
                              </button>
                              <button class="btn btn-danger btn-w-md" disabled type="button">不通过
                              </button>
                            </#if>
                        </td>
                      </tr>
                    </#list>
                    <#else>
                    <tr align="center"><td colspan="10">这里空空如也！</td></tr>
					</#if>
                    </tbody>
                  </table>
                </div>
                <#if pageBean.total gt 0>
                <ul class="pagination ">
                  <#if pageBean.currentPage == 1>
                  <li class="disabled"><span>«</span></li>
                  <#else>
                  <li><a href="list?cardNumber=${cardNumber!""}&currentPage=1">«</a></li>
                  </#if>
                  <#list pageBean.currentShowPage as showPage>
                  <#if pageBean.currentPage == showPage>
                  <li class="active"><span>${showPage}</span></li>
                  <#else>
                  <li><a href="list?cardNumber=${cardNumber!""}&currentPage=${showPage}">${showPage}</a></li>
                  </#if>
                  </#list>
                  <#if pageBean.currentPage == pageBean.totalPage>
                  <li class="disabled"><span>»</span></li>
                  <#else>
                  <li><a href="list?cardNumber=${cardNumber!""}&currentPage=${pageBean.totalPage}">»</a></li>
                  </#if>
                  <li><span>共${pageBean.totalPage}页,${pageBean.total}条数据</span></li>
                </ul>
                </#if>
              </div>
            </div>
          </div>
          
        </div>
        
      </div>
      
    </main>
    <!--End 页面主要内容-->
  </div>
</div>

<div class="modal fade" id="viewCompetition" tabindex="-1" role="dialog" aria-labelledby="viewCompetition">
  <div class="modal-dialog" role="document">
    <div class="modal-content" >
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
        </button>
        <h4 class="modal-title" id="viewCompetition">核酸检测信息</h4>
      </div>
      <div class="modal-body">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      </div>
    </div>
  </div>
</div>

<#include "../common/footer.ftl"/>
<script type="text/javascript" src="/admin/js/perfect-scrollbar.min.js"></script>
<script type="text/javascript" src="/admin/js/main.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	
});

function show(id) {
  $.get("show", {id: id}, function (result) {
    $(".modal-body").empty();
    $('#viewCompetition').modal('show');
    $(".modal-body").html(result);

  });
}

function del(url){
  if($("input[type='checkbox']:checked").length != 1){
    showWarningMsg('请选择一条数据进行删除！');
    return;
  }
  var id = $("input[type='checkbox']:checked").val();
  $.confirm({
    title: '确定删除？',
    content: '删除后数据不可恢复，请慎重！',
    buttons: {
      confirm: {
        text: '确认',
        action: function(){
          deleteReq(id,url);
        }
      },
      cancel: {
        text: '关闭',
        action: function(){

        }
      }
    }
  });
}

//调用删除方法
function deleteReq(id,url){
  $.ajax({
    url:url,
    type:'POST',
    data:{id:id},
    dataType:'json',
    success:function(data){
      if(data.code == 0){
        showSuccessMsg('删除成功!',function(){
          window.location.reload();
        })
      }else{
        showErrorMsg(data.msg);
      }
    },
    error:function(data){
      alert('网络错误!');
    }
  });
}

var notPassReason = "";

function approval(id,flag){
  if(flag){
    approvalAgree(id,flag);
  }else{
    $.confirm({
      title:"审核",
      content: '' +
              '<form action="" class="formName">' +
              '<div class="form-group">' +
              '<label>请填写具体理由</label>' +
              '<textarea type="text"  placeholder="请填写具体理由" class="form-control notPassReason" style="height:120px;"></textarea>' +
              '</div>' +
              '</form>',
      buttons: {
        confirm: {
          text: '确认',
          action: function(){
            notPassReason = this.$content.find('.notPassReason').val();
            approvalAgree(id,flag);
          }
        },
        cancel: {
          text: '关闭',
          action: function(){

          }
        }
      }
    });
  }
}

function approvalAgree(id,flag){
  $.ajax({
    url:'approval',
    type:'post',
    data:{
      id:id,
      flag:flag,
      notPassReason:notPassReason
    },
    dataType:'json',
    success:function (data) {
      if(data.code == 0){
        showSuccessMsg("审批成功",function () {
          window.location.href = 'list';
        })
      }else{
        showErrorMsg(data.msg)
      }
    },
    error:function (data) {
      alert("网络错误")
    }
  })
}


function poiExport(url)
{
    location.href = url;
}
</script>
</body>
</html>