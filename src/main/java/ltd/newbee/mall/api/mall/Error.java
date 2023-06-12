package ltd.newbee.mall.api.mall;

import io.swagger.annotations.Api;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Calendar;

@RestController
@Api(tags = "报错接口")
@RequestMapping("/error")
public class Error {
    @GetMapping("/downgrade")
    public String error() throws InterruptedException {
        double r = Math.random();
        if (r > 0.8) {
            System.out.println("Downgrade error occurs");
            throw new RuntimeException("Downgrade error occurs!");
        }
        Calendar cal = Calendar.getInstance();
        int hour = cal.get(Calendar.HOUR_OF_DAY);
        int minute = cal.get(Calendar.MINUTE);
        int sec = cal.get(Calendar.SECOND);

        String msg = "目前服务正常，无服务降级！" + hour + "时" + minute + "分" + sec + "秒";
        System.out.println(msg);
        return msg;
    }
}
