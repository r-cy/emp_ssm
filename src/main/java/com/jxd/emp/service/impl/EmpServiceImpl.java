package com.jxd.emp.service.impl;

import com.jxd.emp.dao.IEmpDao;
import com.jxd.emp.model.Emp;
import com.jxd.emp.service.IEmpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @ClassName EmpServiceImpl
 * @Description TODO
 * @Author renchunyu
 * @Date 2020/10/16
 * @Version 1.0
 */
@Service
public class EmpServiceImpl implements IEmpService {
    @Autowired
    private IEmpDao empDao;
    @Override
    public List<Emp> getAll(String ename) {
        return empDao.selectAll(ename);
    }

    @Override
    public List<Emp> getByPage(int limit,int page, String ename) {
        int pageStart = limit * (page - 1);
        return empDao.selectByPage(pageStart,limit,ename);
    }

    @Override
    public boolean addEmp(Emp emp) {
        return empDao.insertEmp(emp);
    }
    @Override
    public boolean editEmp(Emp emp) {
        return empDao.editEmp(emp);
    }

    @Override
    public Emp selectByEmpno(int empno) {
        return empDao.selectEmpByEmpno(empno);
    }

    @Override
    public List<Map<String, Object>> getAllDept() {
        return empDao.selectAllDept();
    }
    @Override
    public List<Map<String, Object>> getAllJob() {
        return empDao.selectAllJob();
    }

    @Override
    public boolean deleteEmp(int[] empno) {
        return empDao.deleteById(empno);
    }

}
