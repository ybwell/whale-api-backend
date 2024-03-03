package com.ybwell.whaleapiclientsdk;

import com.ybwell.whaleapiclientsdk.client.WhaleApiClient;
import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

/**
 * YuApi 客户端配置
 *
 */
@Configuration
@ConfigurationProperties("whaleapi.client")
@Data
@ComponentScan
public class WhaleApiClientConfig {

    private String accessKey;

    private String secretKey;

    @Bean
    public WhaleApiClient whaleApiClient() {
        return new WhaleApiClient(accessKey, secretKey);
    }

}
