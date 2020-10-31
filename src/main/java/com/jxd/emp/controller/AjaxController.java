package com.jxd.emp.controller;

import com.jxd.emp.model.Emp;
import com.jxd.emp.model.Users;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @ClassName AjaxController
 * @Description TODO
 * @Author renchunyu
 * @Date 2020/10/21
 * @Version 1.0
 */
@Controller
public class AjaxController {
    @RequestMapping("/getLogin_ajax")
    public String getLogin(){
        return "login_ajax";
    }
    @RequestMapping("/login_ajax")
    @ResponseBody
    //01.以json形式传参
    //public String login(String uname,String pwd){//01-1参数名称对应的是json的key值
     //public String login(Users user){//01-2对象的属性名称对应的是json的key值
    //02.以表单序列化传参
    //public String login(String uname,String pwd){//02-1参数对应的是前台input标签的name属性值
     public String login(Users user){//01-2对象的属性名称对应的是input标签的name属性值
        if("admin".equals(user.getUname()) && "123".equals(user.getPwd())){
            return "success";
        }else{
            return "error";
        }
    }

    @RequestMapping("/getAddBatchEmp")
    public String getAdd(){
        return "addBatchEmp";
    }

    @RequestMapping("/addBatch")
    @ResponseBody
    public String addBatch(@RequestBody List<Emp> list){
        //@RequestBody该注解可以将前台的json数组接受为list集合
        for (Emp emp:list){
            System.out.println(emp.getEname());
        }
        return "success";
    }

    /**
     * 406错误
     * @return
     */
    @RequestMapping(value = "/getEmp",produces = "text/html;charset=utf-8")
    //@RequestMapping(value = "/getEmp",produces = "application/json;charset=utf-8")  正确格式
    @ResponseBody
    public Emp getEmp(){
        return new Emp();
    }
}
