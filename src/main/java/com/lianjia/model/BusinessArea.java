package com.lianjia.model;

import java.util.List;

import com.jfinal.plugin.activerecord.Model;

/**
* 行政区域表
*
*/
public class BusinessArea extends Model<BusinessArea> {

  private static final long serialVersionUID = 1664358438189417556L;

  public static final BusinessArea dao = new BusinessArea();

  public String getBusinessAreaName(int id) {
    BusinessArea ba = dao.findFirst("select name from business_area where id=?", id);
    return ba == null ? null : ba.getStr("name");
  }


  /**
   * 通过id获取商圈code
   * @param businessId
   * @return
   */
  public BusinessArea getBusinessCode(int businessId) {
    return dao.findFirst("select code from business_area where id = ? ", businessId);
  }

  /**
   * 获取所有商圈
   * @return
   */
  public List<BusinessArea> findAllBusinessAreas() {
    return dao
      .find("select id,name,fid,code,level,is_key_circle from business_area");
  }
}
