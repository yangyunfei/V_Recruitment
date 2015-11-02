<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<title>用户管理</title>
<jsp:include page="../inc.jsp"></jsp:include>
<c:if test="${fn:contains(sessionInfo.resourceList, '/userController/editPage')}">
	<script type="text/javascript">
		$.canEdit = true;
	</script>
</c:if>
<c:if test="${fn:contains(sessionInfo.resourceList, '/userController/delete')}">
	<script type="text/javascript">
		$.canDelete = true;
	</script>
</c:if>
<c:if test="${fn:contains(sessionInfo.resourceList, '/userController/grantPage')}">
	<script type="text/javascript">
		$.canGrant = true;
	</script>
</c:if>
<c:if test="${fn:contains(sessionInfo.resourceList, '/userController/editPwdPage')}">
	<script type="text/javascript">
		$.canEditPwd = true;
	</script>
</c:if>
<script type="text/javascript">
	var dataGrid;
	$(function() {
		dataGrid = $('#dataGrid').datagrid({
			url : '${pageContext.request.contextPath}/jf/cusController/dataGrid',

			fit : true,
			fitColumns : false,
			border : false,
			pagination : true,
			idField : 'id',
			pageSize : 10,
			pageList : [ 10, 20, 30, 40, 50 ],
			sortName : 'name',
			sortOrder : 'asc',
			checkOnSelect : false,
			selectOnCheck : false,
			nowrap : false,
            onLoadSuccess: function(){
                $(this).datagrid('freezeRow',0).datagrid('freezeRow',1);
            },
			frozenColumns : [ [ {
				field : 'id',
				title : '编号',
				width : 150,
				checkbox : true
			} , {
				field : 'cus_id',
				title : '客户编号',
				width : 110,
				sortable : true
			}, {
				field : 'name',
				title : '客户名称',
				width : 80,
				sortable : true
			} ] ],
			columns : [ [ {
				field : 'createtime',
				title : '创建时间',
				width : 150,
				sortable : true
			},  {
				field : 'modifytime',
				title : '进展更新日期',
				width : 150,
				sortable : true
			}, {
				field : 'cus_name',
				title : '客户服务名称',
				width : 120,
				sortable : true
			}, {
				field : 'source',
				title : '客户来源',
				//colspan: 4,
				width : 150
			}, {
				field : 'industry',
				title : '客户行业',
				//colspan: 4,
				width : 150
			}, {
				field : 'phone',
				title : '客户联系方式',
				//colspan: 4,
				width : 150
			}, {
				field : 'roleNames',
				title : '客户信息状态',
				//colspan: 4,
				width : 150
			}, {
				field : 'roleNames',
				title : '客户信息状态',
				//colspan: 4,
				width : 150
			}, {
				field : 'roleNames',
				title : '客户信息状态',
				//colspan: 4,
				width : 150
			}, {
				field : 'roleNames',
				title : '客户信息状态',
				//colspan: 4,
				width : 150
			}, {
				field : 'roleNames',
				title : '客户信息状态',
				//colspan: 4,
				width : 150
			}, {
				field : 'roleNames',
				title : '客户信息状态',
				//colspan: 4,
				width : 150
			}, {
				field : 'agent_name',
				title : '负责人',
				//colspan: 4,
				width : 150
			}, {
				field : 'step1',
				title : '推荐',
				//colspan: 4,
				width : 150
			}, {
				field : 'step2',
				title : '跟进',
				//colspan: 4,
				width : 150
			}, {
				field : 'step3',
				title : '带看',
				//colspan: 4,
				width : 150
			}, {
				field : 'step4',
				title : '再谈',
				//colspan: 4,
				width : 150
			}, {
				field : 'step5',
				title : '客户信息状态',
				//colspan: 4,
				width : 150
			}

			
			, {
				field : 'action',
				title : '操作',
				width : 100,
				formatter : function(value, row, index) {
					var str = '';
					if ($.canEdit) {
						str += $.formatString('<img onclick="editFun(\'{0}\');" src="{1}" title="编辑"/>', row.id, '${pageContext.request.contextPath}/style/images/extjs_icons/pencil.png');
					}
					str += '&nbsp;';
					if ($.canGrant) {
						str += $.formatString('<img onclick="grantFun(\'{0}\');" src="{1}" title="授权"/>', row.id, '${pageContext.request.contextPath}/style/images/extjs_icons/key.png');
					}
					str += '&nbsp;';
					if ($.canDelete) {
						str += $.formatString('<img onclick="deleteFun(\'{0}\');" src="{1}" title="删除"/>', row.id, '${pageContext.request.contextPath}/style/images/extjs_icons/cancel.png');
					}
					str += '&nbsp;';
					if ($.canEditPwd) {
						str += $.formatString('<img onclick="editPwdFun(\'{0}\');" src="{1}" title="修改密码"/>', row.id, '${pageContext.request.contextPath}/style/images/extjs_icons/lock/lock_edit.png');
					}
					return str;
				}
			} ] ],
			toolbar : '#toolbar',
			onLoadSuccess : function() {
				$('#searchForm table').show();
				parent.$.messager.progress('close');

				$(this).datagrid('tooltip');
			},
			onRowContextMenu : function(e, rowIndex, rowData) {
				e.preventDefault();
				$(this).datagrid('unselectAll').datagrid('uncheckAll');
				$(this).datagrid('selectRow', rowIndex);
				$('#menu').menu('show', {
					left : e.pageX,
					top : e.pageY
				});
			}
		});
	});

	function editPwdFun(id) {
		dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		parent.$.modalDialog({
			title : '编辑用户密码',
			width : 500,
			height : 300,
			href : '${pageContext.request.contextPath}/userController/editPwdPage?id=' + id,
			buttons : [ {
				text : '编辑',
				handler : function() {
					parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
					var f = parent.$.modalDialog.handler.find('#form');
					f.submit();
				}
			} ]
		});
	}

	function deleteFun(id) {
		if (id == undefined) {//点击右键菜单才会触发这个
			var rows = dataGrid.datagrid('getSelections');
			id = rows[0].id;
		} else {//点击操作里面的删除图标会触发这个
			dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		}
		parent.$.messager.confirm('询问', '您是否要删除当前用户？', function(b) {
			if (b) {
				var currentUserId = '${sessionInfo.id}';/*当前登录用户的ID*/
				if (currentUserId != id) {
					parent.$.messager.progress({
						title : '提示',
						text : '数据处理中，请稍后....'
					});
					$.post('${pageContext.request.contextPath}/userController/delete', {
						id : id
					}, function(result) {
						if (result.success) {
							parent.$.messager.alert('提示', result.msg, 'info');
							dataGrid.datagrid('reload');
						}
						parent.$.messager.progress('close');
					}, 'JSON');
				} else {
					parent.$.messager.show({
						title : '提示',
						msg : '不可以删除自己！'
					});
				}
			}
		});
	}

	function batchDeleteFun() {
		var rows = dataGrid.datagrid('getChecked');
		var ids = [];
		if (rows.length > 0) {
			parent.$.messager.confirm('确认', '您是否要删除当前选中的项目？', function(r) {
				if (r) {
					parent.$.messager.progress({
						title : '提示',
						text : '数据处理中，请稍后....'
					});
					var currentUserId = '${sessionInfo.id}';/*当前登录用户的ID*/
					var flag = false;
					for ( var i = 0; i < rows.length; i++) {
						if (currentUserId != rows[i].id) {
							ids.push(rows[i].id);
						} else {
							flag = true;
						}
					}
					$.getJSON('${pageContext.request.contextPath}/userController/batchDelete', {
						ids : ids.join(',')
					}, function(result) {
						if (result.success) {
							dataGrid.datagrid('load');
							dataGrid.datagrid('uncheckAll').datagrid('unselectAll').datagrid('clearSelections');
						}
						if (flag) {
							parent.$.messager.show({
								title : '提示',
								msg : '不可以删除自己！'
							});
						} else {
							parent.$.messager.alert('提示', result.msg, 'info');
						}
						parent.$.messager.progress('close');
					});
				}
			});
		} else {
			parent.$.messager.show({
				title : '提示',
				msg : '请勾选要删除的记录！'
			});
		}
	}

	function editFun(id) {
		if (id == undefined) {
			var rows = dataGrid.datagrid('getSelections');
			id = rows[0].id;
		} else {
			dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		}
		parent.$.modalDialog({
			title : '编辑用户',
			width : 500,
			height : 300,
			href : '${pageContext.request.contextPath}/userController/editPage?id=' + id,
			buttons : [ {
				text : '编辑',
				handler : function() {
					parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
					var f = parent.$.modalDialog.handler.find('#form');
					f.submit();
				}
			} ]
		});
	}

	function addFun() {
		parent.$.modalDialog({
			title : '添加用户',
			width : 500,
			height : 300,
			href : '${pageContext.request.contextPath}/userController/addPage',
			buttons : [ {
				text : '添加',
				handler : function() {
					parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
					var f = parent.$.modalDialog.handler.find('#form');
					f.submit();
				}
			} ]
		});
	}

	function batchGrantFun() {
		var rows = dataGrid.datagrid('getChecked');
		var ids = [];
		if (rows.length > 0) {
			for ( var i = 0; i < rows.length; i++) {
				ids.push(rows[i].id);
			}
			parent.$.modalDialog({
				title : '用户授权',
				width : 500,
				height : 300,
				href : '${pageContext.request.contextPath}/userController/grantPage?ids=' + ids.join(','),
				buttons : [ {
					text : '授权',
					handler : function() {
						parent.$.modalDialog.openner_dataGrid = dataGrid;//因为授权成功之后，需要刷新这个dataGrid，所以先预定义好
						var f = parent.$.modalDialog.handler.find('#form');
						f.submit();
					}
				} ]
			});
		} else {
			parent.$.messager.show({
				title : '提示',
				msg : '请勾选要授权的记录！'
			});
		}
	}

	function grantFun(id) {
		dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
		parent.$.modalDialog({
			title : '用户授权',
			width : 500,
			height : 300,
			href : '${pageContext.request.contextPath}/userController/grantPage?ids=' + id,
			buttons : [ {
				text : '授权',
				handler : function() {
					parent.$.modalDialog.openner_dataGrid = dataGrid;//因为授权成功之后，需要刷新这个dataGrid，所以先预定义好
					var f = parent.$.modalDialog.handler.find('#form');
					f.submit();
				}
			} ]
		});
	}

	function searchFun() {
		dataGrid.datagrid('load', $.serializeObject($('#searchForm')));
	}
	function cleanFun() {
		$('#searchForm input').val('');
		dataGrid.datagrid('load', {});
	}
