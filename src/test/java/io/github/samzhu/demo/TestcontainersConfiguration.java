package io.github.samzhu.demo;

import java.io.IOException;

import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.context.annotation.Bean;
import org.testcontainers.ollama.OllamaContainer;

@TestConfiguration(proxyBeanMethods = false)
class TestcontainersConfiguration {

	@Bean
	OllamaContainer ollama() throws UnsupportedOperationException, IOException, InterruptedException {
		OllamaContainer ollama = new OllamaContainer("ollama/ollama:0.1.43");
		return ollama;
	}

}
