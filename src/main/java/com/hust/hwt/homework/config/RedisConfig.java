package com.hust.hwt.homework.config;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.PropertyAccessor;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.AutoConfigureAfter;
import org.springframework.boot.autoconfigure.data.redis.RedisAutoConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;
import org.springframework.core.env.MapPropertySource;
import org.springframework.data.redis.connection.RedisClusterConfiguration;
import org.springframework.data.redis.connection.RedisNode;
import org.springframework.data.redis.connection.lettuce.LettuceConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.GenericJackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.Jackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.StringRedisSerializer;

import javax.annotation.Resource;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Configuration
@AutoConfigureAfter(RedisAutoConfiguration.class)
public class RedisConfig {
    //@Resource
    //private LettuceConnectionFactory myLettuceConnectionFactory;

    @Bean
    public RedisTemplate<String, Object> getTemplate(LettuceConnectionFactory redisConnectionFactory){
        //redis序列化器
         //Jackson2JsonRedisSerializer<Object> jackson2JsonRedisSerializer = new Jackson2JsonRedisSerializer<>(Object.class);
         //ObjectMapper om = new ObjectMapper();
         //om.setVisibility(PropertyAccessor.ALL, JsonAutoDetect.Visibility.ANY);
         //om.enableDefaultTyping(ObjectMapper.DefaultTyping.NON_FINAL);
         //jackson2JsonRedisSerializer.setObjectMapper(om);
         RedisTemplate<String, Object> template = new RedisTemplate<>();
         template.setConnectionFactory(redisConnectionFactory);
         template.setKeySerializer(new StringRedisSerializer());
         template.setValueSerializer(new StringRedisSerializer());
         template.setHashKeySerializer(new StringRedisSerializer());
         template.setStringSerializer(new StringRedisSerializer());
         template.setHashValueSerializer(new StringRedisSerializer());
         return template;
    }
}