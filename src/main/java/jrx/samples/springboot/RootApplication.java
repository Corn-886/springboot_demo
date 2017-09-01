package jrx.samples.springboot;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * Created by yxy on 2017/3/15.
 */
@SpringBootApplication
public class RootApplication {

    public static void main(String[] args) {
        SpringApplication app = new SpringApplication(RootApplication.class);
        app.run(args);
    }

}
