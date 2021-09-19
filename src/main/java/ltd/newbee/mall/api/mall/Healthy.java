package ltd.newbee.mall.api.mall;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Api(tags = "健康接口")
@RequestMapping("/")
public class Healthy {
    @GetMapping("/")
    @ApiOperation(value = "我的收货地址列表", notes = "")
    public String sayHello() {
        return "Hello I am here";
    }
}
