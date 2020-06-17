package com.onwardpath.wem;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Component
@ConfigurationProperties("app")
public class AppProperties {
 
 private String matomo_url;
 private String matomo_token_auth;
 
public String getMatomo_url() {
	return matomo_url;
}
public void setMatomo_url(String matomo_url) {
	this.matomo_url = matomo_url;
}
public String getMatomo_token_auth() {
	return matomo_token_auth;
}
public void setMatomo_token_auth(String matomo_token_auth) {
	this.matomo_token_auth = matomo_token_auth;
}

}