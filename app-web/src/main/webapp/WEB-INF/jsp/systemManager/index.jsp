<%@ page language="java"  pageEncoding="UTF-8"%>
<div class="manager-index">
	<div class="manager-index-btns">
		<a  href="javascript:_systemManager_Js.addCategory();" class="easyui-linkbutton" style="width: 100px;">添加</a>
		<a  href="javascript:_systemManager_Js.saveCategory();" class="easyui-linkbutton" style="width: 100px;">保存</a>
		<a  href="javascript:_systemManager_Js.refresh();" target="" class="easyui-linkbutton" style="width: 100px;">刷新缓存</a>
		<a  href="javascript:_systemManager_Js.siteMap();" target="" class="easyui-linkbutton" style="width: 100px;">生成siteMap</a>
	</div>
	<div class="manager-index-table">
		<table id="categoryTree"></table>  
	</div>
</div>
<script type="text/javascript">

_systemManager_Js = {
		siteMap:function () {
            _base_Js.baseAjax ("重新生成siteMap","/admin/systemManager/sitemap.action",null,null , null);
		},
	    refresh:function () {
			_base_Js.baseAjax ("是否刷新缓存","/admin/systemManager/refreshFreemakerCache.action",null,null , null);
		},
		defaultCategory:
			{"id":null,"rank":null,"link":null,"name":null,"parentid":null,"ico":null,"record":null,"title":null}
		,
		addCategory : function(){

		        var url = "/admin/systemManager/add.action";
		        var row = $("#categoryTree").treegrid("getSelected") ;
		        var data  ={ parentid : row == null ? null : row.id};
               var _title = data.parentid == null ?"是否确定增加一个菜单" : "是否在<" +row.name +">增加一个子菜单";
		        var successFn = function(){
		        	$("#categoryTree").treegrid("reload");
		        }
	        _base_Js.baseAjax (_title,url,data,successFn , null);
		},
		deleteCategory:function(id){
				var _title ="是否确定删除一个菜单";
		        var url = "/admin/systemManager/delete.action";
		        var data  ={ 'id' :id};
		        var successFn = function(){
		        	$("#categoryTree").treegrid("reload");
		        }
	        _base_Js.baseAjax (_title,url,data,successFn , null);
		},
		saveCategory:function(){
			if( _systemManager_Js.lastEditIndex!=null){
				$("#categoryTree").treegrid('endEdit', _systemManager_Js.lastEditIndex);  
			}  
		},
		lastEditIndex : null,
		categoryTreeLoad : function(){
			var _columns =[[
						{field:'id',title:'ID',width:80},
						{field:'name',title:'类别名称',width:200, editor:'text'},
						{field:'link',title:'类别链接',width:200, editor:'text',formatter: function(value,row,index){
								return row.link;
						}},
						{field:'rank',title:'类别等级',width:80, editor:'text'},
					   /*  {field:'parentid',title:'父类别',width:100, editor:'text'},   */
						{field:'createtime',title:'创建时间',width:150},
						{field:'ico',title:'类别小图标',width:100, editor:'text'},
						{field:'record',title:'备注',width:200, editor:'text'},
						{field:'title',title:'提示',width:150, editor:'text'},
						{field:'version',title:'修改次数',width:150},
						{field:'operation',title:'操作',width:150,formatter: function(value,row,index){
								return "<a href='javascript:_systemManager_Js.deleteCategory(" + row.id+ ");' >删除</a>";
							}
						}
			    	]] ;
			    	
				$("#categoryTree").treegrid({  
					url:"/admin/systemManager/list.action",  
				    idField:'id',    
				    treeField:'name',    
				    columns:_columns ,
				    singleSelect : true,
					striped : true,
					emptyMsg : '无数据',
					loadMsg : true,
				    loadFilter:function(data){
				    	console.log(data);
				    	$.each(data.rows,function(i){
							var row = data.rows[i];
							row._parentId = row.parentid == null ? null : row.parentid;
						});
						return data;
				    },
				    //双击单元格
				    onDblClickCell:function(field,row){
				    	var rowIndex = row.id;  
					     if ( _systemManager_Js.lastEditIndex != rowIndex){
					     	if( _systemManager_Js.lastEditIndex!=null){
					     		$("#categoryTree").treegrid('endEdit', _systemManager_Js.lastEditIndex);  
					     	}  
					     	if(rowIndex!=null){
					     		$("#categoryTree").treegrid('beginEdit', rowIndex);  
					     		 _systemManager_Js.lastEditIndex = rowIndex;
					     	}
					     	   
					     }  
				    },onBeforeEdit:function(row){  
				    	
					}  
				  ,onAfterEdit:function(row,changes){
				        var _title ="是否确定修改内容";
				        var url = "/admin/systemManager/update.action";
				        var newJson = {"id":row.id,"rank":row.rank,"link":row.link,"name":row.name,"parentid":row.parentid,"ico":row.ico,"record":row.record,"title":row.title};
				       	console.log(newJson);
				        var data  = newJson;
				        var successFn = function(){
				        	$("#categoryTree").treegrid("reload");
                            $("#categoryTree").treegrid("clearSelections");
                            _systemManager_Js.lastEditIndex = null;
				        }
				        _base_Js.baseAjax (_title,url,data,successFn , null);
				        
				  	}  
				}); 
		}
	};
	$(
		function(){
			_systemManager_Js.categoryTreeLoad();
		}
	);
	
	
	
</script>