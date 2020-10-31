package com.jxd.emp.dao;

import com.jxd.emp.model.Emp;
import org.apache.ibatis.annotations.Param;


import java.util.List;
import java.util.Map;

public interface IEmpDao {
    /**
     * 查询全部的员工信息
     * @return
     */
    List<Emp> selectAll(@Param("ename")String ename);

    List<Emp> selectByPage(@Param("pageStart") int pageStart,@Param("pageSize") int pageSize,@Param("ename") String ename);

    boolean insertEmp(Emp emp);
    boolean editEmp(Emp emp);

    /**
     * 根据员工编号查询员工对象
     * @param empno
     * @return
     */
    Emp selectEmpByEmpno(int empno);

    List<Map<String,Object>> selectAllDept();
    List<Map<String,Object>> selectAllJob();

    /**
     * 根据员工编号批量删除
     * @param empno
     * @return
     */
    boolean deleteById(int[] empno);
}
