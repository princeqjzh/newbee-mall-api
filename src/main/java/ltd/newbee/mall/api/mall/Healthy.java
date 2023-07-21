package ltd.newbee.mall.api.mall;

import io.swagger.annotations.Api;
import org.springframework.web.bind.annotation.*;

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

    @GetMapping("/long")
    public String longTime() throws InterruptedException {
        System.out.println("It takes long time!");
        Thread.sleep(10000);
        return "Take long time";
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