</script>
</head>
<body>
	<div class="easyui-layout" data-options="fit : true,border : false">
		<div data-options="region:'north',title:'查询条件',border:false" style="height: 200px; ">
			<form id="searchForm">
				<table class="table table-hover table-condensed" style="display: none;">
					<tr>
						<th>客户姓名</th>
						<td><input name="sec.name.s.like" placeholder="请输入客户姓名" class="span2" /></td>
						<th>客户编号</th>
						<td><input name="sec.cus_id.s.eq" placeholder="请输入客户编号" class="span2" /></td>
						<th>客户电话</th>
						<td><input name="sec.phone.s.eq" placeholder="请输入客电话号码" class="span2" /></td>
					</tr>
					
					<tr>
					<th>客户标签</th>
					<td><select class="form-control input-sm" style="width:130px" name="sec.label.s.eq">
					<option value="">不限</option>
					<option value="1">品牌客户</option>
					<option value="2">长期客户</option>
					<option value="3">急需客户</option>
					</select></td>
					
					<th>客户状态</th>
					<td><select class="form-control input-sm" style="width:130px" name="sec.state.s.eq">
					<option value="">不限</option>
					<option value="1">正常客户</option>
					<option value="2">失效客户</option>
					</select></td>
					
					<th>客户来源</th>
					<td><select class="form-control input-sm" style="width:130px" name="sec.source.s.eq">
					<option value="">不限</option>
					<option value="1">当前推广</option>
					<option value="2">库存 </option>
					<option value="3">经纪人推荐  </option>
					</select></td>
					<td></td>
					</tr>
					
					<tr>
					  <th>面积范围</th>
						<td><input class="span2" name="sec.area_min.i.ge" />
						至<input class="span2" name="sec.area_max.i.le" />	（平米）
						</td> 
					  <th>租金范围</th>
						<td><input class="span2" name="sec.rent_min.i.ge" />
						至<input class="span2" name="sec.rent_max.i.le" />	（元） 
						</td> 
					</tr>
					
					
					<tr>
					 
		<th> 目标行政区：</th> 
		 <td>  
		 <input class="easyui-combobox"  name="" id="xzq"  data-options="
                    method:'get',
                    valueField:'id',
                    textField:'name',
                    multiple:false,
                    
            ">  
            </td>
            
                <th>目标商圈：</th><td><input class="easyui-combobox" name="sec.target_area.s.eq"
            id="sq"
            data-options="
            valueField:'id',
            textField:'name',
            ">  
					  </td>
					  <th>客户行业：</th>
					  <td> <input class="easyui-combotree" id="cushy" name="sec.industry.s.eq"
					              data-options="
					                            method:'get'" ></td>
					  
					</tr>
					
					
					<!-- <tr>
						<th>创建时间</th>
						<td><input class="span2" name="createdatetimeStart" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly" />至<input class="span2" name="createdatetimeEnd" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly" /></td>
					</tr>
					<tr>
						<th>最后修改时间</th>
						<td><input class="span2" name="modifydatetimeStart" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly" />至<input class="span2" name="modifydatetimeEnd" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly" /></td>
					</tr> -->
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false">
			<table id="dataGrid"></table>
		</div>
	    </div>
	<div id="toolbar" style="display: none;">
		<c:if test="${fn:contains(sessionInfo.resourceList, '/userController/addPage')}">
			<a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'pencil_add'">添加</a>
		</c:if>
		<c:if test="${fn:contains(sessionInfo.resourceList, '/userController/grantPage')}">
			<a onclick="batchGrantFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'tux'">批量授权</a>
		</c:if>
		<c:if test="${fn:contains(sessionInfo.resourceList, '/userController/batchDelete')}">
			<a onclick="batchDeleteFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'delete'">批量删除</a>
		</c:if>
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'brick_add',plain:true" onclick="searchFun();">过滤条件</a><a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'brick_delete',plain:true" onclick="cleanFun();">清空条件</a>
	</div>

	<div id="menu" class="easyui-menu" style="width: 120px; display: none;">
		<c:if test="${fn:contains(sessionInfo.resourceList, '/userController/addPage')}">
			<div onclick="addFun();" data-options="iconCls:'pencil_add'">增加</div>
		</c:if>
		<c:if test="${fn:contains(sessionInfo.resourceList, '/userController/delete')}">
			<div onclick="deleteFun();" data-options="iconCls:'pencil_delete'">删除</div>
		</c:if>
		<c:if test="${fn:contains(sessionInfo.resourceList, '/userController/editPage')}">
			<div onclick="editFun();" data-options="iconCls:'pencil'">编辑</div>
		</c:if>
	</div>
