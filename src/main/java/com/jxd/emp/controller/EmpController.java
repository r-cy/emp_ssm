package com.jxd.emp.controller;

import com.jxd.emp.model.Emp;
import com.jxd.emp.model.Users;
import com.jxd.emp.service.IEmpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @ClassName EmpController
 * @Description TODO
 * @Author renchunyu
 * @Date 2020/10/16
 * @Version 1.0
 */
@Controller
@SessionAttributes({"uname","pwd"})    //将model中的数据存放到session对象中
public class EmpController {
    @Autowired
    private IEmpService empService;

    @RequestMapping("/hello")
    @ResponseBody
    public String hello(){
        return "hello";
    }
    //通过后台请求跳转到前台页面    不加@ResponseBody的情况下会进行页面的转发，即把return值交给视图解析器
    @RequestMapping("/getLogin")
    public String getLogin(){
        return "login";
    }

    @RequestMapping("/login")
    public String login(Model model, Users users){   //或者接收为单个参数
        //判断用户名是否存在
        //调用service
        if("admin".equals(users.getUname()) && "123".equals(users.getPwd())){
            //登陆成功，跳转列表页面
            model.addAttribute("uname",users.getUname());
            return "emplist";
        }else{
            //登陆失败，跳转登录界面，并且给出提示信息
            model.addAttribute("msg","用户名或者密码错误");
            return "login";
        }
    }


    //用于跳转列表界面
    @RequestMapping("/getEmpList")
    public String getEmpList(){
        return "empList";
    }
    @RequestMapping("/getAllEmp")
    @ResponseBody
    public Map<String,Object> getAllEmpByPage(int limit,int page,@RequestParam("ename") String empName){
        //page和limit为layui表格默认传递的参数，我们在SpringMVC中获取时直接接收为int类型即可
        List<Emp> list = empService.getAll(empName);
        List<Emp> list_page = empService.getByPage(limit,page,empName);
        Map<String,Object> map = new HashMap<>();
        map.put("code",0);
        map.put("msg","");
        map.put("count",list.size());
        map.put("data",list_page);
        return map;
    }

    //用于跳转到新增页面
    @RequestMapping("/getAddEmp")
    public String getAddEmp(){
        return "addEmp";
    }

    //新增员工的操作
    @RequestMapping(value = "/addEmp",produces = "text/html;charset=utf-8")  //如果向前台响应汉字时，需要设置响应编码字符集
    @ResponseBody
    public String addEmp(Emp emp){
        boolean flae = empService.addEmp(emp);
        if (flae){
            return "新增员工成功";
        }else {
            return "新增失败";
        }
    }
    @RequestMapping(value = "/editEmp",produces = "text/html;charset=utf-8")  //如果向前台响应汉字时，需要设置响应编码字符集
    @ResponseBody
    public String editEmp(Emp emp){
        boolean flae = empService.editEmp(emp);
        if (flae){
            return "重编辑员工信息成功";
        }else {
            return "重编辑员工信息失败";
        }
    }

    //获取全部的部门编号
    @RequestMapping("/getAllDept")
    @ResponseBody
    public List getAllDept(){
        return empService.getAllDept();
    }
    @RequestMapping("/getAllJob")
    @ResponseBody
    public List getAllJob(){
        return empService.getAllJob();
    }

    //根据员工编号获取一个员工对象
    @RequestMapping("/getEmpById")
    public String getEmpById(Model model,int empno){
        Emp emp = empService.selectByEmpno(empno);
        //将emp传递给前台页面
        model.addAttribute("emp",emp);
        return "editEmp";
    }

    @RequestMapping("/deleteEmp")
    @ResponseBody
    public String deleteEmp(int[] empno){     //参数名称要与前台的请求参数完全对应
            //请求路径形式 deleteEmp?empno=1&empno=2这种形式时，可以直接接收为数组对象  {1，2}
        boolean flag = empService.deleteEmp(empno);
        if (flag){
            return "success";
        }else {
            return "error";
        }
    }






    //前台请求路径为delEmp/3/张三
    @RequestMapping("/delEmp/{empno}/{ename}")
    public String delEmp(@PathVariable("empno") int empno){
        return "";
    }

    /**
     * 一个请求到另一个请求
     * @return
     */
    @RequestMapping("/goOtherController1")
    public String goOtherController1(){
        //重定向到getLogin
        return "redirect:getLogin";
    }
    @RequestMapping("/goOtherController2")
    public String goOtherController2(){
        //转发
        return "forward:getLogin";
    }

    /**
     * 返回值为void，执行完对应操作后，会返回到发送请求的地方
     */
    @RequestMapping("test")
    public void test(){

    }

    //传值方式一
    //直接将数据返回
    /*@RequestMapping("/getAllEmp")
    @ResponseBody
    public List<Emp> getAllEmp(){
        //获取所有的员工对象
        List<Emp> list = empService.getAll();
        return list;
    }*/

    //传值方式二
    @RequestMapping("/getWelcome")
    public String getWelcome(Model model,String username){
        //往前台页面响应数据
        model.addAttribute("msg","欢迎您");

        System.out.println(username);
        return "welcome";
    }


}
