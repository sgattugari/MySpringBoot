package com.lab.model;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Created by debashisghosh on 11/6/16.
 */
@Configuration
public class Location {
    private String country = "USA";
    @Bean
public String getCountry() {
	return country;
}
public void setCountry(String country) {
	this.country = country;
}
}