</body>
<script type="text/javascript">
$(function () {
    var xzq = $('#xzq').combobox({
        url: '${pageContext.request.contextPath}/jf/areaBusinessController/selectAllBigDistrict',
        editable: false,
        valueField: 'id',
        textField: 'name',
        onSelect: function (record) {
        	
        	if(record!=null)
            sq.combobox({
                disabled: false,
                method:'get',
                url:'${pageContext.request.contextPath}/jf/areaBusinessController/selectBusinessArea?id=' + record.id,
                valueField: 'id',
                textField: 'name'
            });
        }
    });
    var sq = $('#sq').combobox({
        disabled: true,
        valueField: 'id',
        textField: 'name'
    });
    });
    </script>
    
    <script type="text/javascript">
    $(function () {
    	//$('#cushy').combotree('loadData', [{ id: 1, text: 'Languages', children: [{ id: 11, text: 'Java' },{ id: 12, text: 'C++' }] }]); 
          // $('#cushy').combo('setValue', 'text');
    	   $('#cushy').combotree
           ({
               url: '${pageContext.request.contextPath}/jf/industryController/findIndustry',
               textField: 'text',
               valueField: '餐馆',
               
               editable: false,
               onlyLeafCheck: true,
               cascaseCheck:true,
               method:'get',
				onLoadSuccess: function (node, data) {
					$('#cushy').val(data.text);
				alert("2222222");
				alert(data.children.text);
				}
           });

    });
    </script>
</html>