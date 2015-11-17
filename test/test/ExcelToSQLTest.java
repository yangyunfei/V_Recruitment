package test;

import java.io.File;

import org.apache.log4j.Logger;
import org.junit.Test;

import com.jfinal.kit.StrKit;
import com.lianjia.model.School;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import testmodel.JFinalModelCase;

public class ExcelToSQLTest extends JFinalModelCase
{
	
	private static Logger log = Logger.getLogger(ExcelToSQLTest.class);
	
	@Test
	
	public void transToSql()
	{
		try 
		{
			File file= new File("E:\\链家地产学校档位分类标准（助理版）.xls");
			Workbook book=
					Workbook.getWorkbook(file);
			//获得第一个工作表对象
			Sheet sheet=book.getSheet(0);
			int rows = sheet.getRows();
			for (int i = 1; i < rows ; i++)
			{	
				School school = new School();
				Cell[] row = sheet.getRow(i);
				
				//name
				Cell cellA = row[0];
				String name = cellA.getContents();
				school.set("name", name);					
				
				
				//alias
				Cell cellB = row[1];
				String alias = cellB.getContents();
				if (StrKit.notBlank(alias))
				{
					school.set("alias", alias);
				}
			
				//manage_department 
				Cell cellC = row[2];
				String manage_department = cellC.getContents();
				if (StrKit.notBlank(manage_department))
				{
					school.set("manage_department", manage_department);
				}
				
				
				//location
				Cell cellD = row[3];			
				String location = cellD.getContents();
				if (StrKit.notBlank(location))
				{
					school.set("location", location);
				}
				
				//education_level
				Cell cellE = row[4];
				String education_level = cellE.getContents();
				if (StrKit.notBlank(education_level))
				{
					school.set("education_level", education_level);
				}
			
				
				//school_property
				Cell cellF = row[5];
				String school_property = cellF.getContents();
				if (StrKit.notBlank(school_property))
				{
					school.set("school_property", school_property);
				}
				
				//is211
				Cell cellG = row[6];
				String is211 = cellG.getContents();
				if (StrKit.notBlank(is211))
				{
					school.set("is211", is211);
				}
				
				//is985
				Cell cellH = row[7];
				String is985 = cellH.getContents();
				if (StrKit.notBlank(is985))
				{
					school.set("is985", is985);
				}
				
				//isKeyUniversity   
				Cell cellI = row[8];
				String isKeyUniversity = cellI.getContents();
				if (StrKit.notBlank(isKeyUniversity))
				{
					school.set("isKeyUniversity", isKeyUniversity);
				}
				
				//flag_H_college
				Cell cellJ = row[9];
				String flag_H_college = cellJ.getContents();
				if (StrKit.notBlank(flag_H_college))
				{
					school.set("flag_H_college", flag_H_college);
				}
				
				//lianjia_index
				Cell cellk = row[10];
				String lianjia_index = cellk.getContents();
				if (StrKit.notBlank(lianjia_index))
				{
					school.set("lianjia_index", lianjia_index);
				}
				
				//wenti
				Cell celll = row[11];
				String wenti = celll.getContents();
				if (StrKit.notBlank(wenti))
				{
					school.set("wenti",wenti);
				}
				
				//school_level
				Cell cellM = row[12];
				String school_level = cellM.getContents();
				if (StrKit.notBlank(school_level))
				{
					school.set("school_level", school_level);
				}
				
				//comebine_name
				Cell cellN = row[13];
				String comebine_name = cellN.getContents();
				if (StrKit.notBlank(comebine_name))
				{
					school.set("comebine_name", comebine_name);
				}
				
				school.save();
			}
			
			book.close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
