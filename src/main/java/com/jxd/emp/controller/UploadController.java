package com.jxd.emp.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

/**
 * @ClassName UploadController
 * @Description TODO
 * @Author renchunyu
 * @Date 2020/10/22
 * @Version 1.0
 */
@Controller
//@RequestMapping("/upload")  //给后台请求路径再加一层
public class UploadController {
    @RequestMapping("/getUpload")
    public String getUpload(){
        return "upload";
    }

    @RequestMapping("/upload")
    public  String upload(@RequestParam("txtfile") MultipartFile file) throws IOException {    //@RequestParam("txtfile") 前台文件input name属性名
        //确定文件上传位置
        String path = "C:\\Users\\cat\\Pictures\\Camera Roll";
        //判断文件夹是否存在，如果不存在则创建新的
        File file_save = new File(path);
        if (!file_save.exists()){
            //创建目录
            file_save.mkdir();
        }

        //处理文件名，添加UUID，保证每个文件名全局唯一
        //获取原文件名
        String fname_old = file.getOriginalFilename();
        //获取UUID，全局唯一的32位字符串，包含数字字母和-
        String uuid = UUID.randomUUID().toString();

        System.out.println(uuid);

        String fname_new = uuid + "_" + fname_old;

        //保存文件到服务器
        File file_final = new File(path,fname_new);
        //输出过程
        file.transferTo(file_final);
        return "upload";
    }

    @RequestMapping("/toImgUpload")
    public String toImgUpload(){
        return "imageUpload";
    }

    @RequestMapping(value = "/imgUpload",produces = "text/html;charset=utf-8")
    @ResponseBody
    public  String imgUpload(@RequestParam("photo") MultipartFile file) throws IOException {    //@RequestParam("txtfile") 前台文件input name属性名
        //确定文件上传位置
        String path = "C:\\Users\\cat\\Desktop\\images";
        //判断文件夹是否存在，如果不存在则创建新的
        File file_save = new File(path);
        if (!file_save.exists()){
            //创建目录
            file_save.mkdir();
        }

        //处理文件名，添加UUID，保证每个文件名全局唯一
        //获取原文件名
        String fname_old = file.getOriginalFilename();
        //获取UUID，全局唯一的32位字符串，包含数字字母和-
        String uuid = UUID.randomUUID().toString();
        System.out.println(uuid);
        String fname_new = uuid + "_" + fname_old;

        //保存文件到服务器
        File file_final = new File(path,fname_new);
        //输出过程
        file.transferTo(file_final);
        return fname_new;
    }

    @RequestMapping("/delImg")
    @ResponseBody
    public String delImg(String imgName){
        String path = "C:\\Users\\cat\\Desktop\\images";
        File file = new File(path,imgName);

        if (!file.exists()){
            //文件不存在
            return "none";
        }
        if (file.delete()){
            return "success";
        }else{
            return "fail";
        }
    }
}
