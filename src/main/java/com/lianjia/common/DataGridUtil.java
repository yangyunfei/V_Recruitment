package com.lianjia.common;

/**
 * 页面数据列表工具类
 * 传入参数为：Controller和对应表名
 */

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.UUID;

import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;
import jxl.write.biff.RowsExceededException;
import com.lianjia.model.TableCode;
import com.lianjia.pageModel.PageHelper;
import com.lianjia.tools.ToolDate;

import com.jfinal.core.Controller;
import com.jfinal.kit.PathKit;
import com.jfinal.kit.StrKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.ehcache.CacheKit;

public class DataGridUtil {
	public static Page<Record> dataGrid(Controller controller, String tableName) {
		PageHelper page = PageHelper.CreateFromController(controller);
		return dataGrid(controller, tableName, page);

	}

	private static Page<Record> dataGrid(Controller controller,
			String tableName, PageHelper page) {
		String sqlWhere = " 1=1 ";
		Map<String, String[]> map = controller.getParaMap();
		for (Entry<String, String[]> entry : map.entrySet()) {
			String key = entry.getKey();
			if (StrKit.isBlank(entry.getValue()[0]))
				continue;
			if (key.startsWith("sec")) {
				String[] fields = key.split("\\.");
				String field = fields[1];
				String fieldType = fields[2];
				String SecType = fields[3];
				// 如果为整数
				if (fieldType.equalsIgnoreCase("i")) {
					if (SecType.equalsIgnoreCase("eq")) {
						sqlWhere += String.format(" and  %s = %d ", field,
								Integer.valueOf(entry.getValue()[0]));
					}
					if (SecType.equalsIgnoreCase("in")) {
						sqlWhere += String.format(" and  %s in ( %s )  ",
								field, Integer.valueOf(entry.getValue()[0]));
					}
					// 大于
					if (SecType.equalsIgnoreCase("ge")) {
						sqlWhere += String.format(" and %s >= '%s'", field,
								Integer.valueOf(entry.getValue()[0]));
					}
					// 小于
					else if (SecType.equalsIgnoreCase("le")) {
						sqlWhere += String.format(" and  %s <= '%s'", field,
								Integer.valueOf(entry.getValue()[0]));
					}
					if (SecType.equalsIgnoreCase("noteq")) {
						sqlWhere += String.format(" and  %s <> '%s'", field,
								Integer.valueOf(entry.getValue()[0]));
					}
				}
				// 如果为字符串
				else if (fieldType.equalsIgnoreCase("s")) {
					if (SecType.equalsIgnoreCase("like")) {
						sqlWhere += String.format(" and  %s like '%%%s%%'",
								field, entry.getValue()[0]);
					} else if (SecType.equalsIgnoreCase("eq")) {
						sqlWhere += String.format(" and  %s = '%s'", field,
								entry.getValue()[0]);
					}
				}
				// 如果为日期
				else if (fieldType.equalsIgnoreCase("dt")) {
					// 大于
					if (SecType.equalsIgnoreCase("ge")) {
						sqlWhere += String.format(" and %s >= '%s'", field,
								entry.getValue()[0]);
					}
					// 小于
					else if (SecType.equalsIgnoreCase("le")) {
						sqlWhere += String.format(" and  %s <= '%s'", field,
								ToolDate.DateAddOne(entry.getValue()[0], 1));
					}
				}
			}
		}
		Page<Record> pageList = Db.paginate(page.getPage(), page.getRows(),
				"select * ", "from " + tableName + "  where " + sqlWhere
						+ " order by " + SplitSortStr(page.getSort()) + " "
						+ page.getOrder());
		// 特殊字段的处理方法
		// pageList = filedHandle(pageList,tableName);
		return pageList;
	}

	private static String SplitSortStr(String sort) {
		if (sort.endsWith(Constants.SQLFieldStr)) {
			int i = sort.indexOf(Constants.SQLFieldStr);
			return sort.substring(0, i);
		} else
			return sort;
	}

	/**
	 * 特殊字段的转换，更简单 将关联表的数据转化成单条查询
	 * 
	 * @param pageList
	 * @param tableName
	 * @param fields
	 */
	public static void fieldConvert(Page<Record> dg, String tableName,
			String[] fields) {
		Page<Record> pageList = dg;
		List<Record> rs = pageList.getList();
		for (Record r : rs) {
			for (String field : fields) {
				String code = r.get(field);
				String name = TableCode.dao.GetCodeName(tableName, field, code);
				r.set(field + Constants.SQLFieldStr, name);
			}

		}

	}

	private static final String ExcelPath = "ExportExcel";

	public static String exportExcel(Controller controller, String tableName)
			throws IOException, RowsExceededException, WriteException {
		String path = PathKit.getWebRootPath() + File.separator + ExcelPath
				+ File.separator;
		String filename = UUID.randomUUID().toString() + ".xls";
		File file = new File(path + filename);
		File parentFile = file.getParentFile();
		if (!parentFile.exists() && !parentFile.isDirectory()) {
			parentFile.mkdirs();
		}
		if (!file.exists()) {
			file.createNewFile();
		}
		// /导入时最多有1万行 只导首页
		PageHelper page = PageHelper.CreateFromController(controller);
		page.setPage(1);
		page.setRows(10000);
		Page<Record> dataPage = dataGrid(controller, tableName, page);
		List<Record> records = dataPage.getList();
		List<Record> exportDefines = Db
				.find("select * from export_excel where tablename=?  and col is not null ",
						tableName);
		OutputStream os = null;
		try {
			os = new FileOutputStream(file, true);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} // 是否追加
			// 创建工作薄
		WritableWorkbook workbook = Workbook.createWorkbook(os);
		WritableSheet sheet = workbook.createSheet("First Sheet", 0);
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd H:m:s");
		for (Record exportDefine : exportDefines) {
			int col = exportDefine.getInt("col");
			String lab = exportDefine.getStr("caption");
			String field = exportDefine.getStr("field");
			String lookupinfo = exportDefine.getStr("lookupinfo");
			String[] lookups = null;
			if (StrKit.notBlank(lookupinfo))
				lookups = lookupinfo.split(Constants.SplitStr);
			int type = exportDefine.getInt("type");
			sheet.addCell(new Label(col, 0, lab));
			int row = 1;
			for (Record record : records) {

				if (type == 0) // 直接写属性
					sheet.addCell(new Label(col, row, GetdataToStr(field,
							record)));
				else if (type == 1) // 读tablecode表
				{
					String showname = TableCode.dao.GetCodeName(tableName,
							field, GetdataToStr(field, record));
					sheet.addCell(new Label(col, row, showname));
				} else if (type == 2) // /寻找表
				{

					String sql = String.format("select %s from %s where %s=?",
							lookups);
					String val = GetdataToStr(field, record);
					// if(StrKit.isBlank(val)) continue;
					int key = (sql + val).hashCode();
					Object v = CacheKit.get("system", key);
					String showname;
					if (v == null) {
						showname = Db.queryStr(sql, record.get(field));
						CacheKit.put("system", key, showname);
					} else
						showname = (String) v;
					sheet.addCell(new Label(col, row, showname));
				} else if (type == 3) // /日期字段
				{
					Date dt = record.getDate(field);
					if (dt != null) {
						String showname = format.format(dt);
						sheet.addCell(new Label(col, row, showname));
					}
				}
				row++;
			}
		}
		workbook.write();
		workbook.close();
		if (os != null) {
			os.close();
		}
		return path + filename;
	}

	private static String GetdataToStr(String field, Record record) {
		Object v = record.get(field);
		if (v == null)
			return "";
		else
			return v.toString();
	}

}
