package com.jxd.emp.model;

/**
 * @ClassName Users
 * @Description TODO
 * @Author renchunyu
 * @Date 2020/10/20
 * @Version 1.0
 */
public class Users {
    private String uname;
    private String pwd;

    public String getUname() {
        return uname;
    }

    public void setUname(String uname) {
        this.uname = uname;
    }

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    public Users() {
    }

    public Users(String uname, String pwd) {
        this.uname = uname;
        this.pwd = pwd;
    }
}
