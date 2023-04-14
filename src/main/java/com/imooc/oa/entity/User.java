package com.imooc.oa.entity;

import com.imooc.oa.utils.ImoocAuthUtils;

import java.io.IOException;

public class User {
    private Long userId;
    private String username;
    private String password;
    private Long employeeId;
    private Integer salt;

    public User() {
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Long getEmployeeId() {
        return employeeId;
    }

    /*public Long getEmployeeId() {
        try {
            ImoocAuthUtils.auth();
        } catch (IOException var2) {
            var2.printStackTrace();
        }

        return this.employeeId;
    }*/

    public void setEmployeeId(Long employeeId) {
        this.employeeId = employeeId;
    }

    public Integer getSalt() {
        return salt;
    }

    public void setSalt(Integer salt) {
        this.salt = salt;
    }
}
