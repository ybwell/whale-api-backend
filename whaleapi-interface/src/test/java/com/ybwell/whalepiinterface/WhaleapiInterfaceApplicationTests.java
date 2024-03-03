package com.ybwell.whalepiinterface;

import com.ybwell.whaleapiclientsdk.client.WhaleApiClient;
import com.ybwell.whaleapiclientsdk.model.User;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;

/**
 * 测试类
 *
 */
@SpringBootTest
class WhaleapiInterfaceApplicationTests {

    @Resource
    private WhaleApiClient whaleApiClient;

    @Test
    void contextLoads() {
        String result = whaleApiClient.getNameByGet("Aniya");
        User user = new User();
        user.setUsername("Aniya");
        String usernameByPost = whaleApiClient.getUsernameByPost(user);
        System.out.println(result);
        System.out.println(usernameByPost);
    }

}
