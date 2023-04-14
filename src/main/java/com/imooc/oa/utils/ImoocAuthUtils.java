package com.imooc.oa.utils;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.util.Properties;

public class ImoocAuthUtils {

    public static void auth() throws FileNotFoundException, IOException {
        URL icodeConfig = ImoocAuthUtils.class.getResource("/icode.properties");
        if (icodeConfig == null) {
            throw new IllegalStateException("classpath下未发现icode.properties文件");
        } else {
            String icodePath = icodeConfig.getPath();
            new URLDecoder();
            icodePath = URLDecoder.decode(icodePath, "UTF-8");
            Properties properties = new Properties();
            properties.load(new FileInputStream(icodePath));
            String icode = properties.getProperty("icode");
            if (icode == null) {
                throw new IllegalStateException("请从PC课程详情页右侧获取正确的ICODE，在源码中找到icode.properties中配置");
            } else {
                URL url = new URL("https://apis.imooc.com?icode=" + icode);
                HttpURLConnection connection = (HttpURLConnection)url.openConnection();
                connection.setConnectTimeout(8192);
                connection.setReadTimeout(8192);
                connection.setRequestMethod("GET");
                int responseCode = connection.getResponseCode();
                if (responseCode != 200) {
                    throw new IllegalStateException("用户认证服务通信异常,异常状态码:" + responseCode);
                } else {
                    InputStream inputStream = connection.getInputStream();
                    byte[] buf = new byte[8192];
                    ByteArrayOutputStream baos = new ByteArrayOutputStream();
                    boolean var10 = false;

                    int len;
                    while((len = inputStream.read(buf)) != -1) {
                        baos.write(buf, 0, len);
                    }

                    baos.close();
                    String responseText = baos.toString();
                    if (!responseText.contains("1000")) {
                        throw new IllegalStateException("无效的icode,请从PC课程详情页右侧获取正确的icode，在源码中找到icode.properties重新配置");
                    }
                }
            }
        }
    }

}
