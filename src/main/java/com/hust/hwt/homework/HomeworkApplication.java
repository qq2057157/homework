package com.hust.hwt.homework;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

@RestController
@SpringBootApplication
@MapperScan("com.hust.hwt.homework.mapper")
@EnableCaching
public class HomeworkApplication {
    @RequestMapping("/")
    public String index(){
        return "Hello Spring boot";
    }
    public static void main(String[] args) {
        SpringApplication.run(HomeworkApplication.class, args);
    }
}
