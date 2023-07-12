package ltd.newbee.mall.api.mall;

import io.swagger.annotations.Api;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@RestController
@Api(tags = "健康接口")
@RequestMapping("/")
public class Healthy {
    @GetMapping("/")
    public String sayHello() throws InterruptedException {
        System.out.println("Health check!");
        return "Hello I am here";
    }

    @GetMapping("/gc")
    public String gc() throws InterruptedException {
        for(int i = 0; i < 10; i++) {
            System.out.println("Run GC");
            Thread.sleep(2000);
            System.gc();
        }
        return "Run GC!";
    }

    @GetMapping("/heap")
    public String heap() throws InterruptedException {
        int count = 0;
        List list = new ArrayList();
        while(count < 5000000){
            list.add(new Object());
            System.out.println("Count = " + ++count);
        }
        return "heap high!";
    }

}
