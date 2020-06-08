package com.shop.common.jwt;

import com.shop.common.redis.RedisClient;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtBuilder;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.codec.binary.Base64;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * 描述: jwt 工具类
 */
@Slf4j
@Component
@PropertySource("classpath:constantConfig.properties")
public class JwtUtil {

    private static RedisClient redisClient;

    /**
     * 过期时间为一天
     * TODO 正式上线更换为15分钟
     */
    private static long EXPIRE_TIME;

    /**
     * token私钥
     */
    private static String TOKEN_SECRET;

    @Value("${token-time}")
    public void setExpireTime(long expireTime) {
        EXPIRE_TIME = expireTime;
    }

    @Value("${token-secret}")
    public void setTokenSecret(String tokenSecret) {
        TOKEN_SECRET = tokenSecret;
    }

    @Autowired
    public void setRedisClient(RedisClient redisClient) {
        JwtUtil.redisClient = redisClient;
    }

    /**
     * 由字符串生成加密key
     *
     * @return
     */
    public static SecretKey generalKey(){
        byte[] encodedKey = Base64.decodeBase64(TOKEN_SECRET);
        SecretKeySpec key = new SecretKeySpec(encodedKey, 0, encodedKey.length, "AES");

        return key;
    }

    /**
     * 创建jwt
     * @param userName
     * @param subject
     * @return
     * @throws Exception
     */
    public static String createJWT(String userName, String password, String subject) throws Exception {

        // 指定签名的时候使用的签名算法，也就是header那部分，jjwt已经将这部分内容封装好了。
        SignatureAlgorithm signatureAlgorithm = SignatureAlgorithm.HS256;

        // 生成JWT的时间
        long nowMillis = System.currentTimeMillis();
        Date now = new Date(nowMillis);
        //过期时间换算成毫秒
        EXPIRE_TIME = EXPIRE_TIME * 60 *1000;
        //过期时间
        Date date = new Date(nowMillis + EXPIRE_TIME);

        // 创建payload的私有声明（根据特定的业务需要添加，如果要拿这个做验证，一般是需要和jwt的接收方提前沟通好验证方式的）
        // 创建payload的私有声明（根据特定的业务需要添加，如果要拿这个做验证，一般是需要和jwt的接收方提前沟通好验证方式的）
        Map<String, Object> claims = new HashMap<>();
        claims.put("password", password);
        claims.put("userName", userName);
        //claims.put("nick_name", "X-rapido");

        // 生成签名的时候使用的秘钥secret，切记这个秘钥不能外露哦。它就是你服务端的私钥，在任何场景都不应该流露出去。
        // 一旦客户端得知这个secret, 那就意味着客户端是可以自我签发jwt了。
        SecretKey key = generalKey();

        // 下面就是在为payload添加各种标准声明和私有声明了
        JwtBuilder builder = Jwts.builder() // 这里其实就是new一个JwtBuilder，设置jwt的body
                .setClaims(claims)          // 如果有私有声明，一定要先设置这个自己创建的私有的声明，这个是给builder的claim赋值，一旦写在标准的声明赋值之后，就是覆盖了那些标准的声明的
                .setId(subject)                  // 设置jti(JWT ID)：是JWT的唯一标识，根据业务需要，这个可以设置为一个不重复的值，主要用来作为一次性token,从而回避重放攻击。
                .setIssuedAt(now)           // iat: jwt的签发时间
                .setIssuer("admin")          // issuer：jwt签发人
                .setSubject(subject)        // sub(Subject)：代表这个JWT的主体，即它的所有人，这个是一个json格式的字符串，可以存放什么userid，roldid之类的，作为什么用户的唯一标志。
                .signWith(signatureAlgorithm, key) // 设置签名使用的签名算法和签名使用的秘钥
                .setExpiration(date);  // 设置过期时间
        return builder.compact();
    }

    /**
     * 解密jwt
     *
     * @param jwt
     * @return
     * @throws Exception
     */
    public static Claims parseJWT(String jwt) throws Exception {
        SecretKey key = generalKey();  //签名秘钥，和生成的签名的秘钥一模一样
        Claims claims = Jwts.parser()  //得到DefaultJwtParser
                .setSigningKey(key)                 //设置签名的秘钥
                .parseClaimsJws(jwt).getBody();     //设置需要解析的jwt
        return claims;
    }

    /**
     * 检查token
     * @return
     */
    public static boolean checkToken(String token) throws Exception {
        //TODO 根据自己的业务修改
        Claims claims = JwtUtil.parseJWT(token);
        String subject = claims.getSubject();
        String userName = (String) claims.get("userName");
        String password = (String) claims.get("password");
            /*
                TODO 对jwt里面的用户信息做判断
                根据jwt中携带的用户信息验证用户存储在redis中的信息
             */
        JwtToken user = redisClient.get(subject, JwtToken.class);
        //用户新改了密码token失效
        if(!password.equals(user.getPassword()) || !userName.equals(user.getUserName())){
            return false;
        }
            /*
                获取token的过期时间，和当前时间作比较，如果小于当前时间，则token过期
             */
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date expiration = claims.getExpiration();
        log.info("======== token的过期时间："+df.format(expiration));
        Date now = new Date();
        //token 已过期 需要重新登录生成
        if(expiration.before(now)){
            return false;
        }
        return true;
    }

}
