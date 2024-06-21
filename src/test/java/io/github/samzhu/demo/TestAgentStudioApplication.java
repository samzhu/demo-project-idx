package io.github.samzhu.demo;

import org.springframework.boot.SpringApplication;

public class TestAgentStudioApplication {

	public static void main(String[] args) {
		SpringApplication.from(DemoApplication::main).with(TestcontainersConfiguration.class).run(args);
	}

}
