package com.jimini.yegerina.member.naverApi;

import org.springframework.stereotype.Component;

import com.github.scribejava.core.builder.api.DefaultApi20;

@Component
// @Component : Spring Framework에서 관리되는 빈을 정의하는 어노테이션.
//				NaverLoginApi클래스가 Spring컨테이너에 의해 관리되며, 다른 클래스에서 주입(Dependency Injection) 할수 있게 됨.

public class NaverLoginApi extends DefaultApi20 {
	// NaverLoginApi클래스는 DefaultApi20클래스를 상속
	// DefaultApi20클래스는 ScribeJava라는 OAuth라이브러리에서 제공하는 클래스로 OAuth 2.0프로토콜을 구현하는데 사용.
	
	protected NaverLoginApi(){
		// NaverLoginApi클래스의 생성자
		// 생성자가 비어있는 이유
		// 1. 디폴트 생성자 제어 : 클래스에 명시적으로 생성자를 정의할 경우, 자바 컴파일러는 디폴트 생성자(파라미터가 없는 생성자)를 자동으로 생성하지 않음.
		// 					 but 명시적으로 생성자를 만들 때, 디폴트 생성자를 함께 정의해주는 것이 좋음. 그렇지 않으면 명시적인 생성자만 사용할 수 있고, 외부에서 디폴트 생성자로 객체를 생성하는 것이 불가능해짐.
		// 2. 상속과 서브클래스에서의 확장 : 비어있는 생성자는 상속을 고려한 설계에서 유용하게 사용될수 있음.
		// 							서브클래스가 부모 클래스의 생성자를 호출할 떄, 비어있는 생성자를  호출하여 부모 클래스의 초기화 작업을 실행할 수 있음.
		// 3. 싱글톤 패턴 구현 : 외부에서 새로운 인스턴스를 생성하지 못하도록 하기 위해 생성자를 비워놓는 것이 일반적인 싱글톤 패턴의 구현 방식
		//				   NaverLoginApi클래스는 싱글톤 패턴을 사용하여 인스턴스를 관리.
		// 				      디폴트 생성자가 비어 있으므로 외부에서 새로운 인스턴스를 생성하는 것을 방지하고, InstanceHolder클래스 내부에서만 생성하도록함.
	}
	
	
	private static class InstanceHolder{
		// 싱글톤 패턴을 구현하기 위한 방법 Bill Pugh Singleton(Initialization-on-demand holder idiom)패턴을 사용.
		// 이 패턴을 사용하면 객체를 생성하는 시점을 지연시키고, 여러 스레드로부터 안전하게 인스턴스에 접근할 수 있는 방법을 제공.
		// InstanceHolder는 NaverLoginApi클래스 내부에 정의된 private정적 내부 클래스
		// 내부 클래스를 사용하는 이유는 클래스 로딩 시점을 지연시키고, 스레드 안전성을 보장하기 위해서.

		private static final NaverLoginApi INSTANCE = new NaverLoginApi();
			// InstanceHolder 내부에서 선언된 정적 상수 INSTANCE는 NaverLoginApi의 싱글톤 인스턴스를 저장함.
			// 이 인스턴스는 클래스가 처음 로딩될 때 생성되며, 이후에는 해당 클래스 내부에서만 접근 할 수 있음.
	}
	
	
	public static NaverLoginApi instance(){
		// instance()메서드는 public으로 선언되어 있어 외부에서 호출 할 수 있음.
		// 이 메서드를 통해 NaverLoginApi클래스의 싱글톤 인스턴스를 얻을 수 있음.
		// instance()메서드를 통해 싱글톤 인스턴스를 얻을수 있기 때문에 어플리케이션 내에서 여러 곳에서 NaverLoginApi인스턴스를 생성하지 않고
		// 항상 동일한 인스턴스를 공유하여 사용할수 있음.
		// 이렇게 하면 메모리 사용ㅇ르 절약하고 객체의 일관성을 유지할 수 있음.
		
		return InstanceHolder.INSTANCE;
			// InstanceHolder.INSTANCE는 내부 정적 클래스 InstanceHolder에 선언된 NaverLoginApi의 정적 상수 INSTANCE를 반환.
			// 이 정적 상수는 NaverLoginApi클래스의 싱글톤 인스턴스를 참조.
			// INSTANCE는 InstanceHolder클래스가 초기화될 때(클래스가 로딩될 때) 생성되며, 이후에는 여기에서 반환되기 때문에 항상 동일한 인스턴스를 반환.
	}
	
	
	@Override
	// @Override어노테이션은 메서드가 부모 클래스나 인터페이스에서 상속받은 메서드를 재정의(오버라이드)하고 있음을 나타냄
	public String getAccessTokenEndpoint() {
		// getAccessTokenEndpoint()메서드는 OAuth2.0인증 프로세스에서 사용되는 인증코드(authorization code)를 기반으로 
		// 액세스 토큰(access token)을 얻기위한 엔드포인트(Endpoint)URL을 반환하는 메서드.
		// 이 메서드는 DefaultApi20클래스를 상속한 클래스에서 구현되는 메서드중 하나로 해당 API공급자(네이버)의 엔드포인트 URL을 정의.
		// 이 메서드는 문자열(String)형태의 URL을 반환하며, 반환되는 URL은 OAuth2.0인증 프로세스의 일부로서 액세스 토큰을 얻기 위한 엔드포인트를 나타냄.
		
		return "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code";
			// 네이버 OAuth2.0의 토큰을 얻기 위한 엔드포인트 URL을 문자열 형태로 반환하고 있음.
			// 반환하는 URL을 사용하여 네이버 서버에서 사용자의 인증코드를 교환하여 액세스 토큰을 얻을수 있음.
			// grant_type=authorization_code : 인증코드 그랜트 타입을 나타내며, OAuth2.0인증 프로세스에서 사용됨.
	}
	
	
	@Override
	protected String getAuthorizationBaseUrl() {
		// getAuthorizationBaseUrl()메서드는 OAuth2.0인증 프로세스에서 사용자를 네이버 로그인 페이지로 리디렉션하기 위한 인증 기반 URL을 반환하는 메서드.
		// 이 메서드는 DefaultApi20클래스를 상속한 클래스에서 구현되는 메서드 중 하나로, 해당 API공급자(네이버)의 인증기반 URL을 정의.
		// 이 메서드는 protected로 선언되어 있기 때문에 외부에서 직접 호출할 수 없으며, 하위 클래스에서 재정의하여 사용하도록 되어 있음.
		
		return "https://nid.naver.com/oauth2.0/authorize";
			// 반환하는 URL을 사용하여 사용자를 네이버 로그인페이지로 리디렉션하여 인증 및 권한 부여를 요청할 수 있음.
	}
}

