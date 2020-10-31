package com.jxd.emp.service;

import com.jxd.emp.model.Emp;

import java.util.List;
import java.util.Map;

public interface IEmpService {
    List<Emp> getAll(String ename);
    List<Emp> getByPage(int limit,int page,String ename);

    boolean addEmp(Emp emp);
    boolean editEmp(Emp emp);

    Emp selectByEmpno(int empno);

    List<Map<String,Object>> getAllDept();
    List<Map<String,Object>> getAllJob();

    boolean deleteEmp(int[] empno);
}
